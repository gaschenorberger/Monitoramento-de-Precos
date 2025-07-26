import { Titulo } from '../../../Titulo'
import './style.css'

export default function DescriptionSection({descricao_produto}){
    return(
        <div id='descricao' className='descriptionSection'>
            <h2 className="descriptionTitle"><Titulo cor="#0000"
            tamanhoFonte="24px">Descrição</Titulo></h2>
            <div className='descriptionBox'>
                <p>
                    {descricao_produto}
                </p>
            </div>
        </div>
    )
}