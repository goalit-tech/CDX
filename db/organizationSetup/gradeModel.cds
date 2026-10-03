namespace cdx.org;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {cdx.org.AcademicYear} from './academicYearModel';
using {cdx.org.Section} from './sectionModel';

entity Grade : cuid, managed {
    academicYear : Association to AcademicYear; // mandatory
    gradeName    : String(80); // mandatory

    gradeCode    : String(20); // optional
    description  : String(150); // optional

    sections     : Composition of many Section
                       on sections.grade = $self;
}
