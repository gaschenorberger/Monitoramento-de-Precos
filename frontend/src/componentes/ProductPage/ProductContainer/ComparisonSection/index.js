import ComparisonCard from "./ComparisonCard";
import imgProduct from '../../../../images/10401.svg'
import { Titulo } from "../../../Titulo";
import magaLu from "../../../../images/magalu 1.svg"
import "./style.css"


export default function ComparisonSection(){
    return(
        <div id="compare" className="comparisonSection">
             <h2 className="descriptionTitle"><Titulo cor="#0000"
                tamanhoFonte="24px">Compare os Preços</Titulo></h2>
            <div className="comparisonContainer">
                <ComparisonCard 
                    imagem={imgProduct}
                    nome_produto="Celular Apple iPhone 16 Pro Max 256GB"
                    preco="11.128,95"
                    loja="Magazine Luiza"
                    link_loja="https://www.magazineluiza.com.br/iphone-16-pro-max-apple-256gb-camera-tripla-de-48mp-tela-69-titanio-natural/p/cb5dec9356/te/16pm"
                />
                <ComparisonCard 
                    imagem={imgProduct}
                    nome_produto="Celular Apple iPhone 16 Pro Max 256GB"
                    preco="10.859,00"
                    loja="Casas Bahia"
                    link_loja="https://www.casasbahia.com.br/apple-iphone-16-pro-max-256gb-titanio-natural/p/1569802688?utm_medium=Cpc&utm_source=GP_PLA&IdSku=1569802688&idLojista=35821&tipoLojista=3P&gclsrc=aw.ds&&utm_campaign=cb_mkp_gg_shopping_sellers_abaixo10&gad_source=1&gad_campaignid=22788743736&gclid=Cj0KCQjw-ZHEBhCxARIsAGGN96J-GeSwMgf8JiRudooOh8s3ITfjq8FDWMCpI9FYyOItyEG3UHy_v8waAl-2EALw_wcB"
                />
                <ComparisonCard 
                    imagem={imgProduct}
                    nome_produto="Celular Apple iPhone 16 Pro Max 256GB"
                    preco="9.899,10"
                    loja="Americanas"
                    link_loja="https://www.americanas.com.br/apple-iphone-16-pro-max-256gb-titanio-natural-7508564123/p"
                />
            

            </div>
        </div>
    )
}