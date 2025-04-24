import Carousel from "../BannerCarousel"
import { Titulo } from "../Titulo"
import StoreList from "../StoreList"
import CelularSection from "../CardProdutos/SecaoCelulares"
import './style.css'


function Main(){
    return(
        <main>
            <div className='carousel-full-width'>
                <Carousel/>
            </div>
            <Titulo cor="#0000"
            tamanhoFonte="24px">Comparação de preços e cashback é no Preço Certo!</Titulo>
            <StoreList/>
            <CelularSection/>
            
        </main>
    )
}

export default Main