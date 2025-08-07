// WEB


// import express from 'express';
// import cors from 'cors';
// import pkg from 'pg';

// const { Pool } = pkg;

// const app = express();
// app.use(cors());
// app.use(express.json());

// const pool = new Pool({
//   connectionString: 'postgresql://bd_precocerto_user:Lptizk3SMOVsutR6MlqsisbsLyjfYHgY@dpg-d1m8elmmcj7s739vqot0-a.oregon-postgres.render.com:5432/bd_precocerto',
//   ssl: {
//     rejectUnauthorized: false // obrigatório para Render em ambiente local
//   },
//   max: 5,
//   idleTimeoutMillis: 30000,
//   connectionTimeoutMillis: 10000 // 10 segundos
// });


// pool.connect()
//   .then(client => {
//     console.log('Conectado ao PostgreSQL');
//     client.release();
//   })
//   .catch(err => console.error('Erro ao conectar no PostgreSQL', err.stack));

// app.get('/', (req, res) => {
//   res.send('API PrecoCerto rodando!');
// });

// app.get('/produtos', async (req, res) => {
//   try {
//     const result = await pool.query('SELECT * FROM VW_PRODUTOS_TL_INICIAL');
//     res.json(result.rows);
//   } catch (error) {
//     console.error('Erro ao buscar produtos:', error);
//     res.status(500).send('Erro no servidor');
//   }
// });

// const PORT = process.env.PORT || 3001;
// app.listen(PORT, () => {
//   console.log(`Servidor rodando na porta ${PORT}`);
// });



//-----------------------------------

//LOCAL

import express from 'express';
import cors from 'cors';
import pkg from 'pg';
const { Pool } = pkg;

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
        const result = await pool.query('SELECT * FROM VW_PRODUTOS_TL_INICIAL');
        res.json(result.rows);
    } catch (error) {
        console.error('Erro ao buscar produtos:', error);
        res.status(500).send('Erro no servidor');
    }
});

app.listen(3001, () => {
    console.log('Servidor rodando na porta 3001');
});
