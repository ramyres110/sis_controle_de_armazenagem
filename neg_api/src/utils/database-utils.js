const path = require('path');
const fb = require('node-firebird');

class Database {
    constructor(databasePath) {
        if (!databasePath) throw new Error('Need pass a database path.');
        this.defaultOptions = {
            host: '127.0.0.1',
            port: 3053,
            database: path.normalize(databasePath),
            user: 'SYSDBA',
            password: 'MASTERKEY',
            role: null,
            pageSize: 4096,
        }
        this.maxConn = 5;
        this.conn = null;
        this.instanceID = new Date().getTime();
    }

    connect() {
        this.conn = fb.pool(this.maxConn, this.defaultOptions);
    }

    close() {
        if (!!this.conn) {
            this.conn.destroy();
            this.conn = null;
        }
    }

    query(sql, cb) {
        if (!this.conn) {
            cb(new Error('Not Connected to Realize a Query'), null);
            return;
        }
        this.conn.get((err, db) => {
            if (err) {
                cb(err, null);
                return;
            }
            if (!db) {
                cb(new Error('Can not connect with Database'), null);
                return;
            }
            db.query(sql, (err, rows) => {
                if (err) {
                    cb(err, null);
                } else {
                    cb(null, rows);
                }
                db.detach();
            });
        });
    }

    execute(cmd, cb) {
        if (!this.conn) {
            return cb(new Error('Not Connected to Execute a Command'), null);
        }
        this.conn.get((err1, dbConn) => {
            if (err1) {
                return cb(err1, null);
            }
            dbConn.execute(cmd, (err2, resultExec) => {
                if (err2) {
                    return cb(err2, null);
                }
                dbConn.detach();
                return cb(null, { result: resultExec });
            });
        });
    }
}

module.exports = {
    Database
};