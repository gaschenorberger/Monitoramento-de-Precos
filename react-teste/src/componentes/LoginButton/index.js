import loginImage from '../../images/login imagem.svg'
import './style.css'

function LoginButton(){
    return(
        <button className="loginButton">
                    <img className="loginImage" src={loginImage} alt=""/>
                    <span className="loginText"> Entrar </span> <br/>
                    <span className="atvCashback">Ativar Cashback</span>
        </button>
    )
}

export default LoginButton