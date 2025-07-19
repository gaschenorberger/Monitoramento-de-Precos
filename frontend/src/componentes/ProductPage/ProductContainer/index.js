import { Link } from "react-router-dom";
import ProductPics from "./ProductPics";
import { useState } from "react";
import './style.css'

import pic1 from '../../../images/10401.svg';
import pic2 from '../../../images/1.svg';
import pic3 from '../../../images/2.svg';
import pic4 from '../../../images/4.svg';


function ProductContainer({nome_produto, categoria, avaliacoes, nAvaliacoes, preco, preco_parcela}) {
    const imagens = [pic1, pic2, pic3, pic4];
    const [imagemPrincipal, setImagemPrincipal] = useState(imagens[0]);

    return (
        <div className="productContainer">
            <main>
                <div className="breadcrumb">
                    <h3 className="breadcrumbText">
                        <Link to="/">Home</Link> <span className="arrowIconpPP">›</span> <a className="categoria">{categoria}</a>
                    </h3>
                </div>
                <h2 className="productName">{nome_produto}</h2>
                <section className="ratingContainer">
                    <svg className="ratingIcon" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.122-6.545L.488 6.91l6.564-.955L10 0l2.948 5.955 6.564.955-4.756 4.635 1.122 6.545z"/></svg>
                    <h3 className="ratingPP">{avaliacoes} ({nAvaliacoes}) </h3>
                </section>
                <div className="firstSectionPP">
                    <ProductPics 
                    imagens={imagens}
                    imagemPrincipal={imagemPrincipal}
                    setImagemPrincipal={setImagemPrincipal}
                    />
                    <div className="productPrice">
                        <h2>R${preco}</h2>
                        <h3>ou em até 12x de {preco_parcela}</h3>
                    </div>
                </div>
                
            </main>
        </div>
    )
}

export default ProductContainer