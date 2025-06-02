import { CardProdutos } from "../../CardProdutos";
import { Titulo } from "../../Titulo";
import "./style.css"

const CelularSection = ({ produtos }) => {
    return(
        <section className="celularSection">
            <h2 className="celularSectionTxt"><Titulo cor="#0000"
            tamanhoFonte="24px">Encontre o celular ideal, com a melhor oferta!</Titulo></h2>
            <div className="produtosCelular">
                {produtos.slice(0,4).map((produtos, id) => (
                    <CardProdutos key={id} {...produtos} />
                ))}
            </div>
        </section>
    )
    
}

export default CelularSection