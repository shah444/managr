const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        var data = {
            event_id: message.event_id,
            person_id: message.person_id,
        };
        console.log(data);
        createAccount(data, connection).then((answer) => {
            connection.release();
            process.send({"Success": "RSVP Changed"})
            process.exit();
        }).catch((error)=>{
            console.log(error); 
            process.send({"Error": "RSVP Not Changed"})
            connection.release(); 
            process.exit();
        });
    });
});

const createAccount = (data, connection) => {
    var event_id = data.event_id;
    var person_id = data.person_id;
    var attending;
    var query1 = `SELECT * FROM rsvp WHERE event_id = ${event_id} AND person_id = ${person_id};`
    console.log(query1);
    return new Promise(async (resolve, reject) => {
        connection.query(query1, (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }
            try {
                attending = result[0].attending;
                if(attending == 1) {
                    attending = 0;
                }
                else {
                    attending =1;
                }
                var query2 = `UPDATE rsvp SET attending = '${attending}' WHERE event_id = '${event_id}' AND person_id = '${person_id}';`
                connection.query(query2, (err, result) => {
                    if(err){
                        console.log(err);
                        reject(err.message);
                    }
                    resolve("changed");
                });
                }
                catch(error){
                    reject(err.message);
                }
            console.log(result);
            resolve(result);
        });
    });
};