// import dotenv npm package so we can access our enivroment variables
require("dotenv").config();
// import express npm package
const express = require("express");
// import mysql npm package so we can access our DB
const mysql = require("mysql");
/* import bodyParser npm package so we can read POST forms
Note: bodyparser is deprecated - it is currently included with express */
// const bodyParser = require('body-parser');

// call express to initialize our app
const app = express();

//by default looks in a views folder for ejs files
app.set("view engine", "ejs");

/* how we would have called bodyParser:
app.use(bodyParser.urlencoded({extended: true})); */
//Since bodyParser is deprecated we now get the same functionality with express.urlencoded()
app.use(express.urlencoded({ extended: true }));

//linking to our public folder so we can access our css file from our views/home.ejs.
app.use(express.static(__dirname + "/public"));

// connection to our DB
const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  database: "join_us",
  password: process.env.MY_SQL_PASS,
});

// post route - '/register' matches the route we specified in our form.
app.post("/register", function (req, res) {
  /* since email is the name we specified to our input we can access the input
 in our request body with req.body.email */
  const person = { email: req.body.email };
  connection.query("INSERT INTO users SET ?", person, function (err, result) {
    if (err) throw err;
    // redirect to whatever page we want to render with res.render or res.redirect
    res.redirect("/");
  });
});

//get route
app.get("/", function (req, res) {
  // Find count of users in DB
  var q = "SELECT COUNT(*) AS count FROM users";
  connection.query(q, function (error, results) {
    if (error) throw error;
    // mysql gives us an array so we have to use [0]
    console.log(results[0]);
    const count = results[0].count;
    // link to our home.ejs and pass our data through.
    res.render("home", { count: count });
  });
});

app.get("/joke", function (req, res) {
  const joke =
    "<strong>What do you call a dog that does magic tricks?</strong> <em>A labracadabrador</em>";
  res.send(joke);
});

app.get("/random_num", function (req, res) {
  const random = Math.floor(Math.random() * 10) + 1;
  res.send("Your lucky number is " + random);
});

// listening on port 3000
app.listen(3000, function () {
  console.log("Server running on 3000");
});
