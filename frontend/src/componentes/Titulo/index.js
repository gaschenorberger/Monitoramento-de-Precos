import styled from "styled-components"

export const Titulo = styled.h2`
    margin-left: 17%;
    justify-content: center;
    margin-top: 71px;
    font-size: ${props => props.tamanhoFonte};

    @media(max-width: 1174px){
         margin-left: 20px;
    }
`