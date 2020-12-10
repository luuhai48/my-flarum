'use strict';

const express = require('express');
const fileUpload = require('express-fileupload');
const convert = require('heic-convert');
const sharp = require('sharp');

// Express server
const PORT = 8080;
const HOST = '0.0.0.0';

// Image convert quality + resize
const QUATLITY = 1;
const RESIZE = 300;

const app = express();
app.use(fileUpload());

app.post('/heic', async (req, res) => {
    if (!req.files || Object.keys(req.files).length === 0) {
        return res.status(400).send('No files were uploaded.');
    }

    let img = req.files.img;

    const outputBuffer = await convert({
        buffer: img.data,
        format: 'JPEG',
        quality: QUATLITY
    });

    await sharp(outputBuffer)
        .resize(RESIZE)
        .toBuffer()
        .then(output => {
            const base64Image = output.toString('base64');
            res.json({ "data": `data:image/jpeg;base64,${base64Image}` });
        })
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);