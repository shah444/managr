const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        var data = {
            event_id: message.event_id,
            event_title: message.event_title,
            event_details: message.event_details,
        };
        console.log(data);
        editEvent(data, connection).then((answer) => {
            connection.release();
            process.send({"Success": "Event Changed"})
            process.exit();
        }).catch((error)=>{
            console.log(error); 
            process.send({"Error": "Event Not Changed"})
            connection.release(); 
            process.exit();
        });
    });
});

const editEvent = (data, connection) => {
    var event_id = data.event_id;
    var event_details = data.event_details;
    var event_title = data.event_title;
    var query1 = `SELECT * FROM events WHERE event_id = ${event_id};`
    console.log(query1);
    return new Promise(async (resolve, reject) => {
        connection.query(query1, (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }
            try {
                var query2 = `UPDATE events SET event_title = '${event_title}', details = '${event_details}' WHERE event_id = '${event_id}';`
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