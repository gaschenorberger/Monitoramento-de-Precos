import { Link } from "react-router-dom";
import ProductPics from "./ProductPics";
import ButtonRedirect from "../../ButtonRedirect";
import PriceHistoryChart from "./PriceHistoryChart";
import ProductGuide from "./ProductGuides";
import ComparisonSection from "./ComparisonSection";
import { useState } from "react";
import './style.css'
// import pic1 from '../../../images/10401.svg';
// import pic2 from '../../../images/1.svg';
// import pic3 from '../../../images/2.svg';
// import pic4 from '../../../images/4.svg';
import DescriptionSection from "./DescriptionSection";
import FichaTecnica from "./FichaTecnica";


function ProductContainer({produto}) {
    const [imagemPrincipal, setImagemPrincipal] = useState(produto.imagens[0]);
    
    return (
        <div className="productContainer">
            <main>
                <div className="breadcrumb">
                    <h3 className="breadcrumbText">
                        <Link to="/">Home</Link> <span className="arrowIconpPP">›</span> <a className="categoria">{produto.categoria}</a>
                    </h3>
                </div>
                <h2 className="productName">{produto.nome_produto}</h2>
                <section className="ratingContainer">
                    <svg className="ratingIcon" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.122-6.545L.488 6.91l6.564-.955L10 0l2.948 5.955 6.564.955-4.756 4.635 1.122 6.545z"/></svg>
                    <h3 className="ratingPP">{produto.avaliacoes} ({produto.nAvaliacoes}) </h3>
                </section>
                <div className="firstSectionPP">
                    <ProductPics 
                    imagens={produto.imagens}
                    imagemPrincipal={imagemPrincipal}
                    setImagemPrincipal={setImagemPrincipal}
                    />
                    <div className="productPrice">
                        <p><strong>R${produto.preco}</strong> <br/>
                        ou em até 12x de R${produto.preco_parcela}<br/>
                        menor preço via <strong className="storeName">Amazon</strong></p>
                    </div>
                    <ButtonRedirect
                        link_loja={produto.link_loja}
                    />
                </div>
                <ProductGuide/>
                <ComparisonSection />
                <DescriptionSection
                    descricao_produto={produto.descricao_produto}
                />
                <FichaTecnica dados={produto.dados_tecnicos} />
            </main>
        </div>
    )
}

export default ProductContainer