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
import pandas as pd
import openpyxl
from datetime import datetime
import psycopg2
import random
import subprocess
import pyautogui

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


def conectar_postgres():
    return psycopg2.connect(
        dbname="bd_preco_certo",
        user="postgres",
        password="123",
        host="localhost",
        port="5432"
    )

def salvar_dados_postgres(nomePdt, precoPdt, linkPdt):
    
    conexao = conectar_postgres()
    cursor = conexao.cursor()


    query = """
        INSERT INTO produtos (nome_pdt, preco_pdt, link_pdt)
        VALUES (%s, %s, %s);
    """
    cursor.execute(query, (nomePdt, precoPdt, linkPdt))

    conexao.commit()
    cursor.close()
    conexao.close()

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

def coletaDadosAmazon(): #OK

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
    links = navegador.find_elements(By.XPATH, "//div[contains(@class, 'a-cardui dcl-product')]//a")
    imgLinks = navegador.find_elements(By.XPATH, "//div[contains(@class, 'dcl-product-image-container')]//img")
    
    if produtos:

        for produto, real, centavo, link, imgLink  in zip(produtos[:3], reais, centavos, links, imgLinks):

            urlProduto = link.get_attribute('href')
            src = imgLink.get_attribute('src')
            
            if centavos:
                real = real.text
                centavo = centavo.text
                preco = f'{real},{centavo}'

                print(f"{produto.text.upper()} | {preco}")
                print(urlProduto)
                print(f"{src}\n")
                
            else:
                preco = f'{real.text},00'

                print(f"{produto.text.upper()} | {preco.text}")
                print(urlProduto)
                print(f"{src}\n")
         
def coletaDadosMerLivre(): #OK -- FALTA OBTER URL E IMG

    navegador = iniciar_chrome(url='https://www.mercadolivre.com.br/c/informatica#menu=categories', headless='off')

    wait = WebDriverWait(navegador, 20)

    esperar_elemento(navegador, "//section[contains(@class, 'dynamic-carousel-normal-desktop')]")
    
    # SECTION PRODUTOS

    esperar_elemento(navegador, "//div[contains(@class, 'dynamic-carousel__item-container')]")
    divProdutos = navegador.find_element(By.XPATH, "//div[contains(@class, 'dynamic-carousel__item-container')]")

    produtos = divProdutos.find_elements(By.XPATH, "//h3[contains(@class, 'dynamic-carousel__title')]") 
    precos = divProdutos.find_elements(By.XPATH, "//div[contains(@class, 'dynamic-carousel__price-block')]//span")
    centavos = divProdutos.find_elements(By.XPATH, "//div[contains(@class, 'dynamic-carousel__price-block')]//span//sup")

    for produto, preco, centavo in zip(produtos[:3], precos, centavos[:3]):
        if centavo:
            print(f"{produto.text.upper()} || R$ {preco.text},{centavo.text}")
        else:
            print(f"{produto.text.upper()} || R$ {preco.text},00")

def coletaDadosAmericanas(): #OK
    navegador = iniciar_chrome(url="https://www.americanas.com.br/", headless='on')

    action = ActionChains(navegador)
    action.move_by_offset(10, 10).click().perform()

    time.sleep(2)

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    wait = WebDriverWait(navegador, 20)

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
        links = navegador.find_elements(By.XPATH, "//div[contains(@class, 'ProductCard_productCard')]//a")
        imgLinks = navegador.find_elements(By.XPATH, "//div[contains(@class, 'ProductCard_productImage')]//img")

        if not produtos:
            print("Nenhum produto encontrado.")
        else:

            try:
                for i, (produto, preco, link, imgLink) in enumerate(zip(produtos[:3], precos, links, imgLinks), start=1):
                    urlProduto = link.get_attribute('href')
                    src = imgLink.get_attribute('src')

                    print(f"{produto.text.strip().upper()} -- {preco.text.strip()}")
                    print(f'LINK: {urlProduto}')
                    print(f'IMG: {src}\n')
            except Exception as e:
                print(f"Erro durante o loop: {e}")

    except TimeoutException:
        print("Produtos não carregaram a tempo. Verifique se o XPath está correto ou se é necessário rolar mais")

def coletaDadosMagazine(): #VERIFICAR DIVS -- FALTA OBTER URL E IMG

    navegador = iniciar_chrome(url='https://www.magazineluiza.com.br/celulares-e-smartphones/l/te/', headless='off')

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    navegador.execute_script("window.scrollBy(0, 1000);")
    time.sleep(5)

    site = BeautifulSoup(navegador.page_source, 'html.parser')
    maisVendidos = site.find('div', class_='sc-fjhLSj iSXyfy')
    produtos = maisVendidos.find_all('h2', class_='sc-doohEh dHamKz')
    precos = maisVendidos.find_all('p', class_='sc-dcJsrY eLxcFM sc-kUdmhA cvHkKW')

    for produto, preco in zip(produtos[:4], precos):
        print(F"{produto.text} | {preco.text}")

def coletaCasasBahia(): #CONTINUAR

    navegador = iniciar_chrome(url='https://www.casasbahia.com.br', headless='on')

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')




#-----------------------------PESQUISA FILTRADA-----------------------------

def filtroMercadoLivre(inputNome): #OK
    urlBase = 'https://lista.mercadolivre.com.br/'

    options = Options()
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox') 

    navegador = webdriver.Chrome(options=options)

    navegador.get(urlBase + inputNome)

    time.sleep(5)  

    html = navegador.page_source

    navegador.quit()  

    site = BeautifulSoup(html, 'html.parser')

    produtos = site.find_all('div', attrs={'class': 'ui-search-result__wrapper'})

    for produto in produtos[:3]:
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

        print(nomeProduto, precoProduto, '\n', linkProduto)
        print(imgLink, '\n')

        # salvar_dados_postgres(nomeProduto, precoProduto, linkProduto)

def filtroMagazine(inputNome): #OK 
    urlBase = 'https://www.magazineluiza.com.br/busca/'
    # inputNome = input('Qual o nome do produto? ')
    # inputNome = inputNome.replace(" ", "")

    url = urlBase + inputNome

    navegador = iniciar_chrome(url=url, headless='on')

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    time.sleep(5)

    site = BeautifulSoup(navegador.page_source, 'html.parser')

    containers = site.find_all('a', attrs={'data-testid': 'product-card-container'})

    for card in containers[:5]:
        produtos = card.find('h2', attrs={'data-testid': 'product-title'})
        precos = card.find('p', attrs={'data-testid': 'price-value'})   
        imgLink = card.find('img', attrs={'data-testid': 'image'})
        links = card.get('href')
        links = f'https://www.magazineluiza.com.br/{links}'

        if produtos and precos:
            print(produtos.text + precos.text)
            print(links)
            print(f"{imgLink['src']}\n")

def filtroAmazon(inputNome): #OK 
    # inputNome = input('Qual é o produto? ')
    # inputNome = inputNome.replace(" ", "+")

    urlBase = f"https://www.amazon.com.br/s?k={inputNome}"
    
    print(urlBase)

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

    produtos = navegador.find_elements(By.XPATH, '//*[@class="s-main-slot s-result-list s-search-results sg-row"]//h2[@class="a-size-base-plus a-spacing-none a-color-base a-text-normal"]')
    precos = navegador.find_elements(By.XPATH, '//*[@class="a-price-whole"]')
    urls = navegador.find_elements(By.XPATH, '//*[@class="a-link-normal s-line-clamp-4 s-link-style a-text-normal"]')


    if produtos and precos:
        print(f'Encontrados {len(produtos)} produtos:')
        for produto, preco, url in zip(produtos[:5], precos, urls):

            imgLink = navegador.find_element(By.XPATH, '//*[@class="s-image"]')

            print(f'{produto.text} || {preco.text}')
            print(f'{url.get_attribute("href")}')
            print(f'{imgLink.get_attribute('src')}\n')

    else:
        print("Nenhum produto encontrado")

#FILTRO COMPLETO -- EXECUTA TODAS AS FUNÇÕES DE UMA VEZ, TRAZENDO OS RESULTADOS 
def filtroCompleto():
    inputNome = input('Qual o nome do produto? ')
    
    # filtroMercadoLivre(inputNome)
    filtroMagazine(inputNome)
    # filtroAmazon(inputNome)

# filtroCompleto()
coletaDadosMerLivre()


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
