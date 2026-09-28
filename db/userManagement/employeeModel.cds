namespace siemens.cdx.usr;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {siemens.cdx.org.Campus} from '../organizationSetup';
using {siemens.cdx.common.Status} from '../common';
using {siemens.cdx.common.Address} from '../common';
using {siemens.cdx.usr.EmployeeRole} from './codeListModel';


@assert.unique.employeeID: [
    campus,
    employeeID
]
entity Employee : cuid, managed {
    employeeID     : String(50)                  @mandatory; // mandatory, unique per campus
    campus         : Association to Campus       @mandatory; // mandatory
    firstName      : String(40)                  @mandatory; // mandatory
    lastName       : String(40)                  @mandatory; // mandatory
    middleName     : String(40)                  @optional; // optional
    email          : String(150)                 @mandatory; // mandatory
    employeeRole   : Association to EmployeeRole @mandatory; // mandatory

    phone          : String(30); // optional
    qualifications : String(200); // optional
    specialization : String(100); // optional
    hireDate       : Date; // optional
    status         : Association to Status; // optional
    addresses      : Composition of many Address
                           on  addresses.entityId   = ID
                           and addresses.entityName = 'Employee';
}
