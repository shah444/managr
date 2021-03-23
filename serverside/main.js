const express = require('express');
const cluster = require('cluster');
const numCPUs = require('os').cpus().length;
const db = require("./func/db_connection.js");
const {send, kill} = require('process');
const app = express();
const PORT = process.env.PORT || 23556;

if (cluster.isMaster) {
    console.log(`Master ${process.pid} is running`);

    //Forking workers
    for (var i = 0; i < numCPUs; i++) {
        cluster.fork();
    }

    cluster.on('exit', (worker, code, signal) => {
        console.log(`worker ${worker.process_id} died`);
    });
} else {
    const server = app.listen(PORT, () => {"listening on port " + PORT + ", PID: " + process.pid});
    var killProcess = false;

    const fork = require('child_process').fork;

    // User endpoints
    app.route("/event")
    .get((req, res) => {
        const handleGetEvent = fork("./func/get_event.js");
        var data = {
            event_id: req.query.event_id
        };
        handleGetEvent.send(data);
        handleGetEvent.on("message", message => res.send(message));
    });
}