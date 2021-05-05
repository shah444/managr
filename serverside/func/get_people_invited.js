const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        getInvitedTo(message.event_id, connection).then((result) => {
            connection.release();
            process.send(result);
            process.exit();
        });
    });
});

const getInvitedTo = (event_id, connection) => {
    var query = `SELECT * FROM invitelist natural join rsvp WHERE event_id = ${event_id}`;
    return new Promise(async (resolve, reject) => {
        await connection.query(query, (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }
            result = JSON.stringify(result);
            result = JSON.parse(result);
            resolve(result);
        });
    });
};