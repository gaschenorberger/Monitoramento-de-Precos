import './style.css'

export default function ButtonRedirect({loja, link_loja}){
    return (
        <div className="buttonRedirect"> 
            <a href={link_loja}>IR PARA {loja}</a>
        </div>
    )
}