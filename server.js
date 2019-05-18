const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const mysql = require('mysql');
const morgan = require('morgan');

 
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
}));
// connection configurations
const mc = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    port: '5700',
    password: 'root',
    database: 'BridgeSurvey'
});

morgan.token('id', function getId(req) {
    return req.id
});

var loggerFormat = ':id [:date[web]] ":method :url" :status :response-time';

app.use(morgan(loggerFormat, {
    skip: function (req, res) {
        return res.statusCode < 400
    },
    stream: process.stderr
}));

app.use(morgan(loggerFormat, {
    skip: function (req, res) {
        return res.statusCode >= 400
    },
    stream: process.stdout
}));

 
// connect to database
mc.connect(); 
 
// default route
app.get('/', function (req, res) {
    return res.send({ error: true, message: 'hello' })
});
app.get('/sistem', function (req, res) {
    mc.query('SELECT * FROM sistem', function (error, results,fields) {
        if (error) throw error;
        return res.send({ data: results });
    });
});
 
// port must be set to 8080 because incoming http requests are routed from port 80 to port 8080
app.listen(5000, function () {
    console.log('Node app is running on port 8080');
});
