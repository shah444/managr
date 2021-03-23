const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        getEvent(message.event_id, connection).then((result) => {
            connection.release();
            process.send(result);
            process.exit();
        });
    });
});

const createAccount = (email_id, name, connection) => {
    var query = `INSERT TO users (name, email) VALUES ('${name}', '${email}' )`
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