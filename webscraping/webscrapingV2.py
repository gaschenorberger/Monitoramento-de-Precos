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


def iniciar_navegador(com_debugging_remoto=True): 
    chrome_driver_path = ChromeDriverManager().install()
    chrome_driver_executable = os.path.join(os.path.dirname(chrome_driver_path), 'chromedriver.exe')
    
    #print(f"ChromeDriver path: {chrome_driver_executable}")
    if not os.path.isfile(chrome_driver_executable):
        raise FileNotFoundError(f"O ChromeDriver não foi encontrado em {chrome_driver_executable}")

    service = Service(executable_path=chrome_driver_executable)
    
    chrome_options = Options()

    if com_debugging_remoto:
        remote_debugging_port = 9222
        chrome_options.add_experimental_option("debuggerAddress", f"localhost:{remote_debugging_port}")
    
    navegador = webdriver.Chrome(service=service, options=chrome_options)
    return navegador

#navegador = iniciar_navegador(com_debugging_remoto=True)

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

def abrir_chrome():
    try:
        comando = r'start chrome.exe --remote-debugging-port=9222 --user-data-dir="C:\Selenium\ChromeTestProfile'
        subprocess.Popen(comando, shell=True)

        time.sleep(3)

        url = 'https://www.amazon.com.br'
        pyautogui.write(url)
        time.sleep(2)

        pyautogui.press('enter')
    except Exception as e:
        print(f"Ocorreu um erro: {str(e)}")

#-------------------------------ÁREA PRINCIPAL---------------------------

def coletaDadosAmazon(): #OK -- FALTA OBTER URL

    navegador = iniciar_chrome(url='https://www.amazon.com.br/gp/bestsellers', headless='off')
    # abrir_chrome()

    # navegador = iniciar_navegador()

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    esperar_elemento(navegador, '//*[@id="nav-hamburger-menu"]')

    # btnTodos = navegador.find_element(By.XPATH, '//*[@id="nav-hamburger-menu"]')
    # btnTodos.click(), time.sleep(1) 

    # esperar_elemento(navegador, '//*[@id="hmenu-content"]/div[1]/section[1]/ul/li[3]/a')

    # btnProdAlta = navegador.find_element(By.XPATH, '//*[@id="hmenu-content"]/div[1]/section[1]/ul/li[3]/a')
    # btnProdAlta.click(), time.sleep(1) 

    #Tópicos

    secoes = navegador.find_elements(By.XPATH, "//div[contains(@class, 'a-carousel')]") 
    secoes_exibidas = set() 

    for secao in secoes: 
        try: 
            topico = secao.find_element(By.XPATH, ".//h2[contains(@class, 'a-carousel-heading')]").text

            if topico in secoes_exibidas:
                continue  
            secoes_exibidas.add(topico)  
            
            print(f"\n{topico}") 
        except: 
            continue  

        produtos = secao.find_elements(By.XPATH, ".//div[contains(@class, 'p13n-sc-truncate-desktop-type2')]")
        precos = secao.find_elements(By.XPATH, ".//span[contains(@class, 'p13n-sc-price') or contains(@class, '_cDEzb_p13n-sc-price_3mJ9Z')]")

        if produtos:
            for produto, preco in zip(produtos[:3], precos):
                if preco:
                    print(f"{produto.text.upper()} || {preco.text}")
                else:
                    pass
                    
def coletaDadosMerLivre(): #OK -- FALTA OBTER URL

    navegador = iniciar_chrome(url='https://www.mercadolivre.com.br/', headless='on')

    btnOfertas = navegador.find_element(By.XPATH, '/html/body/header/div/div[5]/div/ul/li[2]/a')
    btnOfertas.click(), time.sleep(1) 

    ofertas = navegador.find_element(By.XPATH, '//*[@id="root-app"]/div/div/section/a/div/h1').text.upper()
    print(f'{ofertas}\n')
    
    produtos = navegador.find_elements(By.XPATH, "//a[contains(@class, 'poly-component__title')]") 
    precos = navegador.find_elements(By.XPATH, "//span[contains(@class, 'andes-money-amount andes-money-amount--cents-superscript')]/descendant::span[contains(@class, 'andes-money-amount__fraction')]")
    centavos = navegador.find_elements(By.XPATH, "//span[contains(@class, 'andes-money-amount andes-money-amount--cents-superscript')]/descendant::span[contains(@class, 'andes-money-amount__cents andes-money-amount__cents--superscript-24')]")

    for produto, preco, centavo in zip(produtos[:3], precos, centavos[:3]):
        if centavo:
            print(f"{produto.text.upper()} || R$ {preco.text},{centavo.text}")
        else:
            print(f"{produto.text.upper()} || R$ {preco.text},00")

def coletaDadosAmericanas(): #ALTERAR PARA SITE DINÂMICO
    navegador = iniciar_chrome(url="https://www.americanas.com.br/", headless='off')

    action = ActionChains(navegador)
    action.move_by_offset(10, 10).click().perform()

    time.sleep(2)

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    ofertaDia = WebDriverWait(navegador, 20).until(
        EC.element_to_be_clickable((By.XPATH, '//*[@id="__next"]/header/div/section[2]/div/nav/ul/li[8]/a'))
    )
    ofertaDia.click()

    try:
        btnVerTudo = WebDriverWait(navegador, 5).until(
            EC.element_to_be_clickable((By.XPATH, '//*[@id="rsyswpsdk"]/div/section/div/div[1]/div[3]/div/div[2]/div/div/div[3]/a'))
        )
        btnVerTudo.click()
        print("Botão 'Ver Tudo' encontrado e clicado!")
    except (TimeoutException, NoSuchElementException):
        print("Botão 'Ver Tudo' NÃO encontrado. Continuando o código...")

    print('Produtos Ofertas do Dia Americanas\n')

    produtos_xpath = "//h3[contains(@class, 'ProductCard_productName')]"

    try:
        WebDriverWait(navegador, 30).until(
            EC.presence_of_element_located((By.XPATH, produtos_xpath))
        )
        produtos = navegador.find_elements(By.XPATH, produtos_xpath)
        precos = navegador.find_elements(By.XPATH, "//p[contains(@class, 'ProductCard_productPrice')]")
        links = navegador.find_elements(By.XPATH, "//a[contains(@class, 'ins-product-box')]")
        imgLinks = navegador.find_elements(By.XPATH, "//a[contains(@class, 'ins-product-box')]//img")

        if not produtos:
            print("Nenhum produto encontrado.")
        else:

            for i, (produto, preco, link, imgLink) in enumerate(zip(produtos[:3], precos, links, imgLinks), start=1):
                urlProduto = link.get_attribute('href')
                src = imgLink.get_attribute('src')

                print(f"{produto.text.strip().upper()} -- {preco.text.strip()}")
                print(urlProduto)
                print(src)

    except TimeoutException:
        print("Produtos não carregaram a tempo. Verifique se o XPath está correto ou se é necessário rolar mais")


def coletaDadosMagazine(): #VERIFICAR DIVS -- FALTA OBTER URL

    navegador = iniciar_chrome(url='https://www.magazineluiza.com.br', headless='off')

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    navegador.execute_script("window.scrollBy(0, 1000);")
    time.sleep(5)

    site = BeautifulSoup(navegador.page_source, 'html.parser')
    maisVendidos = site.find('div', class_='sc-fjhLSj iSXyfy')
    produtos = maisVendidos.find_all('h3', class_='sc-doohEh dHamKz')
    precos = maisVendidos.find_all('p', class_='sc-dcJsrY eLxcFM sc-kUdmhA cvHkKW')

    for produto, preco in zip(produtos[:4], precos):
        print(F"{produto.text} || {preco.text}")

def coletaCasasBahia(): #CONTINUAR

    navegador = iniciar_chrome(url='https://www.casasbahia.com.br', headless='on')

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')




#-----------------------------PESQUISA FILTRADA-----------------------------

def filtroMercadoLivre(inputNome): #OK -- OBTER IMG

    urlBase = 'https://lista.mercadolivre.com.br/'
    # inputNome = input('Qual o nome do produto? ')
    # inputNome = inputNome.replace(" ", "")

    response = requests.get(urlBase + inputNome)

    site = BeautifulSoup(response.text, 'html.parser')

    produtos = site.find_all('div', attrs={'class': 'ui-search-result__wrapper'})
    #print(produto.prettify())
    
    for produto in produtos[:3]:
        preco = produto.find('div', attrs={'class': 'poly-price__current'})
        centavos = preco.find('span', attrs={'class': 'andes-money-amount__cents andes-money-amount__cents--superscript-24'})
        simbolo = preco.find('span', attrs={'class': 'andes-money-amount__currency-symbol'})

        nomeProduto = produto.find('a', attrs={'class': 'poly-component__title'})
        precoProduto = preco.find('span', attrs={'class': 'andes-money-amount__fraction'})
        linkProduto = nomeProduto['href']

        nomeProduto = nomeProduto.text
        simbolo = simbolo.text


        if centavos:
            precoProduto = simbolo + precoProduto.text + ',' + centavos.text
            print(nomeProduto, precoProduto, '\n', linkProduto, '\n')

        else:
            precoProduto = simbolo + precoProduto.text + ',' + '00'
            print(nomeProduto, precoProduto, '\n', linkProduto, '\n')

        # salvar_dados_postgres(nomeProduto, precoProduto, linkProduto)

def filtroMagazine(inputNome): #OK -- OBTER URL
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
        links = card.get('href')

        if produtos and precos:
            print(produtos.text + precos.text)
            print(links)

def filtroAmazon(inputNome): #OK -- OBTER IMG
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
            print(f'{produto.text} || {preco.text} \n')
            print(f'{url.get_attribute("href")} \n')
    else:
        print("Nenhum produto encontrado")

#FILTRO COMPLETO -- EXECUTA TODAS AS FUNÇÕES DE UMA VEZ, TRAZENDO OS RESULTADOS 
def filtroCompleto():
    inputNome = input('Qual o nome do produto? ')
    
    # filtroMercadoLivre(inputNome)
    # filtroMagazine(inputNome)
    filtroAmazon(inputNome)

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
