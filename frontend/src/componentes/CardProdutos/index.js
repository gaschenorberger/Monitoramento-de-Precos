import "./style.css"

export const CardProdutos = ({ nome, avaliacao, loja, preco, nLojas, img, category}) => {
    return(
      <div className="cardProdutos">
          <a href="#" className="aProduto">
            <img src={img} className="produtoIMG"/>
            <h2 className="nomeProduto"> {nome} </h2>
            <section className="ratingProduto">
              <svg className="ratingIcon" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.122-6.545L.488 6.91l6.564-.955L10 0l2.948 5.955 6.564.955-4.756 4.635 1.122 6.545z"/></svg>
              {avaliacao}
            </section>
            
            <p className="lojaNome">Menor preço via {loja}</p>
            <p className="precoProduto">{preco}</p>
            <p className="numeroLojas">Compare entre {nLojas} lojas</p>
          </a>
      </div>
    
    )
}
