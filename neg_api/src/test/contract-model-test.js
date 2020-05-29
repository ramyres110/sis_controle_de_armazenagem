const should = require('should');
const ContractModel = require('../models/contract-FB-model');

describe("CONTRACT MODEL TEST", () => {
    context("Class Methods", () => {
        it("sync should be fulfilled", () => {
            return ContractModel.sync().should.be.fulfilled();
        });
        it("findAll should be fulfilled", () => {
            return ContractModel.findAll().should.be.fulfilled();
        });
        it("findById should be fulfilled", () => {
            return ContractModel.findById(1).should.be.fulfilled();
        });
    });
    context("Object Methods", () => {
        const contract = new ContractModel({
            id: parseInt(Math.random() * 100),
            producer: {
                id: 1,
                name: 'Ramyres Produtor',
                document: '04645088190'
            },
            grain: {
                id: 1,
                description: 'Milho',
                priceKg: 2.39
            },
            firstWeight: 180000,
            lastWeight: 40000,
            humidity: 0.2,
            contractPrice: 2.39,
            createdAt: new Date(),
            changedAt: new Date()
        });

        it("Constructor without params should be ok", () => {
            (new ContractModel()).should.be.ok();
        });

        it("toSQL return should be an Object", () => {
            contract.toSQL().should.be.an.Object()
        });

        it("toSQL object keys length should be equal to tableAttributes length", () => {
            Object.keys(contract.toSQL()).length.should.be.equal(contract.tableAttributes.length);
        });

        it("save return should be fulfilled", () => {
            // return contract.create().should.be.fulfilled()
        });

    });
});