DROP TABLE usuarios CASCADE;
DROP TABLE produtos CASCADE;
DROP TABLE produtos_categorias CASCADE;
DROP TABLE produtos_monitorados CASCADE;
DROP TABLE categorias CASCADE;

SELECT * FROM usuarios
ORDER BY id ASC;

SELECT * FROM produtos
ORDER BY id ASC;

SELECT * FROM produtos_categorias;

SELECT * FROM produtos_monitorados
ORDER BY id ASC;

SELECT * FROM categorias
ORDER BY id ASC;



TRUNCATE TABLE categorias; -- LIMPA TODOS OS DADOS DA TABELA, PORÉM NAO APAGA OS RELACIONAMENTOS
DELETE FROM categorias;




-- ZERAR ID 

DELETE FROM categorias;
ALTER SEQUENCE categorias_id_seq RESTART WITH 1;

--------------------------------







-- ==========================
-- ALTERAR NOME DE COLUNAS
-- ==========================

ALTER TABLE TBL_PRODUTOS_TELA_INI
RENAME COLUMN nome TO nome_produto;

ALTER TABLE TBL_PRODUTOS_TELA_INI
RENAME COLUMN preco_atual TO preco;







-- ==========================
-- ALTERAR NOME DE TABELAS
-- ==========================

ALTER TABLE PRODUTOS
RENAME TO TBL_PRODUTOS_TELA_INI -- PRODUTOS EXTRAIDOS DA TELA INICIAL SITE (WEBSCRAPING)

ALTER TABLE PRODUTOS_MONITORADOS
RENAME TO TBL_PDTOS_MONITORADOS_USR -- PRODUTOS MONITORADOS PELOS USUARIOS

ALTER TABLE PRODUTOS_CATEGORIAS
RENAME TO TBL_PRODUTOS_CATEGORIAS -- PRODUTOS X CATEGORIAS

ALTER TABLE CATEGORIAS
RENAME TO TBL_CATEGORIAS_PDTOS -- CATEGORIA DOS PRODUTOS

ALTER TABLE HISTORICO_PRECOS
RENAME TO TBL_HISTORICO_PRECOS_PDTOS -- HITORICO DE PREÇO DE CADA PRODUTO

ALTER TABLE LOJAS
RENAME TO TBL_LOJAS -- TABELA COM NOME DAS LOJAS

ALTER TABLE USUARIOS
RENAME TO TBL_USUARIOS -- INFORMAÇÕES DO USUARIO










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
('Smartphone')
('Outros');

select * from categorias;



-- ===============================================
-- VIEWS
-- ===============================================


-- VIEW PRA PUXAR CATEGORIAS ESPECIFICAS

CREATE OR REPLACE VIEW VW_PRODUTOS_CATEGORIAS AS
SELECT
    p.id AS produto_id,
    p.nome AS nome_produto,
    p.preco_atual,
    p.url,
    p.imagem_url,
    p.site_origem,
    p.criado_em,
    c.id AS categoria_id,
    c.nome AS nome_categoria
FROM
    produtos p
JOIN TBL_PRODUTOS_TELA_INI pc ON p.id = pc.produto_id
JOIN categorias c ON pc.categoria_id = c.id;


-- SELECTS PARA EXIBIR NA BUSCA DE CAREGORIAS DO SITE

SELECT * 
FROM VW_PRODUTOS_CATEGORIAS
WHERE nome_categoria = 'iPhone';

SELECT * 
FROM VW_PRODUTOS_CATEGORIAS
WHERE nome_categoria = 'Samsung';

SELECT * 
FROM VW_PRODUTOS_CATEGORIAS
WHERE nome_categoria = 'Notebook';

SELECT * 
FROM VW_PRODUTOS_CATEGORIAS
WHERE nome_categoria = 'Smartwatch';

SELECT * 
FROM VW_PRODUTOS_CATEGORIAS
WHERE nome_categoria = 'Headphone';

SELECT * 
FROM VW_PRODUTOS_CATEGORIAS
WHERE nome_categoria = 'Smartphone';

SELECT * 
FROM VW_PRODUTOS_CATEGORIAS
WHERE nome_categoria = 'Outros';





DELETE FROM produtos;
ALTER SEQUENCE produtos_id_seq RESTART WITH 1;

DELETE FROM lojas;
ALTER SEQUENCE lojas_id_seq RESTART WITH 1;

DELETE FROM categorias;
ALTER SEQUENCE categorias_id_seq RESTART WITH 1;

INSERT INTO categorias (nome) VALUES
('iPhone'),
('Samsung'),
('Notebook'),
('Smartwatch'),
('Headphone'),
('Smartphone'),
('Outros');



-- ME RETORNA TODOS OS PRODUTOS DA MAGAZINE LUIZA -- TRANSFORMAR EM VIEW

CREATE VIEW AS VW_PRODUTOS_MAGAZINE
    SELECT DISTINCT 
        produto_id,
        nome_produto,
        preco_atual,
        url,
        imagem_url,
        site_origem,
        criado_em
    FROM VW_PRODUTOS_CATEGORIAS
    WHERE site_origem = 'Magazine Luiza';