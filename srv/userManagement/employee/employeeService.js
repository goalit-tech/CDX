const cds = require('@sap/cds');

class EmployeeService extends cds.ApplicationService {
    async init() {
        return super.init();
    }
}

module.exports = EmployeeService;