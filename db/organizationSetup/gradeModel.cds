namespace siemens.cdx.org;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {siemens.cdx.org.AcademicYear} from './academicYearModel';
using {siemens.cdx.org.Section} from './sectionModel';

entity Grade : cuid, managed {
    academicYear : Association to AcademicYear; // mandatory
    gradeName    : String(100); // mandatory

    gradeCode    : String(50); // optional
    description  : String(200); // optional

    sections     : Composition of many Section;
}
