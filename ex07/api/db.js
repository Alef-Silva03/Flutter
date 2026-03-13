const mysql = require('mysql2');

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'sistema_login'
});
db.connect((err) => {
    if (err) {
        console.log("Erro ao conectar ao banco de dados: ", err);
    } else {
        console.log("Conectado com Sucesso");
    }
});
module.exports = db;