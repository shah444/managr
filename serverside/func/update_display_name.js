const { json } = require("body-parser");
const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        updateDisplayName(message.displayName, message.user_id, connection).then((answer) => {
            connection.release();
            process.send({"Success": "Display name Changed"})
            process.exit();
        }).catch((error)=>{
            console.log(error); 
            process.send({"Error": "Display name not Changed"})
            connection.release(); 
            process.exit();
        });
    });
});

const updateDisplayName = (displayName, user_id, connection) => {
    var query1 = `UPDATE users SET name = '${displayName}' WHERE person_id = ${user_id}`;
    console.log(query1);
    return new Promise(async (resolve, reject) => {
        connection.query(query1, (err, result) => {
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