const express = require('express');
const cluster = require('cluster');
const numCPUs = require('os').cpus().length;
const db = require("./func/db_connection.js");
const {send, kill} = require('process');
const app = express();
const PORT = process.env.PORT || 23556;
const bodyparser = require('body-parser');
var jsonparser = bodyparser.json();
//git subtree push --prefix serverside heroku master

if (cluster.isMaster) {
    console.log(`Master ${process.pid} is running`);

    //Forking workers
    console.log(numCPUs);
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
    app.route("/event/:id?")
    .get((req, res) => {
        const handleGetEvent = fork("./func/get_event.js");
        var data = {
            event_id: req.query.event_id
        };
        handleGetEvent.send(data);
        handleGetEvent.on("message", message => res.send(message));
    })
    .put(jsonparser, (req, res) => {
        const handleEditEvent = fork("./func/edit_event.js");
        console.log(req.body);
        handleEditEvent.send(req.body);
        handleEditEvent.on("message", message => res.send(message));
    })
    .post(jsonparser, (req, res) => {
        const handleCreateEvent = fork("./func/create_event.js");
        console.log(req.body);
        handleCreateEvent.send(req.body);
        handleCreateEvent.on("message", message => res.send(message));
    })
    .delete(jsonparser, (req, res) => {
        const handleDeleteAccount = fork("./func/delete_event.js");
        console.log("delete event" + req.params.id);
        handleDeleteAccount.send(req.params);
        handleDeleteAccount.on("message", message => res.send(message));
    });

    app.route("/account/:id?")
    .get((req, res) => {
        const handleGetAccount = fork('./func/get_account.js');
        var data = {
            email: req.query.email
        }
        handleGetAccount.send(data);
        handleGetAccount.on('message', message => res.send(message));
    })
    .post(jsonparser, (req, res) => {
        const handleCreateAccount = fork("./func/create_account.js");
        console.log(req.body);
        handleCreateAccount.send(req.body);
        handleCreateAccount.on("message", message => res.send(message));
    })
    .delete(jsonparser, (req, res) => {
        const handleDeleteAccount = fork("./func/delete_account.js");
        console.log(req.params.id);
        handleDeleteAccount.send(req.params);
        handleDeleteAccount.on("message", message => res.send(message));
    });

    app.route("/invitation")
    .get((req, res) => {
        const handleGetEvent = fork("./func/get_user_invites.js");
        var data = {
            person_id: req.query.person_id 
        };
        handleGetEvent.send(data);
        handleGetEvent.on("message", message => res.send(message));
    })
    .post(jsonparser, (req, res) => {
        const handleCreateAccount = fork("./func/invite_user.js");
        console.log(req.body);
        handleCreateAccount.send(req.body);
        handleCreateAccount.on("message", message => res.send(message));
    });

    app.route("/invitedTo")
    .get((req, res) => {
        const handleGetInvitedTo = fork("./func/get_people_invited.js");
        var data = {
            event_id: req.query.event_id
        };
        handleGetInvitedTo.send(data);
        handleGetInvitedTo.on("message", message => res.send(message));
    })

    app.route("/rsvp")
    .get((req, res) => {
        const handleGetEvent = fork("./func/get_upcoming_event.js");
        var data = {
            person_id: req.query.person_id 
        };
        handleGetEvent.send(data);
        handleGetEvent.on("message", message => res.send(message));
    })
    .put(jsonparser, (req, res) => {
        const handleCreateAccount = fork("./func/update_rsvp.js");
        console.log(req.body);
        handleCreateAccount.send(req.body);
        handleCreateAccount.on("message", message => res.send(message));
    });

    app.route("/daysAvailability")
    .get((req, res) => {
        const handleGetAvailability = fork("./func/get_available_days.js");
        handleGetAvailability.send({});
        handleGetAvailability.on("message", message => res.send(message));
    });

    app.route("/roomsAvailability")
    .get((req, res) => {
        const handleGetRoomsAvailability = fork("./func/get_available_rooms.js");
        handleGetRoomsAvailability.send({
            date: req.query.date
        });
        handleGetRoomsAvailability.on("message", message => res.send(message));
    });

    app.route("/updateDisplayName")
    .put(jsonparser, (req, res) => {
        const handleUpdateDisplayName = fork("./func/update_display_name.js");
        console.log(req.body);
        handleUpdateDisplayName.send(req.body);
        handleUpdateDisplayName.on("message", message => res.send(message));
    });
}