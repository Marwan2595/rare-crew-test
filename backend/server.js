require('dotenv').config()
const express = require('express');
const app = express();
const jwt = require('jsonwebtoken')

app.use(express.json())

const allRefrashTokens = [];
const users = [
    {
        username: "admin",
        password: "12345",
        name: "Admin 1",
        phone: "01036497786",
        gender: "male",
    },
    {
        username: "admin2",
        password: "12345",
        name: "Admin 2",
        phone: "01036497786",
        gender: "male",
    },
    {
        username: "admin3",
        password: "12345",
        name: "Admin 3",
        phone: "01036497786",
        gender: "female",
    },
    {
        username: "admin4",
        password: "12345",
        name: "Admin 4",
        phone: "01036497786",
        gender: "male",
    },
]
app.get('/user', authenticateToken, (req, res) => {
    res.json(users.find(user => user.username === req.user.username))
})
function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]
    if (token == null) return res.sendStatus(401)

    jwt.verify(token, process.env.ACCESS_TOKEN, (err, user) => {
        console.log(err)
        if (err) return res.sendStatus(403)
        req.user = user
        next()
    })
}
function newAccessToken(user) {
    return jwt.sign(user, process.env.ACCESS_TOKEN, { expiresIn: '30m' });
}


app.post('/login', async (req, res) => {
    const user = users.find(user => user.username == req.body.username)
    console.log(user)
    if (user === null || user == undefined) {
        return res.status(400).send("Wrong Username")
    }
    try {
        if (req.body.password == user.password) {
            const accessToken = newAccessToken(user);
            const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN);
            allRefrashTokens.push(refreshToken);
            res.json({ accessToken: accessToken, refreshToken: refreshToken })
        } else {
            res.send("Wrong Password")
        }
    } catch (error) {
        return res.status(500).send()
    }
})


app.post('/token', async (req, res) => {
    const refreshToken = req.body.refreshToken;
    if (refreshToken == null || refreshToken == undefined) {
        res.sendStatus(401)
    } else if (!allRefrashTokens.includes(refreshToken)) {
        res.sendStatus(401)
    } else {
        jwt.verify(refreshToken, process.env.REFRESH_TOKEN, (error, user) => {
            if (error) {
                res.sendStatus(403)
            } else {
                const accessToken = newAccessToken(user);
                res.json({ accessToken: accessToken, refreshToken: refreshToken })
            }
        })
    }

})
app.listen(3000)