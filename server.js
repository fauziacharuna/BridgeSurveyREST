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
    return res.send({
        error: true,
        message: 'hello'
    })
});
app.get('/sistem', function (req, res) {
    mc.query('SELECT * FROM sistem', function (error, results, fields) {
        if (error) throw error;
        return res.send({
            allSistem: results
        });
    });
});
app.get('/komponen', function (req, res) {
    mc.query('SELECT komponen_id, komponen_name, sistem_name FROM komponen k, sistem s WHERE k.sistem_id=s.sistem_id', function (error, results, fields) {
        if (error) throw error;
        return res.send({
            allKomponen: results
        });
    });
});
app.get('/subkomponen', function (req, res) {
    mc.query('SELECT subKomponen_id,komponen_name,subKomponen_name,sistem_name FROM subkomponen s,komponen k,sistem st  where s.komponen_id = k.komponen_id AND k.sistem_id=st.sistem_id', function (error, results, fields) {
        if (error) throw error;
        return res.send({
            allSubKomponen: results
        });
    });
});

app.get('/answer', function (req, res) {
    mc.query('SELECT answer_id,bridge_location,bridge_name,sistem_name,komponen_name,subKomponen_name,surveyor_name,bahan_name,kerusakan,interval_kerusakan,luasan,luasan2,nilai_pengurang,faktor_koreksi,faktor_nilai1,faktor_nilai2,bobot_komponen,IKSK,IKUS,IKKJ,IKS FROM answer a ,bridge b , sistem s ,bahan bh ,komponen k ,subkomponen sk ,surveyor su WHERE a.bahan_id=bh.bahan_id AND a.bridge_id = b.bridge_id AND a.sistem_id = s.sistem_id AND a.komponen_id = k.komponen_id AND a.subKomponen_id = sk.subKomponen_id AND a.surveyor_id = su.surveyor_id', function (error, results, fields) {
        if (error) throw error;
        return res.send({
            allAnswer: results
        });
    });
});


app.get('/engineer', function (req, res) {
    mc.query('SELECT * from surveyor', function (error, results, fields) {
        if (error) throw error;
        return res.send({
            allEngineer: results
        });
    });
});
app.get('/surveyorbridge', function (req, res) {
    mc.query('SELECT surveyor_name, bridge_name as bridge_surveyed, bridge_location  FROM answer a, bridge b, surveyor s WHERE a.surveyor_id=s.surveyor_id AND a.bridge_id=b.bridge_id ', function (error, results, fields) {
        if (error) throw error;
        return res.send({
            allSurveyed: results
        });
    });
});
app.get('/bridge', function (req, res) {
    mc.query('SELECT bridge_location, bridge_name, kerusakan FROM answer a ,bridge b WHERE  a.bridge_id = b.bridge_id', function (error, results, fields) {
        if (error) throw error;
        return res.send({
            allBridge: results
        });
    });
});
// POST METHOD
app.post('/addanswer', function (req, res) {

    let bridgeId = req.body.bridge_id;
    let komponenId = req.body.komponen_id;
    let sistemId = req.body.sistem_id;
    let surveyorId= req.body.surveyor_id;
    let subkomponenId = req.body.subkomponen_id;
    let bahanId = req.body.bahan_id;
    let rusak = req.body.kerusakan;
    let interval = req.body.interval_kerusakan;
    let luas = req.body.luasan;
    let luas2 = req.body.luasan2;
    let pengurang = req.body.nilai_pengurang;
    let koreksi = req.body.faktor_koreksi;
    let nilai1 = req.body.faktor_nilai1;
    let nilai2 = req.body.faktor_nilai2;
    let bobotKomponen = req.body.bobot_komponen;
    let iksk = req.body.IKSK;
    let ikus = req.body.IKUS;
    let ikkj = req.body.IKKJ;
    let iks = req.body.IKS;


    if (!bridgeId  || !surveyorId || !komponenId || !subkomponenId || !sistemId  || !bahanId|| !rusak || !interval || !luas ||
        !luas2 || !pengurang || !koreksi || !nilai1 || !nilai2 || !bobotKomponen || !iksk || !ikus || !ikkj || !iks) {
        return res.status(400).send({
            error: true,
            message: 'Please provide answer'
        });
    }

    mc.query("INSERT INTO answer SET ? ", {
        surveyor_id: surveyorId,
        bridge_id: bridgeId,
        komponen_id: komponenId,
        sistem_id: sistemId,
        bahan_id: bahanId,
        kerusakan: rusak,
        interval_kerusakan: interval,
        luasan: luas,
        luasan2: luas2,
        nilai_pengurang: pengurang,
        faktor_koreksi: koreksi,
        faktor_nilai1: nilai1,
        faktor_nilai2: nilai2,
        bobot_komponen: bobotKomponen,
        IKSK: iksk,
        IKUS: ikus,
        IKKJ: ikkj,
        IKS: iks

    }, function (error, results, fields) {
        if (error) throw error;
        return res.send({
            error: false,
            data: results,
            message: 'New bridge has been created successfully.'
        });
    });
});

// Add a new todo  
app.post('/addbridge', function (req, res) {

    let name = req.body.bridge_name;
    let location = req.body.bridge_location;

    if (!name) {
        return res.status(400).send({
            error: true,
            message: 'Please provide task'
        });
    }

    mc.query("INSERT INTO bridge SET ? ", {
        bridge_name: name,
        bridge_location: location
    }, function (error, results, fields) {
        if (error) throw error;
        return res.send({
            error: false,
            data: results,
            message: 'New bridge has been created successfully.'
        });
    });
});

app.post('/addengineer', function (req, res) {

    let name = req.body.surveyor_name;
    let work = req.body.surveyor_work;

    if (!name) {
        return res.status(400).send({
            error: true,
            message: 'Please provide engineer'
        });
    }

    mc.query("INSERT INTO surveyor SET ? ", {
        surveyor_name: name,
        surveyor_work: work
    }, function (error, results, fields) {
        if (error) throw error;
        return res.send({
            error: false,
            data: results,
            message: 'New engineer has been created successfully.'
        });
    });
});

// PUT METHOD

app.put('/edit/engineer', function (req, res) {

    let id = req.body.surveyor_id;
    let name = req.body.surveyor_name;
    let work = req.body.surveyor_work;

    if (!id || !name || !work) {
        return res.status(400).send({
            error: name,
            work,
            message: 'Please provide name, work and id'
        });
    }

    mc.query("UPDATE surveyor SET surveyor_name = ?, surveyor_work=? WHERE surveyor_id = ?", [name, work, id], function (error, results, fields) {
        if (error) throw error;
        return res.send({
            error: false,
            data: results,
            message: 'surveyor has been updated successfully.'
        });
    });
});
app.put('/edit/bridge', function (req, res) {

    let id = req.body.bridge_id;
    let name = req.body.bridge_name;
    let location = req.body.bridge_location;

    if (!id || !name || !location) {
        return res.status(400).send({
            error: name,
            work,
            message: 'Please provide name, and location'
        });
    }

    mc.query("UPDATE bridge  SET bridge_name = ?, bridge_location =? WHERE bridge_id = ?", [name, location, id], function (error, results, fields) {
        if (error) throw error;
        return res.send({
            error: false,
            data: results,
            message: 'bridge has been updated successfully.'
        });
    });
});

app.put('/edit/answer', function (req, res) {
    let answerId=req.body.answer_id;
    let bridgeId = req.body.bridge_id;
    let komponenId = req.body.komponen_id;
    let sistemId = req.body.sistem_id;
    let surveyorId= req.body.surveyor_id;
    let subkomponenId = req.body.subkomponen_id;
    let bahanId = req.body.bahan_id;
    let rusak = req.body.kerusakan;
    let interval = req.body.interval_kerusakan;
    let luas = req.body.luasan;
    let luas2 = req.body.luasan2;
    let pengurang = req.body.nilai_pengurang;
    let koreksi = req.body.faktor_koreksi;
    let nilai1 = req.body.faktor_nilai1;
    let nilai2 = req.body.faktor_nilai2;
    let bobotKomponen = req.body.bobot_komponen;
    let iksk = req.body.IKSK;
    let ikus = req.body.IKUS;
    let ikkj = req.body.IKKJ;
    let iks = req.body.IKS;

    if (!answerId || !bridgeId || !komponenId || !sistemId || !surveyorId || !subkomponenId || ! bahanId || !rusak || !interval || !luas
        || !luas2 || !pengurang || ! koreksi || ! nilai1 || !nilai2 || ! bobotKomponen ||!iksk || ! ikus ||!ikkj ||!iks) {
        return res.status(400).send({
            error: name,
            work,
            message: 'Please provide answer!'
        });
    }

    mc.query("UPDATE answer SET bridge_id   = ?, sistem_id=?, komponen_id=?, subKomponen_id=?, surveyor_id=?, bridge_id=?, bahan_id=?, kerusakan=?, interval_kerusakan=?,luasan=?, luasan2=?, nilai_pengurang=?,faktor_koreksi=?, faktor_nilai1=?,faktor_nilai2=?, bobot_komponen=?, IKSK=?, IKUS=?, IKKJ=?, IKS=? WHERE answer_id = ?", 
    [bridgeId,sistemId,komponenId,subkomponenId,surveyorId, bridgeId,bahanId,kerusakan,interval,luas,luas2,pengurang,koreksi,nilai1,nilai2,bobotKomponen,iksk,ikus,ikkj,iks], function (error, results, fields) {
        if (error) throw error;
        return res.send({
            error: false,
            data: results,
            message: 'answer has been updated successfully.'
        });
    });
});

// DELETE METHOD

app.delete('/delete/engineer', function (req, res) {

    let id = req.body.surveyor_id;

    if (!id) {
        return res.status(400).send({
            error: true,
            message: 'Please provide id'
        });
    }
    mc.query('DELETE FROM surveyor WHERE surveyor_id = ?', [id], function (error, results, fields) {
        if (error) throw error;
        return res.send({
            error: false,
            data: results,
            message: 'Surveyor has been updated successfully.'
        });
    });
});
app.delete('/delete/bridge', function (req, res) {

    let id = req.body.bridge_id;

    if (!id) {
        return res.status(400).send({
            error: true,
            message: 'Please provide id'
        });
    }
    mc.query('DELETE FROM bridge WHERE bridge_id = ?', [id], function (error, results, fields) {
        if (error) throw error;
        return res.send({
            error: false,
            data: results,
            message: 'bridge has been updated successfully.'
        });
    });
});



// port must be set to 8080 because incoming http requests are routed from port 80 to port 8080
app.set('port', process.env.PORT || 8081);
const server = app.listen(app.get('port'), () => {
    console.log(`Bridge Monitoring API → PORT ${server.address().port}`);
});