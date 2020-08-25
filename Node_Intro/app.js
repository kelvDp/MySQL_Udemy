const faker = require("faker");
const mysql = require("mysql");

let connection = mysql.createConnection({
    host : "localhost",
    port : "3306",
    user : "root",
    password: "18kdelport",
    database : "join_us"
});

connection.connect(function(err){
    if(err){
        console.log(err);
    }else{
        console.log("Connection successful");
    }
});

// INSERTING 500 USERS INTO DB:

let data = [];
let query = "INSERT INTO users(email, created_at) VALUES ?";

for(let i = 0; i < 500; i++){
    data.push([
        faker.internet.email(),
        faker.date.past()
    ]);
};

connection.query(query, [data], function(err, res){
    if(err) throw err;
    console.log(res);
});

connection.end();