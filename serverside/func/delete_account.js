const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        console.log(message);
        var data = {
            ID: message.id
        };
        console.log(data);
        deleteAccount(data, connection).then((answer) => {
            connection.release();
            process.send({"Success": "Account deleted"})
            process.exit();
        }).catch((error)=>{
            console.log(error); 
            process.send({"Error": "Account not deleted"})
            connection.release(); 
            process.exit();
        });
    });
});

const deleteAccount = (data, connection) => {
    var ID = data.ID;
    var query1 = `SELECT * FROM users WHERE person_id = '${ID}';`
    var query2 = `DELETE FROM users WHERE person_id = '${ID}';`
    return new Promise(async (resolve, reject) => {
        connection.query(query1, (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }
            try {
                if (result.length < 1) {
                    process.send({"Error": "The account does not exist"});
                    resolve("Account does not exist");
                }
                else {
                    connection.query(query2, (err, result) => {
                        if(err){
                            console.log(err);
                            reject(err.message);
                        }
                        resolve("deleted");
                    });
                    }
                }
                catch(error){
                    reject(err.message);
                }
            console.log(result);
            resolve(result);
        });
    });
};