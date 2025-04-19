import Carousel from "../BannerCarousel"
import './style.css'

function Main(){
    return(
        <main>
            <div className='carousel-full-width'>
                <Carousel/>
            </div>
            <h1 className="titlePage">Comparação de preços e cashback é no Preço Certo!</h1>
        </main>
    )
}

export default Main