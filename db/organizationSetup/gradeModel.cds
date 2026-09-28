namespace siemens.cdx.org;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {siemens.cdx.org.AcademicYear} from './academicYearModel';
using {siemens.cdx.org.Section} from './sectionModel';

entity Grade : cuid, managed {
    academicYear : Association to AcademicYear; // mandatory
    gradeName    : String(80); // mandatory

    gradeCode    : String(20); // optional
    description  : String(150); // optional

    sections     : Composition of many Section;
}
