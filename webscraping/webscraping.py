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

#start chrome.exe --remote-debugging-port=9222 --user-data-dir="C:\Selenium\ChromeTestProfile"

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

navegador = iniciar_navegador(com_debugging_remoto=True)

def coletaDadosAmazon(): #Já estar na pag Amazon -- Coleta produtos em alta

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
            for produto in produtos:
                print(f" - {produto.text}")

def coletaDadosMerLivre():
    btnOfertas = navegador.find_element(By.XPATH, '/html/body/header/div/div[5]/div/ul/li[2]/a')
    btnOfertas.click(), time.sleep(1)

    ofertas = navegador.find_element(By.XPATH, '//*[@id="root-app"]/div/div/section/a/div/h1').text
    print(ofertas)

    produtos = navegador.find_elements(By.XPATH, "//a[contains(@class, 'poly-component__title')]")
    precos = navegador.find_elements(By.XPATH, "//span[contains(@class, 'andes-money-amount__fraction')]")

    for produto, preco in zip(produtos, precos):
        print(f"{produto.text} -- R$ {preco.text}\n")


coletaDadosMerLivre()