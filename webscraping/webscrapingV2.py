from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
import os
import time
from selenium.common.exceptions import NoSuchElementException
from bs4 import BeautifulSoup
import requests
import pandas as pd
import openpyxl
from sqlalchemy import create_engine
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
        password="1234",
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

def coletaDadosAmazon(): #Já estar na pag Amazon -- Coleta produtos em alta
    navegador = iniciar_navegador(com_debugging_remoto=True)

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
        

        if produtos:
            for produto in produtos[:3]:
                print(f" - {produto.text.upper()}")

def coletaDadosMerLivre():
    navegador = iniciar_navegador(com_debugging_remoto=True)

    btnOfertas = navegador.find_element(By.XPATH, '/html/body/header/div/div[5]/div/ul/li[2]/a')
    btnOfertas.click(), time.sleep(1) 

    ofertas = navegador.find_element(By.XPATH, '//*[@id="root-app"]/div/div/section/a/div/h1').text
    print(f'{ofertas}\n')
    
    produtos = navegador.find_elements(By.XPATH, "//a[contains(@class, 'poly-component__title')]") 
    precos = navegador.find_elements(By.XPATH, "//span[contains(@class, 'andes-money-amount andes-money-amount--cents-superscript')]/descendant::span[contains(@class, 'andes-money-amount__fraction')]")
    centavos = navegador.find_elements(By.XPATH, "//span[contains(@class, 'andes-money-amount andes-money-amount--cents-superscript')]/descendant::span[contains(@class, 'andes-money-amount__cents andes-money-amount__cents--superscript-24')]")
    

    # Ajustar a lista de centavos para ter o mesmo tamanho que produtos e preços
    centavos_dict = {centavo.location['y']: centavo for centavo in centavos}  # Organiza por posição
    centavos_ordenados = [centavos_dict.get(preco.location['y'], None) for preco in precos]  # Associa ao preço correto

    for produto, preco, centavo in zip(produtos[:3], precos, centavos_ordenados[:3]):
        if centavo:
            print(f"{produto.text.upper()} -- R$ {preco.text},{centavo.text}")
        else:
            print(f"{produto.text.upper()} -- R$ {preco.text},00")

def coletaDadosAmericanas():
    navegador = iniciar_navegador(com_debugging_remoto=True)

    ofertaDia = navegador.find_element(By.XPATH, '//*[@id="rsyswpsdk"]/div/header/div[1]/div[1]/main/ul/li[9]/a')
    ofertaDia.click(), time.sleep(2)

    btnVerTudo = navegador.find_element(By.XPATH, '//*[@id="rsyswpsdk"]/div/section/div/div[1]/div[3]/div/div[2]/div/div/div[3]/a')
    btnVerTudo.click(), time.sleep(2)

    time.sleep(5)

    produtos = navegador.find_elements(By.XPATH, "//h3[contains(@class, 'product-name')]")
    precos = navegador.find_elements(By.XPATH, "//span[contains(@class, 'styles__PromotionalPrice-sc-yl2rbe-0')]")

    print('Produtos Ofertas do Dia Americanas\n')

    for produto, preco in zip(produtos[:3], precos): 
        print(f"- {produto.text.upper()} -- R$ {preco.text}") 


#-----------------------------PESQUISA FILTRADA-----------------------------

def filtroMercadoLivre():
    listaProdutos = []

    urlBase = 'https://lista.mercadolivre.com.br/'
    inputNome = input('Qual o nome do produto? ')

    response = requests.get(urlBase + inputNome)

    site = BeautifulSoup(response.text, 'html.parser')

    produtos = site.find_all('div', attrs={'class': 'ui-search-result__wrapper'})
    #print(produto.prettify())
    
    for produto in produtos[:5]:
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

            listaProdutos.append(nomeProduto, precoProduto, linkProduto)
        else:
            precoProduto = simbolo + precoProduto.text + ',' + '00'
            print(nomeProduto, precoProduto, '\n', linkProduto, '\n')

            listaProdutos.append([nomeProduto, precoProduto, linkProduto])

        salvar_dados_postgres(nomeProduto, precoProduto, linkProduto)

   


filtroMercadoLivre()
