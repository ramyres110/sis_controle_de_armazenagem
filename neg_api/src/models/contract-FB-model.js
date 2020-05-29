const Promise = require('bluebird');
const database = require('../utils/database-FB-utils');

const tableName = 'TB_CONTRACTS';
const tableAttrPk = 'ID';
const tableAttributes = [
    'ID INTEGER  NOT NULL PRIMARY KEY',
    'PRODUCER_ID INTEGER  NOT NULL',
    'PRODUCER_NAME VARCHAR(255)  NOT NULL',
    'PRODUCER_DOC VARCHAR(15)  NOT NULL',
    'GRAIN_ID INTEGER  NOT NULL',
    'GRAIN_NAME VARCHAR(255)  NOT NULL',
    'GRAIN_PRICE DECIMAL(12, 2)  NOT NULL',
    'FIRST_WEIGHT FLOAT DEFAULT 0 NOT NULL',
    'LAST_WEIGHT FLOAT DEFAULT 0 NOT NULL',
    'HUMIDITY FLOAT DEFAULT 0 NOT NULL',
    'CONTRACT_PRICE DECIMAL(12, 2) DEFAULT 0 NOT NULL',
    'IS_VALIDATED SMALLINT DEFAULT 0 NOT NULL',
    'DTHR_VALIDATED TIMESTAMP',
    'DTHR_CREATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0) NOT NULL',
    'DTHR_CHANGE TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0) NOT NULL'
];

class ContractModel {
    constructor(obj = {}) {
        this.tableName = tableName;
        this.tableAttrPk = tableAttrPk;
        this.tableAttributes = tableAttributes;

        this.id = obj.id || null;
        this.producer = obj.producer || {};
        this.grain = obj.grain || {};
        this.firstWeight = obj.firstWeight || null;
        this.lastWeight = obj.lastWeight || null;
        this.humidity = obj.humidity || null;
        this.contractPrice = obj.contractPrice || null;
        this.isValidated = obj.isValidated || false;
        this.validatedAt = obj.validatedAt || null;
        this.createdAt = obj.createdAt || null;
        this.changedAt = obj.changedAt || null;
    }

    loadFromDB(row) {
        this.id = row["ID"];
        this.producer.id = row["PRODUCER_ID"];
        this.producer.name = row["PRODUCER_NAME"];
        this.producer.document = row["PRODUCER_DOC"];
        this.grain.id = row["GRAIN_ID"];
        this.grain.description = row["GRAIN_NAME"];
        this.grain.priceKg = row["GRAIN_PRICE"];
        this.firstWeight = row["FIRST_WEIGHT"];
        this.lastWeight = row["LAST_WEIGHT"];
        this.humidity = row["HUMIDITY"];
        this.contractPrice = row["CONTRACT_PRICE"];
        this.isValidated = row["IS_VALIDATED"];
        this.validatedAt = row["DTHR_VALIDATED"];
        this.createdAt = row["DTHR_CREATE"];
        this.changedAt = row["DTHR_CHANGE"];
    }

    toSQL() {
        return {
            "ID": this.id,
            "PRODUCER_ID": this.producer.id,
            "PRODUCER_NAME": this.producer.name,
            "PRODUCER_DOC": this.producer.document,
            "GRAIN_ID": this.grain.id,
            "GRAIN_NAME": this.grain.description,
            "GRAIN_PRICE": this.grain.priceKg,
            "FIRST_WEIGHT": this.firstWeight,
            "LAST_WEIGHT": this.lastWeight,
            "HUMIDITY": this.humidity,
            "CONTRACT_PRICE": this.contractPrice,
            "IS_VALIDATED": this.isValidated,
            "DTHR_VALIDATED": this.validatedAt,
            "DTHR_CREATE": this.createdAt,
            "DTHR_CHANGE": this.changedAt,
        }
    }

    save() {
        if (!this.id) {
            return this.create();
        }
        return this.update();
    }

    create() {
        const dtSql = this.toSQL();
        const cols = Object.keys(dtSql);
        const prepares = new Array(cols.length).fill('?');
        const params = cols.map(attr => dtSql[attr]);
        const sql = `INSERT INTO ${this.tableName}(${cols.join(",")}) VALUES(${prepares.join(",")});`;
        return database
            .execute(sql, params)
            .then(result => {
                console.log(result);
            })
            .catch(err => {
                console.error(err);
            })
    }

    update() {

    }

    delete() {

    }
}

ContractModel.sync = (force = false) => {
    return database
        .tableExist(tableName)
        .then(exists => {
            if (!!exists && !force) {
                throw new Error("PASS");
            }
            if (!!exists && !!force) {
                return database.dropTable(tableName);
            }
            return;
        })
        .then(() => {
            return database.createTable(tableName, tableAttributes);
        })
        .then(() => {
            return database.tableExist(tableName);
        })
        .then((resp) => {
            if (!resp) throw new Error('Table not created');
            return true;
        })
        .catch(err => {
            if (!!err.message === "PASS") return;
        });
}

ContractModel.findAll = (query) => {
    let formatedQuery = "";
    let limit = "10000";
    let offset = "0";
    // if (!!query) {
    //     //TODO:
    // }
    const sql = `SELECT FIRST ${limit} SKIP ${offset} * FROM ${tableName} ${formatedQuery};`;
    return database
        .query(sql)
        .then(result => {
            if (!result) return [];
            const data = [];
            result.forEach(row => {
                const contract = new ContractModel();
                contract.loadFromDB(row);
                data.push(contract);
            });
            return data;
        });
}

ContractModel.findById = (id) => {
    if (!id) return Promise.reject(new Error("ID not found to proceed"));
    const sql = `SELECT * FROM ${tableName} WHERE ${tableAttrPk} = '${id}';`;
    return database
        .query(sql)
        .then(result => {
            if (!result || !result.length) return null;
            const contract = new ContractModel();
            contract.loadFromDB(result[0]);
            return contract;
        });
}

ContractModel.create = (obj) => {
    throw new Error('Dont implemented');
 };

ContractModel.update = (id, obj) => { 
    throw new Error('Dont implemented');
};

ContractModel.delete = (id) => { 
    throw new Error('Dont implemented');
};

module.exports = ContractModel;