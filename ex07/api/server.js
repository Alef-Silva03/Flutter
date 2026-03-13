const express = require('express');// express = configura o caminho da API
const cors = require('cors');// arquivo principal da contrução da API
const userRoutes = require('./routes/userRoutes');// lê a rota da API

const app = express();

app.use(cors());

app.use(express.json());// atinge as requisições HTTP

app.use('/usuarios', userRoutes);// atingir a tabela do banco

app.get('/', (req, res) => {
    res.send('API Funcionando');
});

app.listen(3000, () => {
    console.log('Servidor rodando na porta 3000');
});