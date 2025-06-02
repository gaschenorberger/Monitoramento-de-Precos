import './style.css'

const Footer = () => {
    return(
        <div className="footerContainer">
            <footer>
                <div className="highFooter">
                    <section className="destaques">
                        <h3>Destaques</h3>
                        <a href="#" className="destaquesItems">Celulares</a>
                        <a href="#" className="destaquesItems">Notebooks</a>
                        <a href="#" className="destaquesItems">Hardware</a>
                        <a href="#" className="destaquesItems">TVs</a>
                        <a href="#" className="destaquesItems">Consoles</a>
                    </section>
                    <section className="infos">
                        <h3>O Preço Certo</h3>
                        <a href="#" className="destaquesItems">Sua privacidade</a>
                        <a href="#" className="destaquesItems">Sobre o Preço Certo</a>
                        <a href="#" className="destaquesItems">Sobre o PC Cashback</a>
                        <a href="#" className="destaquesItems">Trabalhe com a gente</a>
                        <a href="#" className="destaquesItems">Ética e Integridade</a>
                    </section>
                    <section className='helpGuide'>
                        <h3>Precisa de ajuda?</h3>
                        <a href="#" className="helpButton">Tire sua dúvida</a>
                    </section>
                </div>
                <hr className="lineFooter"/>
                <div className="lowFooter">
                    <p>O uso deste site está sujeito aos termos e condições do Termo de Uso e Política de privacidade. <br/>
                    © Preço Certo. Todos os direitos reservados.</p>
                </div>
                
            </footer>
        </div>
    )
}

export default Footer