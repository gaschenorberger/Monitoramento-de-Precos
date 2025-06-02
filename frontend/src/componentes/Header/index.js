import Logo from '../Logo/index'
import SearchBar from '../SearchBar'
import UserActions from '../UserActions'
import './style.css'

function Header(){
    return(
        <header className="navbar">
            <Logo/>
            <SearchBar/>
            <UserActions/>
        </header>
    )
}

export default Header