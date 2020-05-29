const path = require('path');
const should = require('should');

const database = require('../utils/database-FB-utils');

describe("DATABASE UTILS TEST", () => {

    context("Database Utils", () => {
        it("getOptions returns should be an object", () => {
            database.getOptions().should.be.an.Object()
        });

        it("validateSQL returns with valid sql should be equal a sql param", () => {
            const sql = "SELECT * FROM `TB_GRAINS` WHERE 1 = 1;";
            database.validateSQL(sql).should.be.equal(sql);
        });

        it("validateSQL returns with invalid sintax SELECT should be equal null", () => {
            const sql = "SELECIONE * FROM `TB_GRAINS` WHERE 1 = 1;";
            (database.validateSQL(sql) === null).should.be.equal(true);
        });
        it("validateSQL returns with invalid sintax END WITH ; should be equal null", () => {
            const sql = "SELECT * FROM `TB_GRAINS` WHERE 1 = 1";
            (database.validateSQL(sql) === null).should.be.equal(true);
        });

        it("createDatabase should be fulfilled with true", () => {
            database.createDatabase().should.be.fulfilledWith(true);
        });

        it("tableExit with exist table should be fulfilled with true", () => {
            database.tableExist('MY_TEMP').should.be.fulfilledWith(true);
        });

        it("tableExit without exist table should be fulfilled with false", () => {
            database.tableExist('MY_TEMP23').should.be.fulfilledWith(false);
        });

        it("createTable should be fullfiled", () => {
            return database
                .createTable('MY_TEMP21', ['COD INTEGER', 'NAME VARCHAR(100)'])
                .then(() => {
                    return database.tableExist('MY_TEMP21')
                })
                .then((resp) => {
                    if (!resp) throw new Error('Table Not Created');
                    return database.dropTable('MY_TEMP21')
                        .then(() => true);
                })
                .should
                .be
                .fulfilledWith(true);
        });

        it("dropTable without exist table should be rejected", () => {
            return database.dropTable('MY_TEMP23').should.be.rejected();
        });

        it("dropTable with valida table should be fulfilled", () => {
            const sql = `CREATE TABLE TB_TEMP2 (ID INTEGER  NOT NULL,"DESC" VARCHAR(255)  NOT NULL);`;
            return database
                .execute(sql)
                .then(() => {
                    return database.dropTable('TB_TEMP2');
                })
                .then(() => {
                    return database.tableExist('TB_TEMP2');
                })
                .should
                .be
                .fulfilledWith(false);
        });
    });

    context("Database SQL", () => {
        it("execute with DQL should be rejected ", () => {
            database.execute('SELECT * FROM TB_TEMP;').should.be.rejected();
        });

        it("execute with DDL CREATE should be fulfilled", () => {
            const sql = `CREATE TABLE TB_TEMP (ID INTEGER  NOT NULL,"DESC" VARCHAR(255)  NOT NULL);`;
            return database.execute(sql).should.be.fulfilled();
        });

        it("execute with DDL ALTER should be fulfilled", () => {
            const sql = `ALTER TABLE TB_TEMP ADD PRIMARY KEY (ID);`;
            return database.execute(sql).should.be.fulfilled();
        });

        it("query SELECT should be fulfilled after CREATE", () => {
            const sql = `SELECT * FROM TB_TEMP;`;
            return database.query(sql).should.be.fulfilled();
        });

        it("execute with DML INSERT should be fulfilled", () => {
            const sql = `INSERT INTO TB_TEMP VALUES(1,'TESTE 1');`;
            return database.execute(sql).should.be.fulfilled();
        });

        it("execute with DML INSERT with PARAMS should be fulfilled", () => {
            const sql = `INSERT INTO TB_TEMP VALUES(?,?);`;
            const params = [2, 'TESTING 2']
            return database.execute(sql, params).should.be.fulfilled();
        });

        it("query SELECT COUNT after insert should be fulfilled with an array with object with COUNT 2", () => {
            const sql = `SELECT COUNT(*) FROM TB_TEMP;`;
            return database.query(sql).should.be.fulfilledWith([{ COUNT: 2 }]);
        });

        it("execute with DML UPDATE should be fulfilled", () => {
            const sql = `UPDATE TB_TEMP SET "DESC" = 'TEMP CHANGE' WHERE ID = 1;`;
            return database.execute(sql).should.be.fulfilled();
        });

        it("execute with DML DELETE should be fulfilled", () => {
            const sql = `DELETE FROM TB_TEMP WHERE ID = 1;`;
            return database.execute(sql).should.be.fulfilled();
        });

        it("query SELECT COUNT after delete should be fulfilled with an array with object with COUNT 1", () => {
            const sql = `SELECT COUNT(*) FROM TB_TEMP;`;
            return database.query(sql).should.be.fulfilledWith([{ COUNT: 1 }]);
        });

        it("execute with DDL DROP should be fulfilled", () => {
            const sql = `DROP TABLE TB_TEMP;`;
            return database.execute(sql).should.be.fulfilled();
        });

        it("query SELECT should be rejected after DROP", () => {
            const sql = `SELECT * FROM TB_TEMP;`;
            return database.query(sql).should.be.rejected();
        });
    });
});