/**
 * This file contains all database configurations and needs to be imported into every file that intends
 * to communicate with the database. This file is not imported in main.js
 * For testing the server locally, hardcode the password to the password variable. For example, see the PORT variable in main.js
 */

const mysql = require('mysql');
const password = process.env.DB_PASS || "c$348project";

var conn = mysql.createPool(
    {
        host: "server-cs348.mysql.database.azure.com",
        user: "anvimehta@server-cs348",
        password: password,
        database: 'managr',
        port: 3306,
        connectionLimit: 20
    }
);

module.exports.conn = conn;

