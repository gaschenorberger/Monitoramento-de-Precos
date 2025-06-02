DROP TABLE usuarios CASCADE;
DROP TABLE produtos CASCADE;
DROP TABLE produtos_categorias CASCADE;
DROP TABLE produtos_monitorados CASCADE;
DROP TABLE categorias CASCADE;

SELECT * FROM usuarios;
SELECT * FROM produtos;
SELECT * FROM produtos_categorias;
SELECT * FROM produtos_monitorados;
SELECT * FROM categorias;

TRUNCATE TABLE categorias; -- LIMPA TODOS OS DADOS DA TABELA, PORÉM NAO APAGA OS RELACIONAMENTOS



-- ==========================
-- Tabela de Usuários
-- ==========================

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    senha_hash VARCHAR(200) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ==========================
-- Tabela de Produtos
-- ==========================
CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    preco_atual DECIMAL(10, 2) NOT NULL,
    url TEXT NOT NULL,
    imagem_url TEXT,
    site_origem VARCHAR(100) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ==========================
-- Tabela de Relacionamento Produtos-Categorias
-- (Produtos podem ter varias categorias)
-- ==========================
CREATE TABLE produtos_categorias (
    produto_id INT NOT NULL,
    categoria_id INT NOT NULL,
    PRIMARY KEY (produto_id, categoria_id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE CASCADE
);


-- ==========================
-- Tabela de Histórico de Preços
-- ==========================
CREATE TABLE historico_precos (
    id SERIAL PRIMARY KEY,
    produto_id INT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    coletado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
);


-- ==========================
-- Tabela de Produtos Monitorados pelo Usuário
-- (Quando o usuário adiciona um produto específico para acompanhar)
-- ==========================
CREATE TABLE produtos_monitorados (
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL,
    produto_id INT NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
);


-- ==========================
-- Tabela de Categorias
-- ==========================

CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL
);


INSERT INTO categorias (nome) VALUES
('iPhone'),
('Samsung'),
('Notebook'),
('Smartwatch'),
('Headphone'),
('Ofertas');

select * from categorias;



