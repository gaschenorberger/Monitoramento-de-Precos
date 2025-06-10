import './style.css';
import loginImage from '../../images/login imagem.svg';

function LoginButton() {
  return (
    <button className="loginButton">
      <div className="loginIconWrapper">
        <img className="loginImage" src={loginImage} alt="ícone de login" />
      </div>

      <div className="loginTextWrapper">
        <span className="loginText">Entrar</span>
        <span className="atvCashback">ativar cashback</span>
      </div>

      <span className="arrowIcon">›</span>
    </button>
  );
}

export default LoginButton;
