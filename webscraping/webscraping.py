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


#---------------------------------------------------------------------------

"""Para iniciar o robô siga esses passos:
    1-Win+R e coloque esse codigo '#start chrome.exe --remote-debugging-port=9222 --user-data-dir="C:\Selenium\ChromeTestProfile'
    2-Abra a amazon

    Eu uso esse chrome diferente que é para nao dar alguns bugs
"""

def iniciar_navegador(com_debugging_remoto=True): 

    """Aqui estamos criando o navegador, onde vai iniciar o Selenium
    Selenium é a biblioteca que permite a interação com elementos web,
    tornando assim possivel esses robôs
    
    Sempre deve conter essa função no seu código quando for utilizar selenium
    
    Essa função não vai ser encontrada nos videos de youtube, foi criada por fora para fugir de bugs"""

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


"""Aqui vamos iniciar o navegador, definindo a variavel que vamos usar
    pra dar qualquer comando com o Selenium"""

navegador = iniciar_navegador(com_debugging_remoto=True)


def coletaDadosAmazon(): #Já estar na pag Amazon -- Coleta produtos em alta

    btnTodos = navegador.find_element(By.XPATH, '//*[@id="nav-hamburger-menu"]') #Obtendo o XPATH do elemento
    #btnTodos = Selenium, encontre o elemento pelo XPATH = //*[@id="nav-hamburger-menu"]

    btnTodos.click(), time.sleep(1) #Dando um click em cima do elemento, e dando uma pausa de 1 segundo

    btnProdAlta = navegador.find_element(By.XPATH, '//*[@id="hmenu-content"]/ul[1]/li[4]/a')
    btnProdAlta.click(), time.sleep(1) #Mesma coisa que em cima

    #Tópicos

    """Aqui vamos pegar todos os elementos que são uma DIV e que contém a classe 'a-carousel' """
    secoes = navegador.find_elements(By.XPATH, "//div[contains(@class, 'a-carousel')]") 
    secoes_exibidas = set() #Armazena o nome das seções, e tambem nao permite elementos duplicados


    """Para cada seção em 'secoes', lembrando, em 'secoes' armazenamos todos os elementos com aquela mesma classe,
        ou seja, um loop para percorrer cada seção presente na lista de seções obtidas, um de cada vez"""
    for secao in secoes: 

        try: #Tentar, fazer uma tentativa

            #Vai me retornar o nome dos tópicos     Elementos h2 com a classe abaixo
            topico = secao.find_element(By.XPATH, ".//h2[contains(@class, 'a-carousel-heading')]").text

            #Se o tópico ja estiver em secoes_exibidas, o loop continua, no caso aqui evitando seções duplicadas no meu retorno de Nomes no terminal
            if topico in secoes_exibidas:
                continue  
            secoes_exibidas.add(topico)  
            
            print(f"\n{topico.upper()}")  #Printa pra mim o tópico
        except: #Se acontecer algum erro, o código simplesmente ignora e vai pra próxima
            continue  

        #Mesma ideia, obtém todos os produtos que estao na DIV com a classe abaixo
        produtos = secao.find_elements(By.XPATH, ".//div[contains(@class, 'p13n-sc-truncate-desktop-type2')]")
        

        #Se existir algum produto, ou seja, se foi obtido os nomes dos produtos
        if produtos:
            for produto in produtos: #Para cada produto na lista Produtos
                print(f" - {produto.text.upper()}") #Vai me retornar o nome de cada um
                """PRODUTO = VARIÁVEL, .TEXT = RETORNAR O TEXTO, .UPPER () = RETORNAR EM CAIXA ALTA"""

def coletaDadosMerLivre():
    btnOfertas = navegador.find_element(By.XPATH, '/html/body/header/div/div[5]/div/ul/li[2]/a')
    btnOfertas.click(), time.sleep(1) #Mesma coisa la de cima

    ofertas = navegador.find_element(By.XPATH, '//*[@id="root-app"]/div/div/section/a/div/h1').text
    print(ofertas)

    produtos = navegador.find_elements(By.XPATH, "//a[contains(@class, 'poly-component__title')]") #Obtendo elementos
    precos = navegador.find_elements(By.XPATH, "//span[contains(@class, 'andes-money-amount__fraction')]") #Obtendo elementos


    """ Para cada produto, preco, em Produtos e Preços. No caso para cada produto dentro da lista
        de Produtos encontrados, e para cada preço encontrado na lista de Preços encontrados

        zip() serve para utilizar mais de uma variável de uma vez """
    
    for produto, preco in zip(produtos, precos): 
        print(f"{produto.text.upper()} -- R$ {preco.text}\n") #Retorna pra mim o nome de cada procuto e o preço
        """PRODUTO = VARIÁVEL, .TEXT = RETORNAR O TEXTO, .UPPER () = RETORNAR EM CAIXA ALTA"""

def coletaDadosAmericanas():
    ofertaDia = navegador.find_element(By.XPATH, '//*[@id="rsyswpsdk"]/div/header/div[1]/div[1]/main/ul/li[9]/a') # OBTENDO XPATH ELEMENTO
    ofertaDia.click(), time.sleep(1) #CLICANDO NO ELEMENTO

    btnVerTudo = navegador.find_element(By.XPATH, '//*[@id="rsyswpsdk"]/div/section/div/div[1]/div[3]/div/div[2]/div/div/div[3]/a') # OBTENDO XPATH ELEMENTO
    btnVerTudo.click(), time.sleep(1) #CLICANDO NO ELEMENTO

    time.sleep(1)

    produtos = navegador.find_elements(By.XPATH, "//h3[contains(@class, 'product-name')]") # OBTENDO XPATH ELEMENTOS
    precos = navegador.find_elements(By.XPATH, "//span[contains(@class, 'styles__PromotionalPrice-sc-yl2rbe-0')]") # OBTENDO XPATH ELEMENTOS

    print('Produtos Ofertas do Dia Americanas\n')

    for produto, preco in zip(produtos, precos): #LOOP PARA ME RETORNAR TODOS OS PRODUTOS
        print(f"- {produto.text.upper()} -- R$ {preco.text}") 
        """PRODUTO = VARIÁVEL, .TEXT = RETORNAR O TEXTO, .UPPER () = RETORNAR EM CAIXA ALTA"""


coletaDadosAmazon()