const cds = require('@sap/cds');

class StudentService extends cds.ApplicationService {
    async init() {
        return super.init();
    }
}

module.exports = StudentService;