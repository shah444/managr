const express = require('express');
const app = express();
const PORT = process.env.PORT || 23556;

app.get('/', (req, res) => {
    res.send("Welcome to managr");
});

app.listen(PORT, () => {"listening on port " + PORT});