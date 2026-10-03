namespace cdx.usr;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {cdx.org.Campus} from '../organizationSetup';
using {cdx.common.Status} from '../common';
using {cdx.common.Address} from '../common';
using {cdx.usr.Enrollment} from './enrollmentModel';


entity Student : cuid, managed {
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

    addresses                : Composition of many Address
                                   on  addresses.entityId   = ID
                                   and addresses.entityName = 'Student';

    enrollments              : Composition of many Enrollment
                                   on enrollments.student = $self;
}
