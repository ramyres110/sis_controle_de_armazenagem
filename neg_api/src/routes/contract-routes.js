const express = require('express');
const ContractModel = require('../models/contract-model');

const router = express.Router();

ContractModel.sync();

router.get('/', function (req, res) {
    return ContractModel
        .findAll()
        .then(result => {
            return res
                .status(200)
                .json(result)
                .end();
        })
        .catch(err => {
            return res
                .status(500)
                .json(err)
                .end();
        })
});

router.get('/:id', function (req, res) {
    res.json({}).end();
});

router.post('/', function (req, res) {
    res.json({}).end();
});

router.put('/:id', function (req, res) {
    res.json({}).end();
});

router.delete('/:id', function (req, res) {
    res.json({}).end();
});

module.exports = router;
