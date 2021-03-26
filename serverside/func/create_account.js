const db = require("./db_connection.js");

process.on("message", message => {
    db.conn.getConnection(async function (err, connection) {
        if (err) {
            return console.log('err: ' + err.message);
        }
        
        console.log('Database connection established.');
        console.log(message);
        var data = {
            email: message.email,
            name: message.name
        };
        console.log(data);
        createAccount(data, connection).then((answer) => {
            connection.release();
            process.send({"Success": "Account created"})
            process.exit();
        }).catch((error)=>{
            console.log(error); 
            process.send({"Error": "Account not created"})
            connection.release(); 
            process.exit();
        });
    });
});

const createAccount = (data, connection) => {
    var email = data.email;
    var name = data.name;
    var person_id = Math.floor(Math.random() * 10000);
    var query1 = `SELECT * FROM users WHERE email = '${email}' OR person_id = '${person_id}';`
    var query2 = `INSERT INTO users (person_id, name, email) VALUES ('${person_id}','${name}', '${email}' );`
    return new Promise(async (resolve, reject) => {
        connection.query(query1, (err, result) => {
            if (err) {
                console.log(err.message);
                reject(err.message);
            }
            try {
                if (result.length >= 1) {
                    process.send({"Error": "The account already exists"});
                    resolve("Account already exists");
                }
                else {
                    connection.query(query2, (err, result) => {
                        if(err){
                            console.log(err);
                            reject(err.message);
                        }
                        resolve("added");
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