const path = require('path');
const fs = require('fs');
const Promise = require('bluebird');
const Firebird = require('node-firebird');

require('dotenv').config();

const ddls = ['CREATE', 'DROP', 'ALTER'];
const dmls = ['INSERT', 'UPDATE', 'DELETE'];
const dql = ['SELECT'];
const dataTypes = ['SMALLINT', 'INTEGER', 'BIGINT', 'DECIMAL', 'NUMERIC', 'FLOAT', 'DOUBLE', 'DATE', 'TIME', 'TIMESTAMP', 'CHAR', 'CHARACTER', 'VARCHAR', 'CHARACTER', 'VARYING', 'BLOB'];

/**
 * Get Option
 * @return {object} - Connection Options
 */
const getOptions = () => {
    const databasePath = path.join(path.normalize(__dirname + '/../..'), 'data', 'DATABASE.FDB');
    const options = {
        host: process.env.FB_HOST || '127.0.0.1',
        port: process.env.FB_PORT || 3050,
        database: process.env.FB_DATABASE || databasePath,
        user: process.env.FB_USER || 'SYSDBA',
        password: process.env.FB_PASS || 'masterkey',
        lowercase_keys: false,
        pageSize: 4096
    }
    return options;
}

/**
 * Validate SQL
 * @param {string} sql 
 * @return {string || null}
 */
const validateSQL = (sql) => {
    if (!sql) return null;
    if (!isNaN(sql)) return null;
    if (sql.charAt(sql.length - 1) !== ";") return null;
    const init = sql.split(' ')[0].toUpperCase();
    if ([...ddls, ...dmls, ...dql].indexOf(init) < 0) return null;
    return sql;
}

/**
 * Create Database
 * @param {object} options - Extra Options
 */
const createDatabase = (options = {}, force = false) => {
    const opt = { ...getOptions(), ...options };
    if (!!fs.existsSync(opt.database) && !force) {
        console.info('Database already exits');
        return Promise.resolve(true);
    }
    console.info('Creating Database');
    return new Promise((res, rej) => {
        Firebird.create(opt, (err, db) => {
            if (err) {
                console.error(err);
                return rej(err);
            }
            console.info('Database Created');
            db.detach();
            return res(true);
        });
    });
}

/**
 * Table Exist
 * @param {string} tablename 
 * @return {Promise<boolean>}
 */
const tableExist = (tablename) => {
    if (!tablename) return Promise.reject(new Error('To check table exists informe a table name'));
    const sql = `SELECT COUNT(*) FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = '${tablename}';`;
    return query(sql)
        .then(result => {
            return result[0].COUNT === 1;
        });
}

/**
 * Create Table
 * @param {string} tablename 
 * @param {Array<string>} attributesStringList - Ex: ['ID INTEGER NOT NULL','NAME VARCHAR(100)',...]
 */
const createTable = (tablename, attributesStringList) => {
    if (!tablename) return Promise.reject(new Error("To create table informe a table name"));
    if (!attributesStringList || (attributesStringList.length === 0)) return Promise.reject(new Error("To create table informe the attributes string list"));
    const attrs = [];
    attributesStringList.forEach(attribute => {
        if (typeof attribute !== "string") throw new Error("Attributes in attribute string list must be string");
        const arr = attribute.split(" ");
        if (arr.length < 2) throw new Error("Attribute string must be SQL Declarative (name data_type)");
        if (!isNaN(arr[0].charAt(0))) throw new Error("Attribute string can not begin with number");
        if (dataTypes.some(type => arr[1].indexOf(type) >= 0)) {
            attrs.push(attribute);
        }
    });
    if (attrs.length !== attributesStringList.length) throw new Error("Attribute string error");
    const sql = `CREATE TABLE ${tablename} (${attrs.join(',')});`;
    return execute(sql);
}

/**
 * Drop Table
 * @param {string} tablename 
 */
const dropTable = (tablename) => {
    if (!tablename) return Promise.reject(new Error('To drop table informe a table name'));
    const sql = `DROP TABLE ${tablename};`;
    return execute(sql);
}

/**
 * Perform Query
 * @param {string} sql 
 * @param {Array<string>} params 
 */
const query = (sql, params) => {
    if (!sql) return Promise.reject(new Error("To perform a query need a sql script"));
    if (!validateSQL(sql)) {
        return Promise.reject(new Error("Invalid SQL"));
    }
    if (dql.indexOf(sql.split(" ")[0].toUpperCase()) < 0) {
        return Promise.reject(new Error("Query is used for DQLs only"));
    }
    if (!!params) {
        params = params.map(e => (typeof e === 'string') ? Firebird.escape(e) : e);
    }
    return new Promise((res, rej) => {
        Firebird.attach(getOptions(), (err1, db) => {
            if (err1) {
                return rej(err1);
            }
            db.query(sql, params, (err2, result) => {
                db.detach();
                if (err2) {
                    return rej(err2);
                }
                return res(result);
            });
        });
    });
}

/**
 * Execute
 * @param {string} sql 
 * @param {Array<string>} params 
 */
const execute = (sql, params) => {
    if (!sql) return Promise.reject(new Error("To perform a query need a sql script"));
    if (!validateSQL(sql)) {
        return Promise.reject(new Error("Invalid SQL"));
    }
    if ([...ddls, ...dmls].indexOf(sql.split(" ")[0].toUpperCase()) < 0) {
        return Promise.reject(new Error("Execute is used for DDLs and DMLs only"));
    }
    if (!!params) {
        params = params.map(e => (typeof e === 'string') ? Firebird.escape(e) : e);
    }
    return new Promise((res, rej) => {
        Firebird.attach(getOptions(), (err1, db) => {
            if (err1) {
                return rej(err1);
            }
            db.execute(sql, params, (err2, result) => {
                db.detach();
                if (err2) {
                    return rej(err2);
                }
                return res(result);
            });
        });
    });
}

module.exports = {
    getOptions,
    validateSQL,
    createDatabase,
    tableExist,
    createTable,
    dropTable,
    query,
    execute,
};