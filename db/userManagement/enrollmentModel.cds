namespace cdx.usr;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {cdx.usr.Student} from './studentModel';
using {
    cdx.org.AcademicYear,
    cdx.org.Grade,
    cdx.org.Section
} from '../organizationSetup';
using {cdx.common.Status} from '../common';

@assert.unique.rollNumber: [
    academicYear,
    grade,
    section,
    rollNumber
]
entity Enrollment : cuid, managed {
    student        : Association to Student      @mandatory; // mandatory
    academicYear   : Association to AcademicYear @mandatory; // mandatory
    grade          : Association to Grade        @mandatory; // mandatory
    section        : Association to Section      @mandatory; // mandatory

    enrollmentDate : Date; // optional
    rollNumber     : String(20); // optional, unique per section/year when set
    status         : Association to Status; // optional
}
