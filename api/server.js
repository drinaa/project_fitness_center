const mysql = require("mysql2");
const express = require("express");
const bodyParser = require("body-parser");

const app = express();
const urlencodedParser = bodyParser.urlencoded({extended: false});

const pool = mysql.createPool({
    connectionLimit: 5,
    host: "localhost",
    user: "root",
    database: "fitness_center",
    password: "vertrigo"
});

app.use(function(req, res, next) {
    res.header('Access-Control-Allow-Origin', "*");
    res.header('Access-Control-Allow-Methods','GET,PUT,POST,DELETE');
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    next();
})


app.get("/gyms", function(req, res){
    pool.query("SELECT name FROM gyms", function(err, data) {
        if(err) return console.log(err);
        res.send(data)
    });
});
app.get("/coaches", function(req, res){
    pool.query("SELECT * FROM coaches", function(err, data) {
        if(err) return console.log(err);
        console.log(data);
        res.send(data)
    });
});

app.get("/coaches_forms", function(req, res){
    pool.query("SELECT last_name, first_name FROM coaches", function(err, data) {
        if(err) return console.log(err);
        console.log(data);  
        res.send(data)
    });
});

app.post("/create_workout", urlencodedParser, function (req, res) {

    if(!req.body) return res.sendStatus(400);
    const c_last_name = req.body.customer_last_name;
    const c_first_name = req.body.customer_first_name;
    const c_phone = req.body.customer_phone;
    const coach_id = req.body.coach;
    const w_date = req.body.workout_date;
    const w_time = req.body.workout_time;

    pool.query("SELECT * FROM customers WHERE phone=?", [c_phone], function(err, data) {
        if (err) return console.log(err);
        if (data != ""){
            pool.query("INSERT INTO workouts (customer_id, coach_id, w_date, w_time) VALUES (?,?,?,?)", [data[0].id, coach_id, w_date, w_time], function(err, data) {
                     if(err) return console.log(err);
                     console.log("datas added")
                     res.send("success");
                 });
        }
        else{
            pool.query("INSERT INTO customers (last_name, first_name, phone) VALUES (?,?,?)", [c_last_name, c_first_name, c_phone], function(err, data) {
                if(err) return console.log(err);
                console.log("customer added");
            });
            pool.query("INSERT INTO workouts (SELECT LAST_INSERT_ID, coach_id, w_date, w_time) VALUES (?,?,?)", [coach_id, w_date, w_time], function(err, data) {
                if(err) return console.log(err);
                console.log("datas added");
                res.send("success");
            });
        }
    });
});

app.listen(3000, function(){
    console.log("Сервер ожидает подключения...");
});