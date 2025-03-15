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

def coletaDadosAmazon(): #Já estar na pag Amazon
    btnTodos = navegador.find_element(By.XPATH, '//*[@id="nav-hamburger-menu"]')
    btnTodos.click(), time.sleep(1)

    btnProdAlta = navegador.find_element(By.XPATH, '//*[@id="hmenu-content"]/ul[1]/li[4]/a')
    btnProdAlta.click(), time.sleep(1)

    #Tópicos

    #prodAltaCasa = navegador.find_element(By.CLASS_NAME, 'a-carousel-heading a-inline-block')
    """prodAltaBemEstar = navegador.find_element(By.XPATH, '//*[@id="CardInstancedOGO_h4OFbmC6TqwzsY6lg"]/div/div/div/div[1]/div[1]/h2')
    prodAltaEletro = navegador.find_element(By.XPATH, '//*[@id="CardInstanceTibm_GR2tkF8aBmu_2dXLQ"]/div/div/div/div[1]/div[1]/h2')
    prodAltaLivros = navegador.find_element(By.XPATH, '//*[@id="CardInstancexfsoEqQ25ZJMrjbz7q7yEw"]/div/div/div/div[1]/div[1]/h2')
    prodAltaCozinha = navegador.find_element(By.XPATH, '//*[@id="CardInstanceYCeLIgVTK2aYlOX7o0QBLA"]/div/div/div/div[1]/div[1]/h2')
    prodAltaJogos = navegador.find_element(By.XPATH, '//*[@id="CardInstance2MBoZ2uPd5GqR4BSNFbwig"]/div/div/div/div[1]/div[1]/h2')"""

    topicos = navegador.find_elements(By.XPATH, "//h2[contains(@class, 'a-carousel-heading')]")

    for topico in topicos:
        print(topico.text) 


coletaDadosAmazon()