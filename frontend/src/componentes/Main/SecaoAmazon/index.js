import { CardProdutos } from "../../CardProdutos";
import { Titulo } from "../../Titulo";
import "./style.css"

const AmazonSection = ({ produtos }) => {
    return(
        <section className="amazonSection">
            <h2 className="amazonSectionTxt"><Titulo cor="#0000"
            tamanhoFonte="24px">As melhores ofertas você encontra na Amazon!</Titulo></h2>
            <div className="produtosAmazon">
                {produtos.slice(0,4).map((produtos, id) => (
                    <CardProdutos key={id} {...produtos} />
                ))}
            </div>
        </section>
    )
    
}

export default AmazonSection