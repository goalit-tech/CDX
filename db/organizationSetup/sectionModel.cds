namespace siemens.cdx.org;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {siemens.cdx.org.Grade} from './gradeModel';

entity Section : cuid, managed {
    grade       : Association to Grade; // mandatory
    sectionName : String(50); // mandatory

    sectionCode : String(50); // optional
    capacity    : Integer; // optional
    description : String(200); // optional
}
