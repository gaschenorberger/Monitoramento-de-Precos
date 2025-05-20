import Carousel from "../BannerCarousel"
import { Titulo } from "../Titulo"
import StoreList from "../StoreList"
import CelularSection from "./SecaoCelulares"
import AmazonSection from "./SecaoAmazon"
import NbSection from "./SecaoNotebooks"
import HistorySection from "./SecaoHistory"
import Footer from "../Footer"
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
            <AmazonSection/>
            <NbSection/>
            <HistorySection/>
            <Footer/>
            
        </main>
    )
}

export default Main