const express = require('express');
const ContractModel = require('../models/contract-Loki-model');

const router = express.Router();

const handleResult = (req, res, {status, result}) => {
    if (!result & !status) {
        throw new Error('Result Not Found');
    }
    return res
        .status(status)
        .json(result)
        .end();
}

const handleError = (req, res, err) => {
    return res
        .status(500)
        .json(err)
        .end();
}

router.get('/produtor/:document', function (req, res) {
    return ContractModel
        .findByProducer(req.params.document)
        .then(result => handleResult(req, res, result))
        .catch(err => handleError(req, res, err));
});

router.get('/:id', function (req, res) {
    return ContractModel
        .findById(req.params.id)
        .then(result => handleResult(req, res, result))
        .catch(err => handleError(req, res, err));
});

router.get('/', function (req, res) {
    return ContractModel
        .findAll(req.query)
        .then(result => handleResult(req, res, result))
        .catch(err => handleError(req, res, err));
});

router.post('/:id/valida', function (req, res) {
    return ContractModel
        .validate(req.params.id, req.body)
        .then(result => handleResult(req, res, result))
        .catch(err => handleError(req, res, err));
});

router.post('/', function (req, res) {
    return ContractModel
        .create(req.body)
        .then(result => handleResult(req, res, result))
        .catch(err => handleError(req, res, err));
});

router.put('/:id', function (req, res) {
    return ContractModel
        .update(req.params.id, req.body)
        .then(result => handleResult(req, res, result))
        .catch(err => handleError(req, res, err));
});

router.delete('/:id', function (req, res) {
    return ContractModel
        .delete(req.params.id)
        .then(result => handleResult(req, res, result))
        .catch(err => handleError(req, res, err));
});

module.exports = router;
