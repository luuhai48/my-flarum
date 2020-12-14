'use strict';

const express = require('express');
const fileUpload = require('express-fileupload');
const convert = require('heic-convert');
const sharp = require('sharp');

// Express server
const PORT = 8080;
const HOST = '0.0.0.0';

// Image resize
const RESIZE = 100;

const app = express();
app.use(fileUpload());

app.post('/heic', async (req, res) => {
    if (!req.files || Object.keys(req.files).length === 0) {
        return res.status(400).json({ 'message': 'No files were uploaded.' });
    }

    let img = req.files.img;

    const outputBuffer = await convert({
        buffer: img.data,
        format: 'PNG'
    });

    await sharp(outputBuffer)
        .resize(RESIZE)
        .toBuffer()
        .then(output => {
            res.writeHead(200, {
                'Content-Type': 'image/png',
                'Content-Length': output.length
            });

            res.end(output);
        })
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);