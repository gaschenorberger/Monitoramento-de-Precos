import "./style.css"

export const CardProdutos = ({ nome_produto, preco_atual, site_origem, imagem_url }) => {
    return(
      <div className="cardProdutos">
          <a href="#" className="aProduto">
            <img src={imagem_url} className="produtoIMG"/>
            <h2 className="nomeProduto" data-tooltip={nome_produto}>{nome_produto}</h2>
            <section className="ratingProduto">
              <svg className="ratingIcon" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.122-6.545L.488 6.91l6.564-.955L10 0l2.948 5.955 6.564.955-4.756 4.635 1.122 6.545z"/></svg>
              {/* {avaliacao} */}
            </section>
            
            <p className="lojaNome">Menor preço via {site_origem}</p>
            <p className="precoProduto">{preco_atual}</p>
            {/* <p className="numeroLojas">Compare entre {nLojas} lojas</p> */}
          </a>
      </div>
    
    )
}
