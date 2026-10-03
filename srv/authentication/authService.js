const cds = require('@sap/cds');
const { SELECT } = cds.ql;
const { createAccount, getUserInfo } = require('./accounts');
const { issueToken, verifyPassword } = require('./security');

class AuthenticationService extends cds.ApplicationService {
    async init() {
        this.on('login', async (req) => {
            const { username, password } = req.data;
            if (typeof username !== 'string' || typeof password !== 'string' || !username || !password) {
                return req.reject(400, 'Username and password are required.');
            }

            let account = await SELECT.one.from('cdx.auth.Role').where({ userId: username });
            if (!account) {
                account = await SELECT.one.from('cdx.auth.Role').where({ email: username });
            }
            if (!account || !account.isActive || !await verifyPassword(password, account.password)) {
                return req.reject(401, 'Invalid username or password.');
            }

            const roleGroup = account.roleGroup_ID
                ? await SELECT.one.from('cdx.auth.RoleGroup').columns('roleGroupName').where({ ID: account.roleGroup_ID })
                : null;
            const roles = roleGroup?.roleGroupName ? [roleGroup.roleGroupName] : [];
            const expiresIn = 3600;
            const user = getUserInfo(account, roles);

            return {
                accessToken: issueToken({ sub: account.userId, roles }, expiresIn),
                tokenType: 'Bearer',
                expiresIn,
                user
            };
        });

        this.on('bootstrapAdmin', async (req) => {
            const tx = cds.db.tx(req);
            const existingAccount = await tx.run(SELECT.one.from('cdx.auth.Role').columns('ID'));
            if (existingAccount) {
                return req.reject(409, 'Initial administrator has already been created.');
            }
            return createAccount(tx, req.data, 'admin', req.reject.bind(req));
        });

        return super.init();
    }
}

module.exports = AuthenticationService;
