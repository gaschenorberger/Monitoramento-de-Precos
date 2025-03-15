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

coletaDadosAmazon()