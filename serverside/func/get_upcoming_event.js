const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        getUpcomingEvent(message.person_id, connection).then((result) => {
            connection.release();
            process.send(result);
            process.exit();
        });
    });
});

const getUpcomingEvent = (person_id, connection) => {
    var query =  `SELECT * FROM events left join rsvp \
                    ON events.event_id = rsvp.event_id \
                    WHERE (host_id = ${person_id} or person_id = ${person_id} )\
                    and date = (SELECT min(date) FROM events left join rsvp \
                    ON events.event_id = rsvp.event_id WHERE host_id = ${person_id} or person_id = ${person_id})\
                    LIMIT 1`;
   // var query =  `Select * From events Select min(date) as mn FROM (SELECT * FROM invitelist natural join events WHERE person_id = ${person_id}) where date = mn`;
    //var query = `SELECT * FROM invitelist natural join events WHERE person_id = ${person_id} and date = '2008-11-09 15:45:21'`;// (SELECT min(date) FROM events))`;
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