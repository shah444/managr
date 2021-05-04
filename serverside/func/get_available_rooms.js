const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        getRooms(message.date, connection).then((result) => {
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

const getRooms = (date, connection) => {
    var chosenDate = new Date(date).toISOString().slice(0, 19).replace('T', ' ');
    // var dateString = "'" + chosenDate.toString().slice(0, 10) + "'";
    var dateString = chosenDate.toString().slice(0, 10);
    var roomIDString = '';

    console.log(dateString);

    var query = `SELECT room_id FROM events WHERE date LIKE '${dateString}%'`;
    
    return new Promise(async (resolve, reject) => {
        await connection.query(query, async (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }
            result = JSON.stringify(result);
            result = JSON.parse(result);

            for (var i = 0; i < result.length; i++) {
                if (i == 0) {
                    roomIDString = roomIDString + result[i].room_id.toString();
                } else {
                    roomIDString = roomIDString + ", " + result[i].room_id.toString();
                }
            }
            
            var query1 = '';
            if (result.length == 0) {
                query1 = 'SELECT * FROM rooms';
            } else {
                query1 = `SELECT * FROM rooms WHERE room_id NOT IN (${roomIDString})`;
            }
        
            await connection.query(query1, (err1, result1) => {
                if (err1) {
                    console.log(err1.message);
                    reject(err1.message);
                }
                result1 = JSON.stringify(result1);
                result1 = JSON.parse(result1);
                resolve(result1);
            });
        });
    });
};