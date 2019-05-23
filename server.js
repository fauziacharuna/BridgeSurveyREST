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
// const mc = mysql.createConnection({
//     host: 'projectazuresql.mysql.database.azure.com',
//     user: 'admindb@projectazuresql',
//     port: '3306',
//     password: 'adminAzure_10',
//     database: 'bridgeSurvey'
// });
const mc = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        port: '5700',
        password: 'root',
        database: 'bridgesurvey'
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
    mc.query('SELECT subKomponen_id,komponen_name,subKomponen_name FROM subkomponen s,komponen k where s.komponen_id = k.komponen_id', function (error, results,fields) {
        if (error) throw error;
        return res.send({ data: results });
    });
});

app.get('/answer', function (req, res) {
    mc.query('SELECT answer_id,bridge_location,bridge_name,sistem_name,komponen_name,subKomponen_name,surveyor_name,kerusakan,interval_kerusakan,luasan,luasan2,nilai_pengurang,faktor_koreksi,faktor_nilai1,faktor_nilai2,bobot_komponen,IKSK,IKUS,IKKJ,IKS FROM answer a ,bridge b , sistem s ,komponen k ,subkomponen sk ,surveyor su WHERE a.bridge_id = b.bridge_id AND a.sistem_id = s.sistem_id AND a.komponen_id = k.komponen_id AND a.subKomponen_id = sk.subKomponen_id AND a.surveyor_id = su.surveyor_id', function (error, results,fields) {
        if (error) throw error;
        return res.send({ data: results });
    });
});

app.get('/engineer', function (req, res) {
    mc.query('SELECT * from surveyor', function (error, results,fields) {
        if (error) throw error;
        return res.send({ data: results });
    });
});

// Add a new todo  
app.post('/addbridge', function (req, res) {
 
    let name = req.body.bridge_name;
    let location = req.body.bridge_location;
 
    if (!name) {
        return res.status(400).send({ error:true, message: 'Please provide task' });
    }
 
    mc.query("INSERT INTO bridge SET ? ", { bridge_name:name,bridge_location:location }, function (error, results, fields) {
        if (error) throw error;
        return res.send({ error: false, data: results, message: 'New bridge has been created successfully.' });
    });
});

app.post('/addengineer', function (req, res) {
 
    let name = req.body.surveyor_name;
    let work = req.body.surveyor_work;
 
    if (!name) {
        return res.status(400).send({ error:true, message: 'Please provide engineer' });
    }
 
    mc.query("INSERT INTO surveyor SET ? ", { surveyor_name:name,surveyor_work:work }, function (error, results, fields) {
        if (error) throw error;
        return res.send({ error: false, data: results, message: 'New engineer has been created successfully.' });
    });
});

app.put('/edit/engineer', function (req, res) {
 
    let id = req.body.surveyor_id;
    let name = req.body.surveyor_name;
    let work =req.body.surveyor_work;
 
    if (!id|| !name|| !work) {
        return res.status(400).send({ error: name,work, message: 'Please provide name, work and id' });
    }
 
    mc.query("UPDATE surveyor SET surveyor_name = ?, surveyor_work=? WHERE surveyor_id = ?", [name,work, id], function (error, results, fields) {
        if (error) throw error;
        return res.send({ error: false, data: results, message: 'surveyor has been updated successfully.' });
    });
});

app.delete('/delete/engineer', function (req, res) {
 
    let id= req.body.surveyor_id;
 
    if (!id) {
        return res.status(400).send({ error: true, message: 'Please provide id' });
    }
    mc.query('DELETE FROM surveyor WHERE surveyor_id = ?', [id], function (error, results, fields) {
        if (error) throw error;
        return res.send({ error: false, data: results, message: 'Surveyor has been updated successfully.' });
    });
}); 


 
// port must be set to 8080 because incoming http requests are routed from port 80 to port 8080
app.set('port', process.env.PORT || 8081);
const server = app.listen(app.get('port'), () => {
    console.log(`Bridge Monitoring API → PORT ${server.address().port}`);
});
