namespace siemens.cdx.usr;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {siemens.cdx.usr.Student} from './studentModel';
using {
    siemens.cdx.org.AcademicYear,
    siemens.cdx.org.Grade,
    siemens.cdx.org.Section
} from '../organizationSetup';
using {siemens.cdx.common.Status} from '../common';

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
