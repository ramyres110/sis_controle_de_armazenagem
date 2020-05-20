const path = require('path');
const should = require('should');

const database = require('../utils/database-utils');

describe("DATABASE UTILS TEST", () => {
    const databasePath = path.join(path.normalize(__dirname + '/../..'), "data", "DATABASE.FDB");
    context("DATABASE CLASS INSTANCE", () => {
        it("Database instanciation without params should throw;", () => {
            (() => new database.Database()).should.throw();
        });

        it("Database instanciation with params should be ok;", () => {
            (new database.Database(databasePath)).should.be.ok();
        });
    });
    context("DATABASE OBJECT", () => {
        const db = new database.Database(databasePath);
        it("Database Connect should not throw;", (done) => {
            try {
                db.connect();
                if(!db.conn){
                    throw new Error('Conn not found!');
                }
                done();
            } catch (err) {
                done(err)
            }
            db.close();
        });
        
    });
});