const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        console.log(message);
        var data = {
            event_id: message.event_id,
            email: message.email
        };
        console.log(data);
        inviteUser(data, connection).then((answer) => {
            connection.release();
            process.send({"Success": "User invited"});
            process.exit();
        }).catch((error)=>{
            console.log(error); 
            process.send({"Error": "Query not sent"});
            connection.release(); 
            process.exit();
        });
    });
});

const inviteUser = (data, connection) => {
    var email = data.email;
    var event_id = data.event_id;
    var query1 = `SELECT * FROM invitelist WHERE email = '${email}' AND event_id = '${event_id}';`;
    return new Promise(async (resolve, reject) => {
        connection.query(query1, async (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }
            result = JSON.stringify(result);
            result = JSON.parse(result);
            console.log(result);

            if (result.length >= 1) {
                process.send({"Error": "The user has already been invited to this event"});
                reject("User already Invited");
            } else {

                    var query2 = `SELECT * FROM users where email = '${email}'`;
                await connection.query(query2, async (err1, result1) => {
                    if(err1){
                        console.log(err1);
                        reject(err1.message);
                    }
                    //result1 = JSON.stringify(result1);
                    //result1 = JSON.parse(result1);
                    console.log(result1[0].person_id)
                    var person_id = String(result1[0].person_id);
                    var query3 = `select * from events where event_id = '${event_id}'`;
                    await connection.query(query3, async(err2, result2) => {
                        if (err2) {
                            console.log(err2.message);
                            reject(err2.message);
                        }
                        //result2 = JSON.stringify(result2);
                       // result2 = JSON.parse(result2);
                        var event_title = String(result2[0].event_title);
                        console.log(event_title);
                        var query4 = `INSERT INTO invitelist (event_id, event_title, person_id, email) VALUES (${event_id},${event_title},${person_id},${email})`;
                        await connection.query(query4, async(err3, result3) => {
                            if(err3){
                                console.log(err3);
                                reject(err3.message);
                            }
                            var query5 = `INSERT INTO rsvp (event_id, person_id, attending) VALUES ('${event_id}','${person_id}', 0);`;
                            await connection.query(query5, (err4, result4) => {
                                if(err4){
                                    console.log(err4);
                                    reject(err4.message);
                                }
                                resolve(result4);
                            });
                        });
                    });
                });
            }
        });
    });
};
//var query2 = `INSERT INTO invitelist (event_id, event_title, person_id, email) VALUES ('${event_id}', '${event_title}', '${person_id}', '${email}');`;
//var query3 = `INSERT INTO rsvp (event_id, person_id, attending) VALUES ('${event_id}', '${person_id}', 0);`;
