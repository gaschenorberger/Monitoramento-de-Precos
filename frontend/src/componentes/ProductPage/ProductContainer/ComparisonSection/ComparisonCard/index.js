import "./style.css"
import ButtonRedirect from '../../../../ButtonRedirect'

export default function ComparisonCard({imagem, nome_produto, img_loja, loja, preco, link_loja}){
    return(
        <div className='comparisonCard'>
            <img className='cc_productIMG' src={imagem}/>
            <h6>{nome_produto}</h6>
            <p className="precoProduto">R${preco}</p>
            <img src={img_loja}/>
            <p className="nomeLoja">{loja}</p>
            <ButtonRedirect
                loja="LOJA"
                link_loja={link_loja}
            />
        </div>
    )
}