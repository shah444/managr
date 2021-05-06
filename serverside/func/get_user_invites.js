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
    var queryn1 = `SET TRANSACTION ISOLATION LEVEL READ COMMITTED`;
    var query0 = `START TRANSACTION`;
    var query = `call GetUserInvites(${person_id});`;
    var query1 = `SELECT * FROM GetUserInvites;`;
    var query2 = `COMMIT`;
    return new Promise(async (resolve, reject) => {
        await connection.query(queryn1, async (errn1, resultn1) => {
            if (errn1) {
                console.log(errn1.message);
                reject(errn1.message);
            }
        await connection.query(query0, async (err0, result0) => {
            if (err0) {
                console.log(err0.message);
                reject(err0.message);
            }
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
                    await connection.query(query2, async (err2, result2) => {
                        if (err) {
                            console.log(err2.message);
                            reject(err2.message);
                        }   
                    resolve(result1);
                });
                });
            } 
        });
    });
        });
    });
};