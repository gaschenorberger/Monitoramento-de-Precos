from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoSuchElementException
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

#-------------------------------ÁREA PRINCIPAL---------------------------

def coletaDadosAmazon(): #OK
    #navegador = iniciar_navegador(com_debugging_remoto=True)
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")

    navegador = webdriver.Chrome(options=options)
    navegador.get("https://www.amazon.com.br")

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')


    btnTodos = navegador.find_element(By.XPATH, '//*[@id="nav-hamburger-menu"]')
    btnTodos.click(), time.sleep(1) 

    btnProdAlta = navegador.find_element(By.XPATH, '//*[@id="hmenu-content"]/ul[1]/li[4]/a')
    btnProdAlta.click(), time.sleep(1) 

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
                    print(produto.text.upper() + preco.text)
                else:
                    pass
                    
def coletaDadosMerLivre(): #OK
    # navegador = iniciar_navegador(com_debugging_remoto=True)

    options = webdriver.ChromeOptions()
    options.add_argument("--headless")

    navegador = webdriver.Chrome(options=options)
    navegador.get("https://www.mercadolivre.com.br/")

    btnOfertas = navegador.find_element(By.XPATH, '/html/body/header/div/div[5]/div/ul/li[2]/a')
    btnOfertas.click(), time.sleep(1) 

    ofertas = navegador.find_element(By.XPATH, '//*[@id="root-app"]/div/div/section/a/div/h1').text.upper()
    print(f'{ofertas}\n')
    
    produtos = navegador.find_elements(By.XPATH, "//a[contains(@class, 'poly-component__title')]") 
    precos = navegador.find_elements(By.XPATH, "//span[contains(@class, 'andes-money-amount andes-money-amount--cents-superscript')]/descendant::span[contains(@class, 'andes-money-amount__fraction')]")
    centavos = navegador.find_elements(By.XPATH, "//span[contains(@class, 'andes-money-amount andes-money-amount--cents-superscript')]/descendant::span[contains(@class, 'andes-money-amount__cents andes-money-amount__cents--superscript-24')]")

    for produto, preco, centavo in zip(produtos[:3], precos, centavos[:3]):
        if centavo:
            print(f"{produto.text.upper()} -- R$ {preco.text},{centavo.text}")
        else:
            print(f"{produto.text.upper()} -- R$ {preco.text},00")

def coletaDadosAmericanas(): #ALTERAR PARA SITE DINÂMICO
    navegador = iniciar_navegador(com_debugging_remoto=True)

    # options = webdriver.ChromeOptions()
    # options.add_argument("--headless")

    # navegador = webdriver.Chrome(options=options)
    # navegador.get("https://www.americanas.com.br/")

    action = ActionChains(navegador)
    action.move_by_offset(10, 10).click().perform()

    ofertaDia = navegador.find_element(By.XPATH, '//*[@id="__next"]/header/div/section[2]/div/nav/ul/li[8]/a')
    ofertaDia.click(), time.sleep(1)

    btnVerTudo = navegador.find_element(By.XPATH, '//*[@id="rsyswpsdk"]/div/section/div/div[1]/div[3]/div/div[2]/div/div/div[3]/a')
    btnVerTudo.click(), time.sleep(5)

    produtos = navegador.find_elements(By.XPATH, "//h3[contains(@class, 'product-name')]")
    precos = navegador.find_elements(By.XPATH, "//span[contains(@class, 'styles__PromotionalPrice-sc-yl2rbe-0')]")

    print('Produtos Ofertas do Dia Americanas\n')

    indice = 1
    for produto, preco in zip(produtos[:3], precos): 
        print(f"{indice}- {produto.text.upper()} -- R$ {preco.text}") 
        indice +=1

def coletaDadosMagazine(): #OK 
    urlBase = 'https://www.magazineluiza.com.br'

    options = Options()
    options.add_argument("--headless") 
    navegador = webdriver.Chrome(options=options)

    navegador.get(urlBase)
    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    navegador.execute_script("window.scrollBy(0, 1000);")
    time.sleep(5)

    site = BeautifulSoup(navegador.page_source, 'html.parser')
    maisVendidos = site.find('div', class_='sc-fjhLSj iSXyfy')
    produtos = maisVendidos.find_all('h3', class_='sc-doohEh dHamKz')
    precos = maisVendidos.find_all('p', class_='sc-dcJsrY eLxcFM sc-kUdmhA cvHkKW')

    for produto, preco in zip(produtos[:4], precos):
        print(produto.text + preco.text)

def coletaCasasBahia(): #CONTINUAR
    url = 'https://www.casasbahia.com.br'

    options = webdriver.ChromeOptions()
    # options.add_argument("--headless")

    navegador = webdriver.Chrome(options=options)
    navegador.get(url)

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    time.sleep(3)

    site = BeautifulSoup(navegador.page_source, 'html.parser')
    print(site.prettify())
    # divProdutos = site.find('div', class_='css-78wyov')

    # produtos = divProdutos.find('h3', class_='product-card__title')
    # print(produtos.text)




#-----------------------------PESQUISA FILTRADA-----------------------------

def filtroMercadoLivre(): #OK

    urlBase = 'https://lista.mercadolivre.com.br/'
    inputNome = input('Qual o nome do produto? ')
    inputNome = inputNome.replace(" ", "")

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

        salvar_dados_postgres(nomeProduto, precoProduto, linkProduto)

def filtroMagazine(): #SITE DINAMICO 
    urlBase = 'https://www.magazineluiza.com.br/busca/'
    inputNome = input('Qual o nome do produto? ')
    inputNome = inputNome.replace(" ", "")

    url = urlBase + inputNome

    options = webdriver.ChromeOptions()
    options.add_argument("--headless")

    navegador = webdriver.Chrome(options=options)
    navegador.get(url)

    WebDriverWait(navegador, 240).until(lambda navegador: navegador.execute_script('return document.readyState') == 'complete')

    time.sleep(5)

    site = BeautifulSoup(navegador.page_source, 'html.parser')

    divProdutos = site.find('div', class_='sc-iGgWBj eWtIHQ sc-fDinKg iwedJE')
    produtos = divProdutos.find_all('h2', class_='sc-doohEh dHamKz')
    precos = divProdutos.find_all('p', class_='sc-dcJsrY eLxcFM sc-kUdmhA cvHkKW')

    for produto, preco in zip(produtos,precos):
        print(produto.text + preco.text)

def filtroAmazon():
    inputNome = input('Qual é o produto? ')
    urlBase = f"https://www.amazon.com.br/s?k={inputNome}&__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&"

    

filtroAmazon()


# IDEIA ESTRUTURA BANCO DE DADOS
""" dados_webscraping
	    nomeProduto
	    precoProduto
	    linkProduto
        lojaProduto
	
    produtos_merclivre
	    nomeProduto
	    precoProduto
	    linkProduto
        lojaProduto
	
    produtos_amazon
	    nomeProduto
	    precoProduto
	    linkProduto
        lojaProduto

    produtos_americanas
	    nomeProduto
	    precoProduto
	    linkProduto
        lojaProduto"""

#NO BANCO MINHA IDEIA É FAZER UMA TABELA PRA CADA SITE, SALVAR TODAS AS INF COM A DATA DO DIA, QUANDO FOR PUXAR NO SITE, USAR SELECT * FROM AMAZON WHERE DT_ATUAL = 'DATA';
#ASSIM FAZENDO COM QUE PUXE NO SITE A ATUALIZAÇÃO DO DIA, MAS NAO DEIXANDO DE SALVAR OS PRODUTOS DOS OUTROS DIAS PRA FAZER GRAFICO DE COMPARAÇÃO DE DATA
