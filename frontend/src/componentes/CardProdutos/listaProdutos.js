import { useEffect, useState } from 'react';
import axios from 'axios';

  
        // nome: "Celular Apple iPhone 16 Pro Max 256GB",
        // avaliacao: "4.8(974)", 
        // loja: "Amazon",
        // preco: "R$ 8.896,78",
        // nlojas: "13",
        // img: IP16,
        // id: 1,
        // category: "celulares"
  

function dadosProdutos() {
    const [produtos, setProdutos] = useState([]);

    useEffect(() => {
        axios.get("http://localhost:3001/produtos")
        .then(Response => setProdutos(Response.data))
        .catch(error => console.error('Error ao buscar produtos:', error));
    }, []);

    return (
        <>
        
        </>
    )
}