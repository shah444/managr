const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        getEvent(message.email, connection).then((result) => {
            connection.release();
            process.send(result);
            process.exit();
        }).catch((error) => {
            connection.release();
            process.send(error);
            process.exit();
        });
    });
});

const getEvent = (email, connection) => {
    var query = `SELECT * FROM users WHERE email = ${email}`;
    return new Promise(async (resolve, reject) => {
        await connection.query(query, (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }
            console.log('result is ' + result);
            result = JSON.stringify(result);
            result = JSON.parse(result);
            resolve(result);
        });
    });
};