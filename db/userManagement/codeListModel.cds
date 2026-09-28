namespace siemens.cdx.usr;

using {sap.common.CodeList} from '@sap/cds/common';

@cds.persistence.skip
entity EmployeeRole : CodeList {
    key code : String(5);
}
// enum {
//     Teacher;
//     Principal;
//     Accountant;
//     Librarian;
//     HR;
//     Admin;
//     SupportStaff;
// }; // mandatory
