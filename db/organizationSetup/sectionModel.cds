namespace cdx.org;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {cdx.org.Grade} from './gradeModel';

entity Section : cuid, managed {
    grade       : Association to Grade; // mandatory
    sectionName : String(50); // mandatory

    sectionCode : String(20); // optional
    capacity    : Integer; // optional
    description : String(150); // optional
}
