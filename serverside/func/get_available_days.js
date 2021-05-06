const moment = require("moment");
const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        getAvailability(connection).then((result) => {
            connection.release();
            process.send(result);
            process.exit();
        });
    });
});

const getAvailability = (connection) => {
    days = [];
    dates = [];

    for (var i = 0; i < 10; i++) {
        days.push(moment().add(i, 'days').format('D MMMM YYYY'));
    }

    for (var i = 0; i < 10; i++) {
       dates.push(new Date(days[i]).toISOString().slice(0, 19).replace('T', ' '));
    }   

    // console.log(days);
    console.log(dates);
    // var date = new Date().toDateString();
    // console.log(date.split(' ').slice(1).join(' '));
    var dateString = "";
    for (var i = 0; i < dates.length; i++) {
        if (i == 0) {
            dateString = dateString + "'" + dates[i] + "'";
        }
        dateString = dateString + ", '" + dates[i] + "'";
    }
    var queryT = `SET TRANSACTION ISOLATION LEVEL REPEATABLE READ`;
    var queryS = `START TRANSACTION`;
    var queryC = `COMMIT`;
    var query1 = `SELECT date, COUNT(room_id) FROM events WHERE date in (${dateString}) GROUP BY date`;

    var query3 = "SELECT COUNT(*) AS totalRooms FROM rooms"
    var indicesToRemove = [];

    return new Promise(async (resolve, reject) => {
        await connection.query(queryT, async (errT, resultT) => {
            if (errT) {
                console.log(errT.message);
                reject(errT.message);
            }
            await connection.query(queryS, async (errS, resultS) => {
                if (errS) {
                    console.log(errS.message);
                    reject(errS.message);
                }
        await connection.query(query1, async (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }
            result = JSON.stringify(result);
            result = JSON.parse(result);
            if (result.length == 0) {
                result = {
                    'days': days
                };
                console.log(result);
                resolve(result);
            } else {
                await connection.query(query3, async (err1, result1) => {
                    if (err1) {
                        console.log(err1.message);
                        reject(err1.message);
                    }
                    result1 = JSON.stringify(result1);
                    result1 = JSON.parse(result1);
                    
                    var numRooms = result1[0].totalRooms;

                    for (var i = 0; i < result.length; i++) {
                        if (result[i].roomCount == numRooms) {
                            indicesToRemove.push(i);
                        }
                    }

                    for (var i = 0; i < indicesToRemove.length; i++) {
                        days.splice(indicesToRemove[i], 1);
                    }

                    result = {
                        "days": days
                    }
                    await connection.query(queryS, async (errS, resultS) => {
                        if (errS) {
                            console.log(errS.message);
                            reject(errS.message);
                        }
                    resolve(result);
                });
                });
            }
        });
    }); 
});
    });
};