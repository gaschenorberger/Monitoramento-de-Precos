import logo from '../../images/logo.svg';
import '../Logo/style.css';

function Logo(){
    return(
        <div className="logo">
            <a href="../App.js">
                <img src={logo} alt="Logo"/>
            </a>
        </div>
    )
}

export default Logo