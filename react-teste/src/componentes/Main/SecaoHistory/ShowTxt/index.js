
import HistorySection from '..';
import './style.css'

export const ShowTxt = () => {
    function ShowTxtClick(e, {historySection}){
        e.preventDefault();
        let showTxt = document.querySelector('.buttonShowTxt')
        let historySection = {HistorySection}
        if(showTxt.textContent === "Mostrar Menos"){
            showTxt.textContent = "Mostrar Mais"

        
    }

    return(
        <a onClick={ShowTxtClick} className='buttonShowTxt' href="#">Mostrar Menos</a>
    ) 
}