const should = require('should');

const validateUtils = require('../utils/validate-utils');

describe("VALIDATE UTILS TEST", () => {
    context("NORMALIZE PORT", () => {
        const normalizePort = validateUtils.normalizePort;
        it("Function normalizePort without params should be false;", () => {
            normalizePort().should.be.false();
        });
        it("Function normalizePort with params 123 should be equal 123;", () => {
            normalizePort(123).should.be.deepEqual(123);
        });
        it("Function normalizePort with params '123' should be equal 123;", () => {
            normalizePort('123').should.be.deepEqual(123);
        });
        it("Function normalizePort with params 'abc' should be equal 123;", () => {
            normalizePort('abc').should.be.false();
        });
        it("Function normalizePort with params hex '0xA' should be equal 15;", () => {
            normalizePort('0xA').should.be.equal(10);
        });
        it("Function normalizePort with params hex '0xF' should be equal 15;", () => {
            normalizePort('0xF').should.be.equal(15);
        });
    });

    context("VALIDATE CNPJ", () => {
        const validateCNPJ = validateUtils.validateCNPJ;
        it("Function validateCNPJ without params should be false",()=>{
            validateCNPJ().should.be.false();
        });
        it("Function validateCNPJ with param asdfgh should be false",()=>{
            validateCNPJ('asdfgHJKLÇ').should.be.false();
        });
        it("Function validateCNPJ with param 00000000000000 should be false",()=>{
            validateCNPJ('000000000000000').should.be.false();
        });
        it("Function validateCNPJ with param 99999999999999 should be false",()=>{
            validateCNPJ('99999999999999').should.be.false();
        });
        it("Function validateCNPJ with param 05.612.461/0001-39 should be true",()=>{
            validateCNPJ('05.612.461/0001-39').should.be.true();
        });
        it("Function validateCNPJ with param 05612461000139 should be true",()=>{
            validateCNPJ('05612461000139').should.be.true();
        });
        it("Function validateCNPJ with param 02.435.301/0001-73 should be true",()=>{
            validateCNPJ('02.435.301/0001-73').should.be.true();
        });
        it("Function validateCNPJ with param 02435301000173 should be true",()=>{
            validateCNPJ('02435301000173').should.be.true();
        });
        it("Function validateCNPJ with param number with start zero 02435301000173 should be false",()=>{
            validateCNPJ(02435301000173).should.be.false();
        });
        it("Function validateCNPJ with param invalid number 12435301000173 should be false",()=>{
            validateCNPJ(12435301000173).should.be.false();
        });
        it("Function validateCNPJ with param number 31432833000155 should be true",()=>{
            validateCNPJ(31432833000155).should.be.true();
        });
    });
});