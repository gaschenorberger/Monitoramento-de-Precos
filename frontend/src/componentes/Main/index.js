import { useEffect, useState } from "react";
import Carousel from "../BannerCarousel";
import { Titulo } from "../Titulo";
import StoreList from "../StoreList";
import CelularSection from "./SecaoCelulares";
import AmazonSection from "./SecaoAmazon";
import NbSection from "./SecaoNotebooks";
import HistorySection from "./SecaoHistory";
import Footer from "../Footer";
import './style.css';
import axios from 'axios';

function Main() {
  const [produtos, setProdutos] = useState([]);

  useEffect(() => {
    axios.get("#") //colocar o link da api aqui!!
      .then((res) => setProdutos(res.data))
      .catch((err) => console.error("Erro ao buscar produtos:", err));
  }, []);

  const celulares = produtos.filter(p => p.category === "Celulares");
  const notebooks = produtos.filter(p => p.category === "Notebooks");
  const amazon = produtos.filter(p => p.loja === "Amazon");

  return (
    <main>
      <div className='carousel-full-width'>
        <Carousel />
      </div>

      <Titulo cor="#0000" tamanhoFonte="24px">
        Comparação de preços e cashback é no Preço Certo!
      </Titulo>

      <StoreList />
      <CelularSection produtos={celulares} />
      <AmazonSection produtos={amazon} />
      <NbSection produtos={notebooks} />
      <HistorySection />
      <Footer />
    </main>
  );
}

export default Main;