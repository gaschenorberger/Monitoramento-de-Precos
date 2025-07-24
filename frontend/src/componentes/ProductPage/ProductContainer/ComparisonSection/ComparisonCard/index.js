import imgProduct from '../../../../../images/10401.svg'
import ButtonRedirect from '../../../../ButtonRedirect'

export default function ComparisonCard(imagem, nome_produto, img_loja, loja, preco){
    return(
        <div>
            <img className='cc_productIMG' src={imagem}/>
            <h6>{nome_produto}</h6>
            <p>R${preco}</p>
            <section className='cc_loja'>
                <img src={img_loja}/>
                <p>{loja}</p>
            </section>
            <ButtonRedirect/>
        </div>
    )
}