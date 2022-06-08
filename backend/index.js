const express = require('express')
const app = express()
const cors = require("cors")
const mysql2 = require("mysql2")

app.use(cors())
app.use(express.json())

const db = mysql2.createConnection({
    user: "root",
    host: "localhost",
    password: "Password1",
    database: "employee_db"
})

app.get("/api/read", (req, res) => {
    db.query("SELECT * FROM employees", (err, result) => {
        if (err) {
            console.log(err);
        } else {
            console.log("sending /read results over to frontend")
            res.send(result)
        }
    })
})

app.delete("/api/delete/:id", (req, res) => {
    const id = req.params.id;
    console.log("DELETED employee with id = " + JSON.stringify(id))
    db.query("DELETE FROM employees WHERE id = ?", id, (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.send(result);
        }
    })
})

app.post("/api/create", (req, res) => {
    const name = req.body.name;
    const description = req.body.description;
    const age = req.body.age;

    db.query(
        "INSERT INTO employees (name, description, age) VALUES (?, ?, ?)",
        [name, description, age],
        (err, results) => {
            if (err) {
                console.log(err);
            } else {
                res.send("SUCCESS: Values inserted.")
            }
        }
    )
})

app.put("/api/update", (req, res) => {
    const id = req.body.id;
    const description = req.body.description;
    const age = req.body.age;

    db.query(
        "UPDATE employees SET description = ?, age = ? WHERE id = ?", [description, age, id],
        (err, result) => {
            if (err) {
                console.log(err)
            } else {
                res.send(result)
            }
        }
    )
})

const port = process.env.PORT || 8081;
app.listen(port, () => console.log(`listening on port ${port}..`))