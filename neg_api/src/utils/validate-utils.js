/**
 * Normalize a port run a Server
 * @param {*} val 
 */
function normalizePort(val) {
    if (!val) return false;
    var port = parseInt(val, 10);
    if (isNaN(port)) return val;
    if (port >= 0) return port;
    return false;
}


module.exports = {
    normalizePort
}