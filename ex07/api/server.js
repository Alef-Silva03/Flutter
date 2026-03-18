
/*
const express = require('express'); // express = configura o caminho da API
const cors = require('cors'); // arquivo principal da construção da API
const userRoutes = require('./routes/userRoutes'); // lê a rota da API

const app = express();//consertar aqui

app.use(cors());

app.use(express.json()); // atinge as requisições HTTP

app.use('/usuarios',userRoutes); // atingir a tabela do banco

app.get('/',(req,res)=>{
    res.send('API Funcionando');
});

app.get('/usuarios',(req,res)=>{
    res.json({mensagem: "Rota Funcionando"});
});

app.listen(3000,()=>
{
    console.log('Servidor rodando na porta 3000');
});
*/
const express = require('express');
const cors = require('cors');
const userRoutes = require('./routes/userRoutes');

const app = express();

app.use(cors());
app.use(express.json());

app.use('/usuarios', userRoutes);

app.get('/', (req,res)=>{
  res.send('API funcionando');
});

app.get('/usuarios', (req,res)=>{
  res.json({mensagem:"Rota funcionando"});
});

app.listen(3000,()=>{
  console.log('Servidor rodando na porta 3000');
});

//novos códigos:
const path = require('path');//direcionamento 
const multer = require('multer');
// Configuração do armazenamento
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/'); // pasta onde salva
  },
  filename: (req, file, cb) => {
    const nomeArquivo = Date.now() + path.extname(file.originalname);
    cb(null, nomeArquivo);
  },
});

// Criar o upload
const upload = multer({ storage });

app.use("/uploads", express.static("uploads"));
app.use("/produtos", require("./routes/productRoutes"));

// Serve arquivos da pasta "uploads"
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Simulação de banco de dados em memória
let produtos = [];
app.get('/produtos', (req, res) => {
  res.json(produtos);
});

app.post('/produtos', (req, res) => {
  const { nome, preco, descricao } = req.body;
  const id = produtos.length + 1;
  const produto = { id, nome, preco, descricao, imagem: "" };
  produtos.push(produto);
  res.status(201).json(produto);
});

app.post('/produtos', upload.single('imagem'), (req, res) => {
  const { nome, preco, descricao } = req.body;

  console.log(req.file); // TESTE

  const produto = {
    id: Date.now(),
    nome,
    preco,
    descricao,
    imagem: req.file ? req.file.filename : "",
  };

  produtos.push(produto);

  res.status(201).json(produto);
});