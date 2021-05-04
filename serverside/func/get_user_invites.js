const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        getUserInvites(message.person_id, connection).then((result) => {
            connection.release();
            process.send(result);
            process.exit();
        });
    });
});

const getUserInvites = (person_id, connection) => {
    var query = `SELECT rsvp.event_id, rsvp.person_id, rsvp.attending, invitelist.email, invitelist.event_title, events.details, events.room_id, events.date, rooms.building, rooms.room FROM invitelist natural join rsvp join events on (rsvp.event_id=events.event_id) join rooms ON (events.room_id=rooms.room_id) WHERE person_id = ${person_id};`;
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