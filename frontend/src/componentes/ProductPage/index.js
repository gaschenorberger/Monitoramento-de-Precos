import './style.css'
import Header from '../Header'
import ProductContainer from './ProductContainer'
import Footer from '../Footer'
import img1 from '../../images/1.svg';
import img2 from '../../images/2.svg';
import img3 from '../../images/4.svg';

const mockProduto = {
    id:"iphone-16-pro-max",
    categoria: "Celulares",
    nome_produto: "Celular Apple iPhone 16 Pro Max 256GB",
    avaliacoes: "4.8",
    nAvaliacoes: "956",
    preco: "8.896,78",
    preco_parcela: "889,67",
    descricao_produto: `Apple iPhone 16 Pro Max 256GB Titânio-deserto 6,9 48MP iOS 5G
    iPhone 16 Pro Max. Com estrutura em titânio, Controle da Câmera, 4K Dolby Vision a 120 qps e o chip A18 Pro. Avisos legais *As telas têm bordas arredondadas. Quando medida como um retângulo, a tela tem 6,12 polegadas (iPhone 16), 6,69 polegadas (iPhone 16 Plus), 6,27 polegadas (iPhone 16 Pro) ou 6,86 polegadas (iPhone 16 Pro Max) na diagonal. A área real de visualização é menor. **A duração da bateria varia de acordo com o uso e a configuração. Consulte apple.com/br/batteries para obter mais informações. ***Acessórios vendidos separadamente. ****Alguns recursos podem não estar disponíveis em todos os países ou regiões. *****O iPhone 16 e o iPhone 16 Pro são capazes de identificar um acidente grave de carro e ligar para os serviços de emergência. Requer uma conexão de rede celular ou chamadas Wi-Fi.`,
    dados_tecnicos: {
        "Marca": "Apple",
        "Ano de lançamento": "2024",
        "Linha": "iPhone",
        "Série": "Pro Max",
        "Tipo de Aparelho": "Smartphone",
        "Cores": "Azul, Verde, Preto",
        "Tamanho da Tela": "6,8”"
    },
    imagens: [
        img1, img2, img3,
    ],
    link_loja: "https://www.amazon.com.br/Apple-iPhone-Pro-Max-256/dp/B0DGMG19VS/ref=asc_df_B0DGMG19VS?...",
    loja: "Amazon"
    
};

function ProductPage() {
    return (
       <div>
            <Header/>
            <ProductContainer produto={mockProduto} />
            <Footer />
       </div>
    )
}

export default ProductPage