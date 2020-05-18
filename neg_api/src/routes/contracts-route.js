const express = require('express');

const router = express.Router();

router.get('/', function (req, res) {
    res.json({}).end();
});

router.post('/', function (req, res) {
    res.json({}).end();
});

module.exports = router;
