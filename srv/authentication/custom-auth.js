const cds = require('@sap/cds');
const { verifyToken } = require('./security');

module.exports = function customAuth(req, res, next) {
    const authorization = req.headers.authorization;
    if (!authorization) {
        cds.context.user = cds.User.anonymous;
        return next();
    }

    const match = /^Bearer\s+([^\s]+)$/i.exec(authorization);
    if (!match) {
        res.set('WWW-Authenticate', 'Bearer');
        return res.status(401).json({ error: 'A valid bearer token is required.' });
    }

    try {
        const claims = verifyToken(match[1]);
        cds.context.user = new cds.User({ id: claims.sub, roles: claims.roles });
        return next();
    } catch (error) {
        res.set('WWW-Authenticate', 'Bearer error="invalid_token"');
        return res.status(401).json({ error: 'The bearer token is invalid or expired.' });
    }
};