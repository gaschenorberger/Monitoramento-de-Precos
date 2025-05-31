from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException, NoSuchElementException
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys
import os
import time
from bs4 import BeautifulSoup
import requests
from datetime import date
import psycopg2
import random




#VERSÃO 2 SEM LINHAS COMENTADAS
#CONFORME FOR ATUALIZANDO AQUI, VOU ADICIONANDO LA E COMENTANDO 

#------------------------------

'''Marketplaces e Varejistas
Amazon (www.amazon.com.br)
Mercado Livre (www.mercadolivre.com.br)
Americanas (www.americanas.com.br)
Magazine Luiza (www.magazineluiza.com.br)
Submarino (www.submarino.com.br)
Casas Bahia (www.casasbahia.com.br)
Ponto (ex-Ponto Frio) (www.pontofrio.com.br)
Extra (www.extra.com.br)
Lojas Especializadas
Kabum (eletrônicos e hardware) (www.kabum.com.br)
TerabyteShop (hardware e tecnologia) (www.terabyteshop.com.br)
Pichau (componentes de PC) (www.pichau.com.br)
Dell (computadores e acessórios) (www.dell.com.br)'''



def inserirDados(produto_nome, loja_nome, preco, link_produto, href_img):
    try:
        conexao = psycopg2.connect(
            dbname='precoCerto',
            user='postgres',
            password='123',
            host='localhost',
            port='5432'
        )
        cursor = conexao.cursor()

        # Verifica ou cria produto
        produto_id = obter_ou_criar(cursor, 'produtos', produto_nome)

        # Verifica ou cria loja
        loja_id = obter_ou_criar(cursor, 'lojas', loja_nome)

        # Insere na tabela de preços
        cursor.execute("""
            INSERT INTO precos (produto_id, loja_id, preco, link_produto, href_img, data_captura)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (produto_id, loja_id, preco, link_produto, href_img, date.today()))

        conexao.commit()

        print(f"✅ Dados inseridos: {produto_nome} | {preco} | {loja_nome}\n")

    except Exception as erro:
        print(f"❌ Erro ao inserir dados: {erro}")

    finally:
        cursor.close()
        conexao.close()

def obter_ou_criar(cursor, tabela, nome):
    cursor.execute(f"SELECT id FROM {tabela} WHERE nome = %s", (nome,))
    resultado = cursor.fetchone()
    if resultado:
        return resultado[0]
    else:
        cursor.execute(f"INSERT INTO {tabela} (nome) VALUES (%s) RETURNING id", (nome,))
        return cursor.fetchone()[0]

def esperar_elemento(navegador, xpath, tempo=10):
    """
    Espera até que um elemento esteja presente na página, usando o XPath fornecido.

    :param navegador: Instância do navegador Selenium.
    :param xpath: XPath do elemento a ser aguardado.
    :param tempo: Tempo máximo de espera em segundos (padrão: 10).
    :return: Lista de elementos encontrados ou None se não encontrar.
    """
    try:
        elementos = WebDriverWait(navegador, tempo).until(
            EC.presence_of_all_elements_located((By.XPATH, xpath))
        )
        return elementos
    except Exception as e:
        print(f"Erro ao esperar pelo elemento: {e}")
        return None

def iniciar_chrome(url, headless='off'):
    options = webdriver.ChromeOptions()
    options.add_argument("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36")
    options.add_argument("--disable-extensions")
    options.add_argument("--start-maximized")
    
    if headless == 'on':
        options.add_argument("--headless")

    navegador = webdriver.Chrome(options=options)
    navegador.get(url)

    return navegador



#-------------------------------ÁREA PRINCIPAL---------------------------

def coletaDadosAmazon(): # OK

    navegador = iniciar_chrome(url='https://www.amazon.com.br/gp/bestsellers', headless='off')

    WebDriverWait(navegador, 10).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    if esperar_elemento(navegador, '//*[@id="nav-hamburger-menu"]'):
        print()
    else:
        navegador.refresh()

    #Tópicos

    wait = WebDriverWait(navegador, 20)

    secaoComputadores = wait.until(EC.element_to_be_clickable((By.XPATH, "//a[text()='Computadores']")))
    secaoComputadores.click()

    time.sleep(2)

    esperar_elemento(navegador, "//div[contains(@class, 'a-cardui dcl-product')]")

    secao = navegador.find_element(By.XPATH, "//div[contains(@class, 'a-cardui dcl-product')]") 
    produtos = secao.find_elements(By.XPATH, "//span[contains(@class, 'dcl-truncate dcl-product-label')]//span")
    reais = secao.find_elements(By.XPATH, "//span[contains(@class, 'a-price-whole')]")
    centavos = secao.find_elements(By.XPATH, "//span[contains(@class, 'a-price-fraction')]")
    linkProduto = navegador.find_elements(By.XPATH, "//div[contains(@class, 'a-cardui dcl-product')]//a")
    imgProduto = navegador.find_elements(By.XPATH, "//div[contains(@class, 'dcl-product-image-container')]//img")
    
    if produtos:

        for produto, real, centavo, link, imgLink  in zip(produtos[:3], reais, centavos, linkProduto, imgProduto):

            urlProduto = link.get_attribute('href')
            urlImg = imgLink.get_attribute('src')
            produto = produto.text
            
            if centavos:
                real = real.text
                centavo = centavo.text
                preco = f'{real},{centavo}'
                
            else:
                preco = f'{real.text},00'

            print(f"{produto.upper()} | {preco}")
            print(f'LINK: {urlProduto}')
            print(f'IMG: {urlImg}\n')
            
            inserirDados(produto, "Amazon", preco, urlProduto, urlImg)

def coletaDadosMerLivre(): # OK -- IMPLEMENTAR BANCO

    navegador = iniciar_chrome(url='https://www.mercadolivre.com.br/c/informatica#menu=categories', headless='off')

    wait = WebDriverWait(navegador, 20)

    esperar_elemento(navegador, "//section[contains(@class, 'dynamic-carousel-normal-desktop')]")
    
    # SECTION PRODUTOS

    esperar_elemento(navegador, "//div[contains(@class, 'dynamic-carousel__item-container')]")
    divProdutos = navegador.find_element(By.XPATH, "//div[contains(@class, 'dynamic-carousel__item-container')]")

    produtos = divProdutos.find_elements(By.XPATH, "//h3[contains(@class, 'dynamic-carousel__title')]") 
    precos = divProdutos.find_elements(By.XPATH, "//div[contains(@class, 'dynamic-carousel__price-block')]//span")
    centavos = divProdutos.find_elements(By.XPATH, "//div[contains(@class, 'dynamic-carousel__price-block')]//span//sup")
    imgProduto = navegador.find_elements(By.XPATH, "//div[contains(@class, 'dynamic-carousel__link-container')]//img")
    linkProduto = navegador.find_elements(By.XPATH, "//div[contains(@class, 'dynamic-carousel__item-container')]//a[contains(@class, 'splinter-link')]")

    for produto, preco, centavo, img, link in zip(produtos[:3], precos, centavos[:3], imgProduto, linkProduto):

        produto = produto.text
        preco = preco.text
        centavo = centavo.text
    
        urlProduto = link.get_attribute('href')
        urlImg = img.get_attribute('src')
 
        if centavo:
            print(f"{produto.upper()} || R$ {preco},{centavo}")
        else:
            print(f"{produto.upper()} || R$ {preco},00")

        print(f'LINK: {urlProduto}')
        print(f'IMG: {urlImg}\n')

def coletaDadosAmericanas(): # OK
    navegador = iniciar_chrome(url="https://www.americanas.com.br/", headless='off')

    try:
        popUp = navegador.find_element(By.XPATH, "//div[contains(@class, 'ins-responsive-banner')]")
        popUp.click()
    except NoSuchElementException:
        print("Popup não encontrado")

    wait = WebDriverWait(navegador, 20)

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    menu_celulares = wait.until(EC.presence_of_element_located((By.XPATH, "//a[text()='celulares']")))
    ActionChains(navegador).move_to_element(menu_celulares).perform()

    iphone_link = wait.until(EC.element_to_be_clickable((By.XPATH, "//a[text()='iphone']")))
    iphone_link.click()

    print('Produtos Ofertas do Dia Americanas\n')

    try:
        WebDriverWait(navegador, 30).until(
            EC.presence_of_element_located((By.XPATH, "//h3[contains(@class, 'ProductCard_productName')]"))
        )
        produtos = navegador.find_elements(By.XPATH, "//h3[contains(@class, 'ProductCard_productName')]")
        precos = navegador.find_elements(By.XPATH, "//p[contains(@class, 'ProductCard_productPrice')]")
        linkProduto = navegador.find_elements(By.XPATH, "//div[contains(@class, 'ProductCard_productCard')]//a")
        imgProduto = navegador.find_elements(By.XPATH, "//div[contains(@class, 'ProductCard_productImage')]//img")

        WebDriverWait(navegador, 30).until(
            EC.presence_of_element_located((By.XPATH, "//h3[contains(@class, 'ProductCard_productName')]"))
        )

        if not produtos:
            print("Nenhum produto encontrado.")
        else:

            try:
                for i, (produto, preco, link, imgLink) in enumerate(zip(produtos[:3], precos, linkProduto, imgProduto), start=1):
                    urlProduto = link.get_attribute('href')
                    urlImg = imgLink.get_attribute('src')
                    produto = produto.text
                    preco = preco.text

                    preco = preco.split()
                    preco = preco[1]

                    print(f"{produto.strip().upper()} -- {preco.strip()}")
                    print(f'LINK: {urlProduto}')
                    print(f'IMG: {urlImg}\n')

                    inserirDados(produto, "Americanas", preco, urlProduto, urlImg)
            except Exception as e:
                print(f"Erro durante o loop: {e}")

    except TimeoutException:
        print("Produtos não carregaram a tempo. Verifique se o XPath está correto ou se é necessário rolar mais")

def coletaDadosMagazine(): # OK -- IMPLEMENTAR BANCO

    navegador = iniciar_chrome(url='https://www.magazineluiza.com.br/celulares-e-smartphones/l/te/', headless='off')

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    site = BeautifulSoup(navegador.page_source, 'html.parser')
    divProdutos = site.find('div', {'data-testid': 'mod-productlist'})
    cards = divProdutos.find_all('a', {'data-testid': 'product-card-container'})

    for card in cards[:4]:
    
        produto = card.find('h2', {'data-testid': 'product-title'})
        produto = produto.text

        preco = card.find('p', {'data-testid': 'price-value'})
        preco = preco.text
        preco = preco.split()

        imgProduto = card.find('img', {'data-testid': 'image'})

        urlProduto = card.get("href")
        urlImg = imgProduto.get("src")

        print(f"{produto} | {preco[1]} {preco[2]}")
        print(f'LINK: https://www.magazineluiza.com.br{urlProduto}')
        print(f'IMG: {urlImg}\n')

def coletaCasasBahia(): # OK -- IMPLEMENTAR BANCO

    navegador = iniciar_chrome(url='https://www.casasbahia.com.br/c/telefones-e-celulares?filtro=c38', headless='off')

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    divProdutos = navegador.find_element(By.XPATH, "//div[contains(@class, 'slick-track')]")
    produtos = divProdutos.find_elements(By.XPATH, "//h3[contains(@class, 'product-card__title')]")
    precos = divProdutos.find_elements(By.XPATH, "//div[@class='product-card__highlight-price']")
    linkProduto = divProdutos.find_elements(By.XPATH, "//h3[contains(@class, 'product-card__title')]//a")
    imgProduto = divProdutos.find_elements(By.XPATH, "//img[@class='product-card__image']")

    for produto, preco, link, img in zip(produtos[:4], precos, linkProduto, imgProduto):
        
        produto = produto.text
        preco = preco.text
        urlProduto = link.get_attribute('href')
        urlImg = img.get_attribute('src')

        print(f"{produto} | {preco}")
        print(f'LINK: {urlProduto}')
        print(f'IMG: {urlImg}\n')




#-----------------------------PESQUISA FILTRADA-----------------------------

def filtroAmazon(inputNome): #OK -- IMPLEMENTAR BANCO 
    # inputNome = input('Qual é o produto? ')
    # inputNome = inputNome.replace(" ", "+")

    urlBase = f"https://www.amazon.com.br/s?k={inputNome}"

    navegador = iniciar_chrome(url=urlBase, headless='on')


    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    try:
        erro = navegador.find_element(By.XPATH, "//*[contains(text(), 'Desculpe')]")
        if erro:
            print("Página de erro detectada")
            navegador.get(urlBase)
            time.sleep(random.uniform(2, 5)) 
    except:
        print("Página carregada normalmente.")


    esperar_elemento(navegador, '//*[@class="s-main-slot s-result-list s-search-results sg-row"]//h2')

    produtos = navegador.find_elements(By.XPATH, '//h2[contains(@class, "a-size-base-plus")]')
    precos = navegador.find_elements(By.XPATH, '//a[contains(@class, "a-link-normal") and contains(@class, "s-underline-text")]//span[@class="a-price-whole"]')
    linkProduto = navegador.find_elements(By.XPATH, "//*[contains(concat(' ', normalize-space(@class), ' '), ' a-link-normal ') and contains(concat(' ', normalize-space(@class), ' '), ' s-line-clamp-4 ') and contains(concat(' ', normalize-space(@class), ' '), ' s-link-style ') and contains(concat(' ', normalize-space(@class), ' '), ' a-text-normal ')]")
    imgProduto = navegador.find_elements(By.XPATH, '//img[@class="s-image"]')

    for produto, preco, link, img in zip(produtos[:4], precos, linkProduto, imgProduto):
        
        if produto and preco:

            produto = produto.text
            preco = preco.text
            urlProduto = link.get_attribute("href")
            urlImg = img.get_attribute("src")

            print(f'{produto} | {preco}')
            print(f'{urlProduto}')
            print(f'{urlImg}\n')

        else:
            print("Nenhum produto encontrado")

def filtroMercadoLivre(inputNome): #OK -- IMPLEMENTAR BANCO
    urlBase = f'https://lista.mercadolivre.com.br/{inputNome}'

    navegador = iniciar_chrome(url=urlBase, headless='on')

    esperar_elemento(navegador, "//div[@class='ui-search-result__wrapper']")

    html = navegador.page_source

    navegador.quit()  

    site = BeautifulSoup(html, 'html.parser')

    produtos = site.find_all('div', attrs={'class': 'ui-search-result__wrapper'})

    for produto in produtos[:4]:
        preco = produto.find('div', attrs={'class': 'poly-price__current'})
        centavos = preco.find('span', attrs={'class': 'andes-money-amount__cents andes-money-amount__cents--superscript-24'})
        simbolo = preco.find('span', attrs={'class': 'andes-money-amount__currency-symbol'})

        nomeProduto = produto.find('a', attrs={'class': 'poly-component__title'})
        precoProduto = preco.find('span', attrs={'class': 'andes-money-amount__fraction'})
        linkProduto = nomeProduto['href']
        imgTag = produto.find('img', attrs={'class': 'poly-component__picture'})

        nomeProduto = nomeProduto.text.strip()
        simbolo = simbolo.text.strip()

        imgLink = imgTag.get('src')

        if imgLink.startswith('data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'):
            imgLink = imgTag.get('data-src') or imgTag.get('data-lazy-src') or imgTag.get('data-original') or imgLink

        if centavos:
            precoProduto = simbolo + precoProduto.text + ',' + centavos.text
        else:
            precoProduto = simbolo + precoProduto.text + ',00'

        print(nomeProduto, precoProduto)
        print(f'LINK: {linkProduto}')
        print(f'IMG: {imgLink}\n')

        # salvar_dados_postgres(nomeProduto, precoProduto, linkProduto)

def filtroAmericanas(inputNome): #OK -- IMPLEMENTAR BANCO

    urlBase = f"https://www.americanas.com.br/s?q={inputNome}"
    
    navegador = iniciar_chrome(url=urlBase, headless='on')

    try:
        popUp = navegador.find_element(By.XPATH, "//div[contains(@class, 'ins-responsive-banner')]")
        popUp.click()
    except NoSuchElementException:
        print("Popup não encontrado")

    wait = WebDriverWait(navegador, 20)

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    esperar_elemento(navegador, "//div[contains(@class, 'ProductGrid_vertical')]")

    divProdutos = navegador.find_element(By.XPATH, "//div[contains(@class, 'ProductGrid_vertical')]")
    produtos = divProdutos.find_elements(By.XPATH, "//h3[contains(@class, 'ProductCard_productName')]")
    precos = divProdutos.find_elements(By.XPATH, "//p[contains(@class, 'ProductCard_productPrice')]")
    linkProduto = navegador.find_elements(By.XPATH, "//div[contains(@class, 'ProductGrid_vertical')]//a")
    imgProduto = navegador.find_elements(By.XPATH, "//div[contains(@class, 'ProductCard_productImage')]//img")

    for produto, preco, link, img in zip(produtos[:4], precos, linkProduto, imgProduto):

        produto = produto.text
        preco = preco.text
        preco = preco.split()
        urlProduto = link.get_attribute("href")
        urlImg = img.get_attribute("src")

        print(f"{produto} | {preco[1]}")
        print(f'LINK: {urlProduto}')
        print(f'IMG: {urlImg}\n')

def filtroMagazine(inputNome): #OK -- IMPLEMENTAR BANCO 
    urlBase = 'https://www.magazineluiza.com.br/busca/'
    # inputNome = input('Qual o nome do produto? ')
    # inputNome = inputNome.replace(" ", "")

    url = urlBase + inputNome

    navegador = iniciar_chrome(url=url, headless='on')

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    time.sleep(5)

    site = BeautifulSoup(navegador.page_source, 'html.parser')

    containers = site.find_all('a', attrs={'data-testid': 'product-card-container'})

    for card in containers[:4]:
        produtos = card.find('h2', attrs={'data-testid': 'product-title'})
        precos = card.find('p', attrs={'data-testid': 'price-value'})   
        imgProduto = card.find('img', attrs={'data-testid': 'image'})
        urlImg = imgProduto['src']

        urlProduto = card.get('href')
        urlProduto = f'https://www.magazineluiza.com.br/{urlProduto}'

        produtos = produtos.text
        precos = precos.text
        precos = precos.split()


        if produtos and precos:
            print(f"{produtos} | {precos[2]}")
            print(f'LINK: {urlProduto}')
            print(f'IMG: {urlImg}\n')

def filtroCasasBahia(inputNome): #OK -- IMPLEMENTAR BANCO
    urlBase = f"https://www.casasbahia.com.br/{inputNome}/b"
    
    navegador = iniciar_chrome(url=urlBase, headless='on')

    esperar_elemento(navegador, "//div[contains(@data-cy, 'divGridProducts')]")

    divProdutos = navegador.find_element(By.XPATH, "//div[contains(@data-cy, 'divGridProducts')]")
    produtos = divProdutos.find_elements(By.XPATH, "//h3[contains(@class, 'product-card__title')]")
    precos = divProdutos.find_elements(By.XPATH, "//div[@class='product-card__highlight-price']")
    linkProduto = divProdutos.find_elements(By.XPATH, "//h3[contains(@class, 'product-card__title')]//a")
    imgProduto = divProdutos.find_elements(By.XPATH, "//img[@class='product-card__image']")

    for produto, preco, link, img in zip(produtos[:4], precos, linkProduto, imgProduto):
        
        produto = produto.text
        preco = preco.text
        urlProduto = link.get_attribute('href')
        urlImg = img.get_attribute('src')

        print(f"{produto} | {preco}")
        print(f'LINK: {urlProduto}')
        print(f'IMG: {urlImg}\n')



#FILTRO COMPLETO -- EXECUTA TODAS AS FUNÇÕES DE UMA VEZ, TRAZENDO OS RESULTADOS 
def filtroCompleto():
    inputNome = input('Qual o nome do produto? ')
    
    # filtroAmazon(inputNome)
    filtroMercadoLivre(inputNome)
    # filtroAmericanas(inputNome)
    # filtroMagazine(inputNome)
    # filtroCasasBahia(inputNome)

filtroCompleto()
# coletaCasasBahia()


# IDEIA ESTRUTURA BANCO DE DADOS
""" dados_webscraping
	    nomeProduto
	    precoProduto
	    linkProduto
        lojaProduto
        hrefImg
	
    produtos_merclivre
	    nomeProduto
	    precoProduto
	    linkProduto
        lojaProduto
        hrefImg
	
    produtos_amazon
	    nomeProduto
	    precoProduto
	    linkProduto
        lojaProduto
        hrefImg

    produtos_americanas
	    nomeProduto
	    precoProduto
	    linkProduto
        lojaProduto
        hrefImg"""

#NO BANCO MINHA IDEIA É FAZER UMA TABELA PRA CADA SITE, SALVAR TODAS AS INF COM A DATA DO DIA, QUANDO FOR PUXAR NO SITE, USAR SELECT * FROM AMAZON WHERE DT_ATUAL = 'DATA';
#ASSIM FAZENDO COM QUE PUXE NO SITE A ATUALIZAÇÃO DO DIA, MAS NAO DEIXANDO DE SALVAR OS PRODUTOS DOS OUTROS DIAS PRA FAZER GRAFICO DE COMPARAÇÃO DE DATA




"""
TABELA LOJAS
id
nome

TABELA PRODUTOS
id
nome

TABELA PRECOS
id
produto_id
loja_id
preco
link_produto
href_img
data_captura
"""