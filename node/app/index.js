'use strict';

const express = require('express');
const fileUpload = require('express-fileupload');

const PORT = 8080;
const HOST = '0.0.0.0';

const app = express();
app.use(fileUpload());

app.post('/heic', (req, res) => {
    if (!req.files || Object.keys(req.files).length === 0) {
        return res.status(400).send('No files were uploaded.');
    }

    let img = req.files.img;
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
