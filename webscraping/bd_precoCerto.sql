-- ESTRUTURA BANCO DE DADOS
/*TABELA LOJAS
    id
    nome

TABELA PRODUTOS
    id
    nome

TABELA PRECOS
    id
    produto_id
    loja_id
    preco
    link_produto
    href_img
    data_captura
*/

-- p.nome == produto nome || l.nome == loja nome




select * from lojas;
select * from produtos;
select * from precos;



-- ALTERAR ID LOJA

-- 1. Desabilita a constraint temporariamente
ALTER TABLE precos DROP CONSTRAINT precos_loja_id_fkey;

-- 2. Atualiza o ID na tabela lojas
UPDATE lojas
SET id = 2
WHERE id = 28;

-- 3. Atualiza os registros na tabela precos
UPDATE precos
SET loja_id = 2
WHERE loja_id = 28;

-- 4. Recria a constraint
ALTER TABLE precos
ADD CONSTRAINT precos_loja_id_fkey FOREIGN KEY (loja_id) REFERENCES lojas(id);

--------------------------------------------------------------------------------------


-- INSERIR NOVAS LOJAS

select * from lojas;
INSERT INTO lojas VALUES (3, 'Mercado Livre');

------------------------------------------------------------------------------------------




-- VIEWS

-- Produtos coletados hoje:

-- DDS == DADOS

CREATE OR REPLACE VIEW DDS_COLETADOS_HOJE AS
    SELECT p.nome AS produto, l.nome AS loja, pr.preco, pr.link_produto, pr.href_img
        FROM precos pr
            JOIN produtos p ON p.id = pr.produto_id
            JOIN lojas l ON l.id = pr.loja_id
        WHERE pr.data_captura = CURRENT_DATE;


-- Histórico de um produto específico:

SELECT pr.data_captura, l.nome AS loja, pr.preco
    FROM precos pr
        JOIN lojas l ON l.id = pr.loja_id
    WHERE pr.produto_id = 1
        ORDER BY pr.data_captura;


SELECT 

