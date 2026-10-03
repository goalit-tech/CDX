const cds = require('@sap/cds');
const { SELECT, INSERT } = cds.ql;
const { hashPassword } = require('./security');

const allowedRoleGroups = new Set(['admin', 'faculty']);

function validateAccount(data, roleGroupName) {
    if (typeof data.username !== 'string' || !/^[A-Za-z0-9._-]{1,10}$/.test(data.username)) {
        return 'Username must be 1 to 10 characters and use only letters, numbers, dots, underscores, or hyphens.';
    }
    if (typeof data.password !== 'string' || data.password.length < 12 || data.password.length > 255) {
        return 'Password must be between 12 and 255 characters.';
    }
    if (typeof data.firstName !== 'string' || !data.firstName.trim() || data.firstName.length > 40) {
        return 'First name is required and must be at most 40 characters.';
    }
    if (typeof data.lastName !== 'string' || !data.lastName.trim() || data.lastName.length > 40) {
        return 'Last name is required and must be at most 40 characters.';
    }
    if (typeof data.email !== 'string' || data.email.length > 255 ||
        !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(data.email)) {
        return 'A valid email address is required.';
    }
    if (!allowedRoleGroups.has(roleGroupName)) {
        return 'Role group must be admin or faculty.';
    }
    return null;
}

async function createAccount(tx, data, roleGroupName, reject) {
    const validationError = validateAccount(data, roleGroupName);
    if (validationError) {
        return reject(400, validationError);
    }

    const username = data.username.trim();
    const email = data.email.trim().toLowerCase();
    const duplicate = await tx.run(
        SELECT.one.from('cdx.auth.Role').columns('ID').where({ userId: username })
    ) || await tx.run(
        SELECT.one.from('cdx.auth.Role').columns('ID').where({ email })
    );
    if (duplicate) {
        return reject(409, 'Username or email is already in use.');
    }

    let roleGroup = await tx.run(
        SELECT.one.from('cdx.auth.RoleGroup').columns('ID').where({ roleGroupName })
    );
    if (!roleGroup) {
        const roleGroupId = cds.utils.uuid();
        await tx.run(INSERT.into('cdx.auth.RoleGroup').entries({
            ID: roleGroupId,
            roleGroupName
        }));
        roleGroup = { ID: roleGroupId };
    }

    const account = {
        ID: cds.utils.uuid(),
        userId: username,
        firstName: data.firstName.trim(),
        lastName: data.lastName.trim(),
        email,
        isActive: true,
        password: await hashPassword(data.password),
        roleGroup_ID: roleGroup.ID
    };
    await tx.run(INSERT.into('cdx.auth.Role').entries(account));

    return getUserInfo(account, [roleGroupName]);
}

function getUserInfo(account, roles) {
    return {
        id: account.userId,
        firstName: account.firstName,
        lastName: account.lastName,
        fullName: account.fullName || `${account.firstName} ${account.lastName}`,
        email: account.email,
        roles
    };
}

module.exports = { createAccount, getUserInfo };