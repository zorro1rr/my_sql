const faker = require("faker");
const mysql = require("mysql");
require("dotenv").config();

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  database: "join_us",
  password: process.env.MY_SQL_PASS,
});
//selecting data
const q = "SELECT * FROM users";

connection.query(q, function (error, results, fields) {
  if (error) throw error;
  console.log(results);
});

//inserting data
// const q = "INSERT INTO users(email) VALUES ('rusty_the_dog@gmail.com')";

// connection.query(q, function (error, results, fields) {
//   if (error) throw error;
//   console.log(results);
// });

//inserting data take 2 with SET ?
// const person = { email: "Jenny467@gmail.com" };

// connection.query(
//   "INSERT INTO users SET ?",
//   person,
//   function (error, results, fields) {
//     if (error) throw error;
//     console.log(results);
//   }
// );

//inserting data with faker
// const person = {
//   email: faker.internet.email(),
//   created_at: faker.date.past(),
// };

// connection.query(
//   "INSERT INTO users SET ?",
//   person,
//   function (error, results, fields) {
//     if (error) throw error;
//     console.log(results);
//   }
// );

//inserting bulk data - mysql node package syntax takes nested array
var data = [];
for (var i = 0; i < 500; i++) {
  data.push([faker.internet.email(), faker.date.past()]);
}

var q = "INSERT INTO users (email, created_at) VALUES ?";

connection.query(q, [data], function (err, result) {
  console.log(err);
  console.log(result);
});

connection.end();
