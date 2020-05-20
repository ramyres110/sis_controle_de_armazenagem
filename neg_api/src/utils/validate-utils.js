/**
 * Normalize a port number
 * @param {*} val 
 * @returns {number || boolean}
 */
function normalizePort(val) {
    if (!val) return false;
    let port = parseInt(val, 10);
    if (isNaN(port)) return false;
    if (port <= 0) {
        port = parseInt(val, 16);
    }
    if (port <= 0) return false;
    return port;
}

const invalidsCNPJList = [
    "00000000000000",
    "11111111111111",
    "22222222222222",
    "33333333333333",
    "44444444444444",
    "55555555555555",
    "66666666666666",
    "77777777777777",
    "88888888888888",
    "99999999999999"
];

/**
 * Validate CNPJ
 * @param {string} cnpj 
 * @returns {boolean}
 */
function validateCNPJ(cnpj) {
    if (!cnpj) return false;

    let aux = (isNaN(cnpj)) ? cnpj.replace(/[^\d]+/g, '') : cnpj.toString();
    if (aux == '') return false;
    if (aux.length != 14) return false;
    if (invalidsCNPJList.indexOf(aux) > 0) return false;

    let length = aux.length - 2;
    let numbers = aux.substring(0, length);
    let validate = aux.substring(length);

    let calc = 0;
    let pos = length - 7;
    for (i = length; i >= 1; i--) {
        calc += numbers.charAt(length - i) * pos--;
        if (pos < 2) {
            pos = 9;
        }
    }
    const dv1 = (calc % 11 < 2) ? 0 : (11 - (calc % 11));
    if (dv1 != validate.charAt(0)) return false;

    length = length + 1;
    numbers = aux.substring(0, length);
    calc = 0;
    pos = length - 7;

    for (i = length; i >= 1; i--) {
        calc += numbers.charAt(length - i) * pos--;
        if (pos < 2)
            pos = 9;
    }
    const dv2 = (calc % 11 < 2) ? 0 : (11 - (calc % 11));
    if (dv2 != validate.charAt(1)) return false;

    return true;
}

/**
 * Validate CPF
 * @param {string} cpf 
 * @returns {boolean}
 */
function validateCPF(cpf) {

}

module.exports = {
    normalizePort,
    validateCNPJ,
    validateCPF
}