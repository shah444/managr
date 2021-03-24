const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        var data = {
            email: message.email,
            name: message.name
        };
        console.log(data);
        createAccount(data, connection).then((answer) => {
            connection.release();
            if(answer == "Relationship already exists") {
                process.send({"Error": "The account already exists"});
            }
            else if(answer == "Added"){
                process.send({"Success": "Account created"})
            }
            else {
                process.send({"Error": "Account not created"})
            }
            process.exit();
        });
    });
});

const createAccount = (data, connection) => {
    var email = data.email;
    var name = data.name;
    var query = `INSERT TO users (name, email) VALUES ('${name}', '${email}' )`
    return new Promise(async (resolve, reject) => {
        await connection.query(query, (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }
            resolve(result);
        });
    });
};