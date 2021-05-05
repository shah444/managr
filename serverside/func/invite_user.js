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
            event_title: message.event_title,
            person_id: message.person_id,
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
    var person_id = data.person_id;
    var event_title = data.event_title;
    var email = data.email;
    var event_id = data.event_id;
    var query1 = `SELECT * FROM invitelist WHERE person_id = '${person_id}' AND event_id = '${event_id}';`;
    var query2 = `INSERT INTO invitelist (event_id, event_title, person_id, email) VALUES ('${event_id}', '${event_title}', '${person_id}', '${email}');`;
    var query3 = `INSERT INTO rsvp (event_id, person_id, attending) VALUES ('${event_id}', '${person_id}', 0);`;
    return new Promise(async (resolve, reject) => {
        connection.query(query1, async (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }
            result = JSON.stringify(result);
            result = JSON.parse(result);

            if (result.length >= 1) {
                process.send({"Error": "The user has already been invited to this event"});
                reject("User already Invited");
            } else {
                await connection.query(query2, async (err1, result1) => {
                    if(err1){
                        console.log(err1);
                        reject(err1.message);
                    }
                    await connection.query(query3, (err2, result2) => {
                        if (err2) {
                            console.log(err2.message);
                            reject(err2.message);
                        }
                    resolve(result2);
                    });
                });
            }
        });
    });
};