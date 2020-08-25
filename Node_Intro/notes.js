const faker = require("faker");
const mysql = require("mysql");

// console.log(faker.internet.email());
// console.log(faker.date.past());

// function generateAddress(){
//     console.log(faker.address.streetAddress());
//     console.log(faker.address.city());
//     console.log(faker.address.state());
// }

// generateAddress();
// ----------------------------------------------------------
// HOW TO CREATE A CONNECTION BETWEEN NODE AND MYSQL:

let connection = mysql.createConnection({
    host : "localhost",
    port : "3306",
    user : "root",
    password: "18kdelport",
    database : "join_us",
});

connection.connect(function(err){
    if(err){
        console.log(err);
    }else{
        console.log("Connection has been made \n");
    }
});

// HOW TO RUN QUERIES:

// let q = "SELECT 1 + 1 AS solution";

// let query_2 = "SELECT CURTIME() AS time, CURDATE() AS date, NOW() AS now";

// let select_q = "SELECT * FROM users";

// connection.query(q, function(error, results){
//     if(error) throw error;
//     console.log("The solution is: ", results[0].solution);
    
// });

// connection.query(query_2, function(error, results){
//     if(error) throw error;
//     console.log(results[0].time);
//     console.log(results[0].date);
//     console.log(results[0].now);
// });

// connection.query(select_q, function(err, res){
//     if(err) throw err;
//     console.log("\n" + res[0].email);
//     console.log(res[0].created_at);
//     console.log(res[1].email);
//     console.log(res[1].created_at);
// });

//INSERTING DATA INTO TABLES:

// let person = {email : "Jenny456@email.com"}; // now you can see to which field you assign values

// now we can use faker to make random names every time:

let another_person = {email : faker.internet.email()};

// the SET ? here will read the object name with the value and assign values to sql accordingly
// connection.query("INSERT INTO users SET ?", person, function(err, res){
//     if(err) throw err;
//     console.log(res);
// });

connection.query("INSERT INTO users SET ?", another_person, function(err, res){
    if(err) throw err;
    console.log(res);
});

connection.end();

// THIS WILL DO THE SAME AS ABOVE QUERY:

// connection.query(q, function(error, results, fields){
//     if(error){
//         console.log(error);
//     }else{
//         console.log(results[0].solution);
//     }
// });


// HOW TO BULK INSERT DATA INTO A TABLE:

// you need an array containing arrays of data
var data = [
    ["oneemail@emai.com", "2017...."],
    ["....", "...."],
    ["....", "...."]
];

// write out the query like this:
var question = "INSERT INTO users(email, created_at) VALUES ?";

// place data array in another array here:
connection.query(q, [data], function(err, res){
    if(err) throw err;
    console.log(res);
});