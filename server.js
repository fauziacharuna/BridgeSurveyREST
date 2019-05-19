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
    host: 'projectazuresql.mysql.database.azure.com',
    user: 'admindb@projectazuresql',
    port: '3306',
    password: 'adminAzure_10',
    database: 'bridgeSurvey'
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
app.get('/komponen', function (req, res) {
    mc.query('SELECT komponen_id, komponen_name, sistem_name FROM komponen k, sistem s WHERE k.sistem_id=s.sistem_id', function (error, results,fields) {
        if (error) throw error;
        return res.send({ data: results });
    });
});
app.get('/subkomponen', function (req, res) {
    mc.query('SELECT subKomponen_id,komponen_name,subKomponen_name FROM subKomponen s,komponen k where s.komponen_id = k.komponen_id', function (error, results,fields) {
        if (error) throw error;
        return res.send({ data: results });
    });
});
 
// port must be set to 8080 because incoming http requests are routed from port 80 to port 8080
app.set('port', process.env.PORT || 8081);
const server = app.listen(app.get('port'), () => {
    console.log(`Bridge Monitoring API → PORT ${server.address().port}`);
});
