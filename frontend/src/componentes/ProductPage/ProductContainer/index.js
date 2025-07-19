import { Link } from "react-router-dom";
import ProductPics from "./ProductPics";
import ButtonRedirect from "../../ButtonRedirect";
import { useState } from "react";
import './style.css'

import pic1 from '../../../images/10401.svg';
import pic2 from '../../../images/1.svg';
import pic3 from '../../../images/2.svg';
import pic4 from '../../../images/4.svg';


function ProductContainer({nome_produto, categoria, avaliacoes, nAvaliacoes, preco, preco_parcela,}) {
    const imagens = [ pic2, pic3, pic4];
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
                        <p><strong>R${preco}</strong> <br/>
                        ou em até 12x de R${preco_parcela}</p>
                    </div>
                    <ButtonRedirect
                        loja="AMAZON"
                        link_loja="https://www.amazon.com.br/Apple-iPhone-Pro-Max-256/dp/B0DGMG19VS/ref=asc_df_B0DGMG19VS?mcid=4c7031bba5a034bc908b1a276d0e9c1d&tag=googleshopp00-20&linkCode=df0&hvadid=709964503130&hvpos=&hvnetw=g&hvrand=10608435488934353047&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9102141&hvtargid=pla-2364698376136&language=pt_BR&gad_source=1&th=1"
                    />
                </div>
                
            </main>
        </div>
    )
}

export default ProductContainer