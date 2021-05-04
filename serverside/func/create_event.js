const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        console.log(message);
        var data = {
            evdate: message.date,
            room_id: message.room_id,
            event_title: message.event_title,
            details: message.details
        };
        console.log(data);
        createEvent(data, connection).then((answer) => {
            connection.release();
            process.send({"Success": "Event created"})
            process.exit();
        }).catch((error)=>{
            console.log(error); 
            process.send({"Error": "Event not created"})
            connection.release(); 
            process.exit();
        });
    });
});

const createEvent = (data, connection) => {
    var evdate = new Date(data.evdate).toISOString().slice(0, 19).replace('T', ' ');
    var room_id = data.room_id;
    var event_title = data.event_title;
    var details = data.details;
    var event_id = Math.floor(Math.random() * 10000);
    var query1 = `SELECT * FROM events WHERE event_id = '${event_id}' OR (date='${evdate}' AND room_id='${room_id}');`
    var query2 = `INSERT INTO events (event_id, date, host_id, room_id, event_title, details, invited_count, accepted_count, cancel) VALUES (${event_id}, '${evdate}', 1, ${room_id}, '${event_title}', '${details}', 0, 0, 0);`
    return new Promise(async (resolve, reject) => {
        connection.query(query1, (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }
            try {
                if (result.length >= 1) {
                    process.send({"Error": "The room is already booked on this day"});
                    resolve("Room already booked");
                }
                else {
                    connection.query(query2, (err, result) => {
                        if(err){
                            console.log(err);
                            reject(err.message);
                        }
                        resolve("added");
                    });
                    }
                }
                catch(error){
                    reject(err.message);
                }
            console.log(result);
            resolve(result);
        });
    });
};