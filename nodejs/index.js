const mysql = require('mysql2');
const express = require('express');
var app = express();
const bodyparser = require('body-parser');

app.use(bodyparser.json());


var mysqlConnection = mysql.createConnection({
    host: 'localhost',
    user: '',
    password: '',
    database: 'sopet'
});

mysqlConnection.connect((err) => {
    if(!err)
    console.log("DB connect");
    else
    console.log(err);
});

app.listen(3000, ()=>console.log('listen port 3000'));

app.get('/getvet',(req,res)=>{
    sql = 'select * from vet natural join vet_plid natural join vet_ba';
    mysqlConnection.query(sql,(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    });
});

app.get('/getuser/:id',(req,res)=>{
    sql = 'select * from client natural join Client_Subdistrict natural join Client_Province_Country where client_id = ?';
    mysqlConnection.query(sql,[req.params.id],(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    });
});

app.get('/getuserandwallet/:id',(req,res)=>{
    sql = 'select Firstname_TH, Lastname_TH, Profile_picture_URL,Current_amount, Wallet_ID from client natural join wallet where client_id = ?';
    mysqlConnection.query(sql,[req.params.id],(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    });
});

app.get('/deletepayment/:id/:date/:amount',(req,res)=>{
    sql = "delete from Payment_history where Wallet_ID = ? and Payment_history_datetime = ? and Payment_history_amount = ?";
    sql2 = "UPDATE wallet SET current_amount = current_amount+? WHERE wallet_id = ?";
    mysqlConnection.query("Start Transaction",(err,row,fields) => {});
    mysqlConnection.query(sql,[req.params.id,req.params.date,req.params.amount],(err,rows,fields)=>{
        if(!err){
            console.log(sql,[req.params.id,req.params.date,req.params.amount]);
            mysqlConnection.query(sql2,[req.params.amount,req.params.id],(err2,rows2,fields2)=>{
                if(!err2){
                    console.log('update');
                    mysqlConnection.query("COMMIT",(err3,row3,fields3) => {
                    if(!err3)
                        res.send("finish");
                    else
                        console.log(err3);
                    });
                }
                else{
                    mysqlConnection.query("ROLLBACK",(err4,row4,fields4) => {});
                }
            });
        }
        else{
            console.log(err);
            mysqlConnection.query("ROLLBACK",(er5r,row5,fields5) => {});
        }
    });
});

app.get('/getpayment/:id',(req,res)=>{
    sql = 'select * from wallet natural join Payment_history where client_id = ?';
    mysqlConnection.query(sql,[req.params.id],(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    });
});

app.get('/inserttopupt/:id/:date/:amount',(req,res)=>{
    sql = 'insert into topup_history values (?,?,?)';
    mysqlConnection.query(sql,[req.params.id,req.params.date,req.params.amount],(err,rows,fields)=>{
        if(!err)
        res.send("insert complete");
        else
        console.log(err);
    });
});

app.get('/getservice/:id',(req,res)=>{
    sql = 'call getServiceHistory(?)';
    mysqlConnection.query(sql,[req.params.id],(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    });
});

