namespace siemens.cdx.usr;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {siemens.cdx.org.Campus} from '../organizationSetup';
using {siemens.cdx.common.Status} from '../common';
using {siemens.cdx.common.Address} from '../common';
using {siemens.cdx.usr.Enrollment} from './enrollmentModel';


entity Students : cuid, managed {
    campus                   : Association to Campus; // mandatory
    studentName              : String(150); // mandatory
    dateOfBirth              : Date; // mandatory
    guardianName             : String(150); // mandatory

    gender                   : String(20); // optional
    email                    : String(150); // optional
    phone                    : String(30); // optional
    admissionDate            : Date; // optional
    status                   : Association to Status;

    guardianRelation         : String(50); // optional (Father, Mother, Guardian)
    guardianPhone            : String(30); // optional
    guardianEmail            : String(150); // optional

    emergencyContactName     : String(150); // optional
    emergencyContactPhone    : String(30); // optional
    emergencyContactRelation : String(50); // optional

    addresses                : Composition of many Address; // optional

    enrollments              : Composition of many Enrollment on enrollments.student = $self;
}
