import './style.css'

import pic1 from '../../../../images/10401.svg';
import pic2 from '../../../../images/1.svg';
import pic3 from '../../../../images/2.svg';
import pic4 from '../../../../images/4.svg';

const imagens = [pic1, pic2, pic3, pic4];

export default function ProductPics({ imagens, imagemPrincipal, setImagemPrincipal }) {
    return (
        <div className="productGallery">
            <div className="thumbnails">
                {imagens.filter(img => img !== imagemPrincipal).map((img, index) => (
                    <img 
                        key={index}
                        src={img}
                        alt={`Miniatura ${index}`}
                        className="miniatura"
                        onClick={() => setImagemPrincipal(img)}
                    />
                ))}
            </div>
            <div className="mainImage">
                <img
                    src={imagemPrincipal}
                    alt='Imagem Principal do Produto'
                    className="imagem-principal"
                />  
            </div>
        </div>
    );
}