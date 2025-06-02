import { banners } from './bannerImages'
import { useKeenSlider } from "keen-slider/react"
import "keen-slider/keen-slider.min.css"
import "./style.css"
import { useEffect, useState } from 'react'

const Carousel = () => {
    const [currentSlide, setCurrentSlide] = useState(0)
    const [sliderRef, sliderInstance] = useKeenSlider({
        loop: true,
        centered: true,
        slides: {
            perView: 1,
            spacing: 16,
        },
        slideChanged(s) {
          setCurrentSlide(s.track.details.rel)
        },
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
                {banners.map((banner, idx) => (
                    <div key={banner.id} className={`keen-slider__slide ${idx === currentSlide ? 'active' : ''}`}>
                        <img src={banner.src} className='banner-image'/>
                    </div>
                ))}
            </div>
        </div>
        
    )
}

export default Carousel