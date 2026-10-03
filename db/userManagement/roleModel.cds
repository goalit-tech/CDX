namespace cdx.usr;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {cdx.common.Status} from '../common';

entity Role : cuid, managed {
    roleName    : String(50) @mandatory; // mandatory (Admin, Teacher, Student, Accountant, Principal, Librarian, HR)

    description : String(150); // optional
    status      : Association to Status; // optional
}
