import { produtos } from "../../CardProdutos/dadosProdutos";
import { CardProdutos } from "../../CardProdutos";
import { Titulo } from "../../Titulo";
import "./style.css"

const CelularSection = () => {
    const celulares = produtos.filter(p => p.category === "celulares");

    return(
        <section className="celularSection">
            <h2 className="celularSectionTxt"><Titulo cor="#0000"
            tamanhoFonte="24px">Encontre o celular ideal, com a melhor oferta!</Titulo></h2>
            <div className="produtosCelular">
                {celulares.slice(0,4).map((produtos, id) => (
                    <CardProdutos key={id} {...produtos} />
                ))}
            </div>
        </section>
    )
    
}

export default CelularSection