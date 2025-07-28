import './style.css'

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