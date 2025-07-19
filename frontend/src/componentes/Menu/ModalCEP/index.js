import './style.css'

export default function ModalCEP({ show, onClose }){
    if (!show) return null;

    return (
        <div className="overlay">
            <div className="modal">
                <button className="close-btn" onClick={onClose}>X</button>
                <h2>Busque a sua localização</h2>
                <input type="text" placeholder="Informe o seu CEP"/>
                <button className="usar-btn">Buscar</button>
            </div>
        </div>
    )
}