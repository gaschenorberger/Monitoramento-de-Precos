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
    // axios.get('https://precocerto.onrender.com/produtos') //WEB
    axios.get('http://localhost:3001/produtos') // LOCAL
      .then((res) => setProdutos(res.data))
      .catch((err) => console.error("Erro ao buscar produtos:", err));
  }, []);

  function getRandomItems(arr, num) {
    const shuffled = arr.sort(() => 0.5 - Math.random());
    return shuffled.slice(0, num);
  }

  const smartphone = getRandomItems(produtos.filter(p => p.nome_categoria === "Smartphone"), 4);
  const notebook = getRandomItems(produtos.filter(p => p.nome_categoria === "Notebook"), 4);
  const amazon = getRandomItems(produtos.filter(p => p.site_origem === "Amazon"), 4);

  return (
    <main>
      <div className='carousel-full-width'>
        <Carousel />
      </div>

      <Titulo cor="#0000" tamanhoFonte="24px">
        Comparação de preços e cashback é no Preço Certo!
      </Titulo>

      <StoreList />
      <CelularSection produtos={smartphone} />
      <AmazonSection produtos={amazon} />
      <NbSection produtos={notebook} />
      <HistorySection />
      <Footer />
    </main>
  );
}

export default Main;