import { banners } from './bannerImages'
import { useKeenSlider } from "keen-slider/react"
import "keen-slider/keen-slider.min.css"
import "./style.css"
import { useEffect } from 'react'

const Carousel = () => {
    const [sliderRef, sliderInstance] = useKeenSlider({
        loop: true,
        centered: true,
        slides: {
            perView: "auto",
            spacing: 16,
        }
    })

    useEffect(() => {

    if (!sliderInstance) return

    const interval = setInterval(() => {
        sliderInstance.current?.next()
    }, 3000)

    return() => clearInterval(interval)
    }, [sliderInstance])

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