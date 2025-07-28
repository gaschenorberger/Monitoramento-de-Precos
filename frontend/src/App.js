import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Header from './componentes/Header';
import Menu from './componentes/Menu';
import Main from './componentes/Main';
import ProductPage from './componentes/ProductPage';
import './App.css';

function App() {
  return (
    <Router>
      <Header />
      <Menu />
      <Routes>
        <Route path="/" element={<Main />} />
        <Route path="/produto/:id" element={<ProductPage />} />
      </Routes>
    </Router>
  );
}

export default App;
