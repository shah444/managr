const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        console.log(message);
        var data = {
            ID: message.id
        };
        console.log(data);
        deleteEvent(data, connection).then((answer) => {
            connection.release();
            process.send({"Success": "Event deleted"})
            process.exit();
        }).catch((error)=>{
            console.log(error); 
            process.send({"Error": "Event not deleted"})
            connection.release(); 
            process.exit();
        });
    });
});

const deleteEvent = (data, connection) => {
    var ID = data.ID;
    var query1 = `SELECT * FROM events WHERE event_id = '${ID}'`;
    var query2 = `DELETE FROM events WHERE event_id = ${ID}`;
    var query3 = `DELETE FROM rsvp WHERE event_id = ${ID}`;
    var query4 = `DELETE FROM invitelist WHERE event_id = ${ID}`;

    return new Promise(async (resolve, reject) => {
        connection.query(query1, async (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }

            if (result.length < 1) {
                process.send({"Error": "The event does not exist"});
                resolve("Event does not exist");
            }
            else {
                await connection.query(query2, async (err1, result1) => {
                    if(err) {
                        console.log(err1);
                        reject(err1.message);
                    }

                    await connection.query(query3, async (err2, result2) => {
                        if (err2) {
                            console.log(err2.message);
                            reject(err2.message);
                        }
                        await connection.query(query4, (err3, result3) => {
                            if (err3) {
                                console.log(err3.message);
                                reject(err3.message);
                            }                      
                            resolve(result3);
                        });
                    });
                    
                });
            }
        });
    });
};