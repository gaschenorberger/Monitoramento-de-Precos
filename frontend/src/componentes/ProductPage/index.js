import './style.css'
import Header from '../Header'
import ProductContainer from './ProductContainer'
import Footer from '../Footer'

function ProductPage() {
    return (
       <div>
            <Header/>
            <ProductContainer 
                categoria="Celulares"
                nome_produto="Celular Apple iPhone 16 Pro Max 256GB"
                avaliacoes="4.8"
                nAvaliacoes="956"
                preco="8.896,78"
                preco_parcela="889,67"
            />
       </div>
    )
}

export default ProductPage