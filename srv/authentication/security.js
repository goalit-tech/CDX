const crypto = require('node:crypto');
const { promisify } = require('node:util');

const scrypt = promisify(crypto.scrypt);
const issuer = 'cdx-authentication';
const audience = 'cdx-api';

function getSecret() {
    const secret = process.env.JWT_SECRET;
    if (!secret || Buffer.byteLength(secret) < 32) {
        throw new Error('JWT_SECRET must contain at least 32 bytes.');
    }
    return secret;
}

function encode(value) {
    return Buffer.from(JSON.stringify(value)).toString('base64url');
}

function decode(value) {
    if (!/^[A-Za-z0-9_-]+$/.test(value)) {
        throw new Error('Invalid token encoding.');
    }
    const decoded = Buffer.from(value, 'base64url');
    if (decoded.toString('base64url') !== value) {
        throw new Error('Invalid token encoding.');
    }
    return JSON.parse(decoded.toString('utf8'));
}

function signature(input) {
    return crypto.createHmac('sha256', getSecret()).update(input).digest();
}

function issueToken(user, expiresIn) {
    const now = Math.floor(Date.now() / 1000);
    const header = encode({ alg: 'HS256', typ: 'JWT' });
    const payload = encode({
        iss: issuer,
        aud: audience,
        sub: user.sub,
        roles: user.roles,
        iat: now,
        exp: now + expiresIn
    });
    const input = `${header}.${payload}`;
    return `${input}.${signature(input).toString('base64url')}`;
}

function verifyToken(token) {
    if (typeof token !== 'string' || token.length > 8192) {
        throw new Error('Invalid token.');
    }

    const parts = token.split('.');
    if (parts.length !== 3) {
        throw new Error('Invalid token.');
    }

    const header = decode(parts[0]);
    const claims = decode(parts[1]);
    if (header.alg !== 'HS256' || header.typ !== 'JWT') {
        throw new Error('Unsupported token.');
    }

    const actualSignature = Buffer.from(parts[2], 'base64url');
    const expectedSignature = signature(`${parts[0]}.${parts[1]}`);
    if (actualSignature.length !== expectedSignature.length ||
        !crypto.timingSafeEqual(actualSignature, expectedSignature)) {
        throw new Error('Invalid token signature.');
    }

    const now = Math.floor(Date.now() / 1000);
    if (claims.iss !== issuer || claims.aud !== audience ||
        typeof claims.sub !== 'string' || !claims.sub ||
        !Array.isArray(claims.roles) || !claims.roles.every(role => typeof role === 'string') ||
        !Number.isInteger(claims.iat) || claims.iat > now + 60 ||
        !Number.isInteger(claims.exp) || claims.exp <= now || claims.exp <= claims.iat) {
        throw new Error('Invalid or expired token.');
    }

    return claims;
}

async function hashPassword(password) {
    if (typeof password !== 'string' || !password) {
        throw new Error('Password must be a non-empty string.');
    }
    const salt = crypto.randomBytes(16);
    const hash = await scrypt(password, salt, 64);
    return `scrypt$${salt.toString('base64url')}$${hash.toString('base64url')}`;
}

async function verifyPassword(password, storedHash) {
    if (typeof password !== 'string' || typeof storedHash !== 'string') {
        return false;
    }
    const [algorithm, saltValue, hashValue, extra] = storedHash.split('$');
    if (algorithm !== 'scrypt' || !saltValue || !hashValue || extra !== undefined) {
        return false;
    }

    try {
        const salt = Buffer.from(saltValue, 'base64url');
        const expectedHash = Buffer.from(hashValue, 'base64url');
        if (!salt.length || expectedHash.length !== 64) {
            return false;
        }
        const actualHash = await scrypt(password, salt, expectedHash.length);
        return crypto.timingSafeEqual(actualHash, expectedHash);
    } catch (error) {
        return false;
    }
}

module.exports = { hashPassword, issueToken, verifyPassword, verifyToken };