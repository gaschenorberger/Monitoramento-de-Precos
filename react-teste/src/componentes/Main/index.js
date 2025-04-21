import Carousel from "../BannerCarousel"
import { Titulo } from "../Titulo"
import StoreList from "../StoreList"
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
            <Titulo cor="#0000"
            tamanhoFonte="24px">Encontre o celular ideal, com a melhor oferta!</Titulo>
        </main>
    )
}

export default Main