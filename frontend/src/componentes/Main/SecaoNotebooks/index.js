import { CardProdutos } from "../../CardProdutos";
import { Titulo } from "../../Titulo";
import "./style.css";

const NbSection = ({ produtos }) => {
    return(
        <section className="nbSection">
            <h2 className="nbSectionTxt"><Titulo cor="#0000"
            tamanhoFonte="24px">Notebook de qualidade, somente aqui na Preço Certo!</Titulo></h2>
            <div className="produtosNb">
                {produtos.slice(0,4).map((produtos, id) => (
                    <CardProdutos key={id} {...produtos} />
                ))}
            </div>
        </section>
    )
    
}

export default NbSection