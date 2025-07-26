import { Titulo } from '../../../Titulo';
import './style.css'

export default function FichaTecnica({dados}) {
    if (!dados || Object.keys(dados).length === 0) return null;

    return (
        <div id='ficha' className='fichaSection'> 
            <h2 className="descriptionTitle">
                <Titulo 
                    cor="#0000"
                    tamanhoFonte="24px">Ficha Técnica
                </Titulo>
            </h2>
            <div className='fichaBox'>
                <table className='ficha-tabela'>
                    <tbody>
                        {Object.entries(dados).map(([campo, valor], index) => (
                            <tr key={campo} className={index % 2 !== 0 ? 'ficha-linha-alternada' : ''}>
                            <td className="ficha-campo">{campo}</td>
                            <td className="ficha-valor">{valor}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
            
        </div>
    )
}