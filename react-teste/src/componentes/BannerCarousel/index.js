import { banners } from './bannerImages'
import { useKeenSlider } from "keen-slider/react"
import "keen-slider/keen-slider.min.css"
import "./style.css"

const Carousel = () => {
    const [sliderRef] = useKeenSlider({
        loop: true,
        slides: {
            perView: 1,
            spacing: 10,
        }
    })

    return (
        <div className="carousel-wrapper">
            <div ref={sliderRef} className="keen-slider custom-carousel">
                {banners.map((banner) => (
                    <div key={banner.id} className="keen-slider__slide">
                        <img src={banner.src} className='banner-image'/>
                    </div>
                ))}
            </div>
        </div>
        
    )
}

export default Carousel