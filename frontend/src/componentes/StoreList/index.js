import amazon from "../../images/amazon1.svg"
import americanas from "../../images/americanas 1.svg"
import casasBahia from "../../images/casas bahia 1.svg"
import magaLu from "../../images/magalu 1.svg"
import mercadoLivre from "../../images/mercado livre 1.svg"
import seeMore from "../../images/See More.svg"
import './style.css'

function StoreList(){
    return(
        <div className="storeList">
                <a className="storeLink" href="https://www.amazon.com.br">
                    <img className="storeLogo" src={amazon}/>
                    Amazon
                </a>
                <a className="storeLink" href="https://www.americanas.com.br">
                    <img className="storeLogo" src={americanas}/>
                    Americanas
                </a>
                <a className="storeLink" href="https://www.casasbahia.com.br">
                    <img className="storeLogo" src={casasBahia}/>
                    Casas Bahia
                </a>
                <a className="storeLink" href="https://www.magazineluiza.com.br">
                    <img className="storeLogo" src={magaLu}/>
                    MagaLu
                </a>
                <a className="storeLink" href="https://www.mercadolivre.com.br">
                    <img className="storeLogo" src={mercadoLivre}/>
                    Mercado Livre
                </a>
                <a className="storeLink" href="#">
                    <img className="storeLogo" src={seeMore}/>
                    Veja mais
                </a>
            </div>
    )
}

export default StoreList