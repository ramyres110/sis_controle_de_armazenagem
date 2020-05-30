const path = require('path');
const os = require('os');

const loki = require('lokijs');
const lfsa = require('lokijs/src/loki-fs-structured-adapter');

let databasePath = path.join(path.normalize(__dirname + '/../..'), 'data', 'DATABASE.db');
if(__dirname.indexOf('utils') < 0){//PROD
    databasePath = path.join(path.normalize(__dirname + '/..'), 'data', 'DATABASE.db');
}

const getDatabase = new Promise((resolve) => {

    var db = new loki(databasePath, {
        adapter: new lfsa(),
        autoload: true,
        autoloadCallback: databaseInitialize,
        autosave: true,
        autosaveInterval: 4000
    });

    process.on('SIGINT', function () {
        console.log("flushing database");
        db.close();
        process.exit();
    });

    function databaseInitialize() {
        var contracts = db.getCollection("contracts");
        if (contracts === null) {
            contracts = db.addCollection("contracts", { indices: ['x'], clone: true });
        }
        runProgramLogic();
    }

    function runProgramLogic() {
        return resolve(db);
    }
});

module.exports = getDatabase;