// @ts-nocheck
import React, { useState } from 'react'
import './style.css'

const HistorySection = () => {
    const [isExpanded, setIsExpanded] = useState(false);
    
    const toggleText = (e) => {
        e.preventDefault();
        setIsExpanded(!isExpanded);

    }

    return(
        <div className={`historySection ${isExpanded ? 'expadend' : 'collapsed'}`}>
            <h2>Um pouquinho sobre a Preço Certo</h2>
            <section className='historyTxt'>
                <p>
                    A história da Preço Certo começou em 2025, quando os acadêmicos de Engenharia de Software Gabriel Alvise e João Gnoatto, de Cascavel-PR, decidiram criar uma plataforma inovadora para ajudar consumidores a encontrarem os melhores preços do mercado. Desde o início, nosso propósito sempre foi facilitar sua vida na hora de comprar eletrônicos, celulares, computadores, videogames e muito mais!
                    Afinal, ninguém gosta de pagar mais caro do que precisa, né?
                    Com um sistema completo de comparação de preços e ferramentas inteligentes para monitoramento, a Preço Certo te ajuda a tomar a melhor decisão de compra. Simples, rápido e confiável!
                </p>
                <p>
                    <strong>Ferramentas e diferenciais</strong><br />
                    Quer encontrar o menor preço de forma fácil e segura? Deixa com a gente!<br />
                    Com a Preço Certo, você pode: <br />
                    ✅ Comparar preços de diversos varejistas em tempo real. <br />
                    ✅ Criar alertas para acompanhar a queda de preços nos seus produtos favoritos.<br />
                    ✅ Ter acesso a uma plataforma intuitiva, transparente e sempre atualizada.<br />
                    Aqui, seu dinheiro vale mais!
                </p>
                <p>
                    <strong>Principais Categorias</strong> <br/>
                    Se tem tecnologia envolvida, a gente te ajuda a pagar menos! No Preço Certo, você encontra as melhores ofertas em:<br />
                    📱 Celulares e smartphones<br />
                    💻 Computadores e notebooks<br />
                    🎮 Videogames e acessórios<br />
                    📺 TVs e eletrônicos em geral
                </p>
                <p>
                    Nosso compromisso é garantir que você compre sempre pelo melhor preço e com total confiança!<br />
                    Então, bora economizar? Preço Certo é a sua escolha inteligente para comprar mais gastando menos! 🚀
                </p>
            </section>
            <a onClick={toggleText} className='buttonShowTxt' href="#">
                { isExpanded ? 'Mostrar Menos' : 'Mostrar Mais'}
            </a>

        </div>
    );
};

export default HistorySection;