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
            for produto in produtos[:3]:
                print(f" - {produto.text.upper()}")

def coletaDadosMerLivre():
    btnOfertas = navegador.find_element(By.XPATH, '/html/body/header/div/div[5]/div/ul/li[2]/a')
    btnOfertas.click(), time.sleep(1) 

    ofertas = navegador.find_element(By.XPATH, '//*[@id="root-app"]/div/div/section/a/div/h1').text
    print(f'{ofertas}\n')

    produtos = navegador.find_elements(By.XPATH, "//a[contains(@class, 'poly-component__title')]") 
    precos = navegador.find_elements(By.XPATH, "//span[contains(@class, 'andes-money-amount andes-money-amount--cents-superscript')]/descendant::span[contains(@class, 'andes-money-amount__fraction')]")
    
    for produto, preco in zip(produtos[:3], precos): 
        print(f"{produto.text.upper()} -- R$ {preco.text}") 


def coletaDadosAmericanas():
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

        

def teste():
    termo_busca = "iphone 14"
    url = f"https://lista.mercadolivre.com.br/{termo_busca.replace(' ', '-')}"
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"
    }

    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        soup = BeautifulSoup(response.text, "html.parser")

        # Buscar links de produtos
        produtos = soup.find_all("a", {"class": "poly-component__title"})

        # Criar uma lista para armazenar os links dos produtos
        links_produtos = []

        if produtos:
            for produto in produtos[:10]:  # Pegando os 10 primeiros links de produtos
                link = produto.get("href")
                if link not in links_produtos:  # Verificar se o link não foi adicionado antes
                    links_produtos.append(link)

            # Agora, percorrer cada link para extrair o nome e preço
            for link in links_produtos:
                # Fazer a requisição para a página do produto
                produto_response = requests.get(link, headers=headers)
                if produto_response.status_code == 200:
                    produto_soup = BeautifulSoup(produto_response.text, "html.parser")
                    
                    # Extrair o nome do produto
                    nome_produto = produto_soup.find("h1", {"class": "ui-pdp-title"}).text.strip()
                    
                    # Extrair o preço do produto
                    preco_produto = produto_soup.find("span", {"class": "andes-money-amount__fraction"}).text.strip()
                    
                    # Imprimir nome e preço
                    print(f"Produto: {nome_produto}")
                    print(f"Preço: R$ {preco_produto}")
                    print(link)
                    print("-" * 40)
                else:
                    print(f"Erro ao acessar o produto: {link}")
        else:
            print("Nenhum produto encontrado.")
    else:
        print(f"Erro ao acessar o site. Código de status: {response.status_code}")


coletaDadosMerLivre()
