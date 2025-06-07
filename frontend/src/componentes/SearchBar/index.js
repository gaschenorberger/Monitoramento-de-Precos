import './style.css'

function SearchBar(){
    return(
        <div className="searchBar">
                <select className="categoriasSelect">
                    <option className='optionSelect'><b>Todas as categorias</b></option>
                    <option><b>iPhone</b></option>
                    <option><b>Samsung</b></option>
                    <option><b>Notebook</b></option>
                    <option><b>Smartwatch</b></option>
                    <option><b>Headphone</b></option>
                    <option><b>Smartphone</b></option>
                    <option><b>Outros</b></option>
                </select>
                <input type="text" placeholder="Digite sua busca..."/>
                <button>
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                  </svg></button>
            </div>
    )
}

export default SearchBar
