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

const getEvent = (event_id, connection) => {
    var query = `call GetEvents(${event_id});`;
    var query1 = `SELECT * FROM GetEvents;`;
    return new Promise(async (resolve, reject) => {
        await connection.query(query, async (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }
            result = JSON.stringify(result);
            result = JSON.parse(result);

            if(result.length==undefined){
                await connection.query(query1, async (err1, result1) => {
                    if(err1){
                        console.log(err1);
                        reject(err1.message);
                    }
                    resolve(result1);
                });
            } 
        });
    });
};