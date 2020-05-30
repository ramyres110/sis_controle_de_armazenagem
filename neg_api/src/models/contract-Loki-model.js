const getDatabase = require('../utils/database-Loki-utils');
const Promise = require('bluebird');
const uidGenerator = require('uid/dist/index');

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
    const result = collection.findOne({ uid: id });
    if (!result) {
        return Promise.resolve({ status: 404, result: {} });
    }
    delete result.$loki;
    delete result.meta;
    return Promise.resolve({ status: 200, result: { ...result, id: result.externalId, externalId: result.uid } });
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
    let contract = collection.findOne({ uid: id });
    if (!contract) return Promise.resolve({ status: 404, result: {} });
    const validation = {
        isValidated: body.isValidated,
        validatedBy: body.validatedBy
    }
    contract = { ...contract, ...validation };
    collection.update(contract);
    return Promise.resolve({ status: 200, result: contract });
}


ContractModel.create = (body) => {
    const data = {
        ...body,
        uid: uidGenerator(),
        externalId: body.id
    };
    delete data.id;
    const result = collection.insert(data);
    const resp = { ...body, externalId: data.uid };
    return Promise.resolve({
        status: 200,
        result: resp
    });
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
