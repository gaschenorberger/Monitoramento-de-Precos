const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
app.use(cors());
app.use(express.json());

// CONECTANDO NO BANCO
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'bdPrecoCerto',
    password: '123',
    port: 5432,
});

pool.connect()
  .then(client => {
    console.log('Conectado ao PostgreSQL');
    client.release();
  })
  .catch(err => console.error('Erro ao conectar no PostgreSQL', err.stack));


app.get('/produtos', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM VW_PRODUTOS_CATEGORIAS');
        res.json(result.rows);
    } catch (error) {
        console.error('Erro ao buscar produtos:', error);
        res.status(500).send('Erro no servidor');
    }
});

app.listen(3001, () => {
    console.log('Servidor rodando na porta 3001');
});
