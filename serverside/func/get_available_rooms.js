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
    var queryT = `SET TRANSACTION ISOLATION LEVEL REPEATABLE READ`;
    var queryS = `START TRANSACTION`;
    var queryC = `COMMIT`;
    var query = `SELECT room_id FROM events WHERE date LIKE '${dateString}%'`;
    
    return new Promise(async (resolve, reject) => {
        await connection.query(queryT, async (errT, result) => {
            if (errT) {
                console.log(errT.message);
                reject(errT.message);
            }
            await connection.query(queryS, async (errS, result) => {
                if (errS) {
                    console.log(errS.message);
                    reject(errS.message);
                }
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
        
            await connection.query(query1, async (err1, result1) => {
                if (err1) {
                    console.log(err1.message);
                    reject(err1.message);
                }
                await connection.query(queryC, async (errC, resultC) => {
                    if (errC) {
                        console.log(errC.message);
                        reject(errC.message);
                    }
                result1 = JSON.stringify(result1);
                result1 = JSON.parse(result1);
                resolve(result1);
            });
            });
        });
    });
});
    });
};