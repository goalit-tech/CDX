namespace siemens.cdx.usr;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {siemens.cdx.usr.Role} from './roleModel';
using {siemens.cdx.usr.Employee} from './employeeModel';
using {siemens.cdx.usr.Student} from './studentModel';
using {siemens.cdx.common.Status} from '../common';

entity RoleAssignment : cuid, managed {
    role     : Association to Role @mandatory; // mandatory
    employee : Association to Employee; // set when role is assigned to an employee
    student  : Association to Student; // set when role is assigned to a student
    // exactly one of employee/student must be set; enforced in service handler

    status   : Association to Status; // optional
}
