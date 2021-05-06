const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        getHostEvent(message.host_id, message.date, message.room, connection).then((result) => {
            connection.release();
            process.send(result);
            process.exit();
        });
    });
});

const getHostEvent = (host_id, date, room, connection) => {
    var query =  `SELECT event_id FROM events \
                    WHERE host_id = '${host_id}' and date = '${date}' and room_id = '${room}' \
                    LIMIT 1;`;
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