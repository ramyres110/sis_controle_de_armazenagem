const getDatabase = require('../utils/database-Loki-utils');
const Promise = require('bluebird');
const uid = require('uid');

var db = null;
var collection = null;
getDatabase.then(database => {
    db = database;
    collection = db.getCollection("contracts");
});

const ContractModel = () => { }


ContractModel.findAll = (query) => {
    query = null;//TODO: Implents query filter
    return Promise.resolve({
        status: 200,
        result: collection.find({})
    });
}


ContractModel.findById = (id) => {
    return Promise.resolve(
        (collection.find({ id })[0]) ?
            {
                status: 200,
                result: collection.find({ id })[0]
            } : {
                status: 404,
                result: {}
            });
}


ContractModel.findByProducer = (document) => {
    const contracts = collection.where(obj => obj.producer.document === document);
    if (contracts.length) {
        return Promise.resolve({
            status: 200,
            result: contracts
        })
    }
    return Promise.resolve({
        status: 404,
        result: {}
    });
}


ContractModel.validate = (id, body) => {
    let contract = collection.findOne({ id });
    if (!contract) return Promise.resolve({ status: 404, result: {} });
    const validation = {
        isValidated: body.isValidated,
        validatedBy: body.validatedBy,
        validatedAt: new Date(),
    }
    contract = { ...contract, ...validation };
    collection.update(contract);
    return Promise.resolve({ status: 200, result: contract });
}


ContractModel.create = (body) => {
    const id = uid();
    body.externalId = body.id;
    body.id = id;
    const result = collection.insert(body);
    db.saveDatabase((err) => {
        if (err) console.error(err);
    });
    return Promise.resolve({ status: 200, result })
}


ContractModel.update = (id, body) => {
    let contract = collection.findOne({ id });
    delete body.id;
    if (contract) {
        contract = { ...contract, ...body };
        collection.update(contract);
        return Promise.resolve({ status: 200, result: contract });
    }
    return Promise.resolve({ status: 404, result: {} });
}


ContractModel.delete = (id) => {
    collection.findAndRemove({ id });
    db.saveDatabase((err) => {
        if (err) console.error(err);
    });
    return Promise.resolve({ status: 200, result: true });
}


module.exports = ContractModel;
