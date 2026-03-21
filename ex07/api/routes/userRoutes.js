const express = require('express');
const router = express.Router();
const db = require('../db');

router.post(
    '/register',(req,res)=>{
        const {login,senha,nome,cpf,email,data_nascimento,foto} = req.body;
        const sql = `insert into usuarios
    (login,senha,nome,cpf,email,data_nascimento,foto) values
    (?,?,?,?,?,?,?)`;
    
    db.query(sql,[login,senha,nome,cpf,email,data_nascimento,foto],(err,result)=>{
        if(err){
            console.log(err);
            return res.status(500).json({erro:err});
        }
        res.status(201).json({mensage:"Usuário Cadastrado com Sucesso"});
    });
});

router.post('/login',(req,res)=>{
    const {login,senha} = req.body;
    const sql =`select * from usuarios where login = ? and senha = ?`;
    db.query(sql,[login,senha],(err,result)=>{
        if(err){
            return res.status(500).json({erro:err});
        }
        if (result.length > 0) {
            res.json(result[0]);
        }else{
            res.status(401).json({message: "Usuário Inválido"});
        }
    });
});

router.get('/',(req,res)=>{
    const sql = "select * from usuarios";

    db.query(sql, (err,result)=>{
        if (err) {
            return res.status(500).json({erro:err});
        }
        res.status(200).json(result);
    });
});
module.exports = router;