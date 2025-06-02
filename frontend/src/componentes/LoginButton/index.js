import loginImage from '../../images/login imagem.svg';
import './style.css';

function LoginButton(){
    return (
        <button className="loginButton">
            <img className="loginImage" src={loginImage} alt="ícone de login" />
            
            <div className="loginTextWrapper">
                <span className="loginText">Entrar</span>
                <span className="atvCashback">cashback</span>
            </div>

            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" className="arrowIcon" viewBox="0 0 16 16">
                <path fillRule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708"/>
            </svg>
        </button>
    );
}

export default LoginButton;
