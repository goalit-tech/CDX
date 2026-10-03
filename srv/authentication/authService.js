const cds = require('@sap/cds');

class AuthService extends cds.ApplicationService {
    async init() {
        this.on('whoami', (req) => {
            return {
                id: req.user.id,
                roles: Object.keys(req.user.roles || {})
            };
        });

        return super.init();
    }
}

module.exports = AuthService;
