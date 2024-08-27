import express from 'express';
import mysql from 'mysql';

const app = express();

const db = mysql.createConnection({
    host: 'localhost',
    user: "root",
    password: "2003",
    database: "bank_database"
})

// If there is an auth problem
//ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '3.yGy4CjUFQT@g';
db.connect((err) => {
    if (err) {
        console.error('Error connecting to the database:', err);
        return;
    }
    console.log('Connected to the database.');
});

app.get("/",(req,res)=>{
    res.json("Hello this is the backend")
})

app.get("/accounts", (req, res) => {
    const q = "SELECT * FROM account"
    db.query(q, (err, data)=>{
        if(err) return res.json(err)
        return res.json(data)
    })
})

app.listen(8800, () => {
  console.log('Connected to backend!.....Server is running on http://localhost:8800');
});

app.post("/books", (req,res)=>{
    const q = "INSERT INTO books(`title`, `descrip`, `cover`) VALUES (?)"
    const values = ["title from backend","description from backend","cover from backend"]
    db.query(q, [values], (err, data)=>{
        if (err) return json(err);
        return res.json(data);
    })
})