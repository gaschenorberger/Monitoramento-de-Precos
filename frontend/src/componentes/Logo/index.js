import logo from '../../images/logo.svg';
import logoMin from '../../images/logo minimalista sem fundo.svg'
import '../Logo/style.css';

function Logo(){
    return(
        <>
            <div className="logo">
                <a href="/">
                    <img src={logo} alt="Logo"/>
                </a>
            </div>
            <div className='logoMin'>
                <a href="/">
                    <img src={logoMin} alt="LogoMin"/>
                </a>
            </div>
        </>
        
    )
}

export default Logo