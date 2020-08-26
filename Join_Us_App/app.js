const express = require("express");
const mysql = require("mysql");
const bodyparser = require("body-parser");

const app = express();
app.set("view engine", "ejs");
app.use(bodyparser.urlencoded({ extended: true }));
app.use(express.static(__dirname + "/public"));

let connection = mysql.createConnection({
  host: "localhost",
  port: "3306",
  user: "root",
  password: "18kdelport",
  database: "join_us",
});

connection.connect(function (err) {
  if (!err) {
    console.log("Successfully connected to DB");
  }
});

app.get("/", function (req, res) {
  let q = "SELECT COUNT(*) AS count FROM users";
  connection.query(q, function (err, results) {
    if (err) throw err;
    let count = results[0].count;
    // res.send(`You have ${count} users in your DB.`);
    res.render("home", { data: count });
  });
});

// app.get("/joke", function(req, res){
//     let joke = "What do you call a dog that does magic? A labracadabradore!";
//     res.send(joke);
// });

// app.get("/random", function(req, res){
//     let num = Math.floor(Math.random() * 10 + 1);
//     res.send("Your lucky number is " + num);
// });

app.post("/register", function (req, res) {
  let person = { email: req.body.email };
  connection.query("INSERT INTO users SET ?", person, function (error) {
    if (error) throw error;
    res.redirect("/");
  });
});

app.listen(3000, function (err) {
  if (!err) {
    console.log("Server started on port 3000");
  }
});
