const cds = require('@sap/cds');
const { createAccount } = require('../authentication/accounts');

class UserAdministrationService extends cds.ApplicationService {
    async init() {
        this.on('createUser', req =>
            createAccount(cds.db.tx(req), req.data, req.data.roleGroupName, req.reject.bind(req))
        );

        return super.init();
    }
}

module.exports = UserAdministrationService;