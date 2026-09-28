namespace siemens.cdx.org;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {siemens.cdx.common.Address} from '../common';
using {siemens.cdx.org.Organization} from './oganizationModel';
using {siemens.cdx.org.CampusCategory} from './codeListModel';
using {siemens.cdx.common.Status} from '../common';

@assert.unique.campusCode: [
    org,
    campusCode
]
entity Campus : cuid, managed {
    organization        : Association to Organization   @mandatory; // mandatory
    campusName          : String(200)                   @mandatory; // mandatory
    campusCode          : String(20)                    @mandatory; // mandatory, unique per org
    campusCategory      : Association to CampusCategory @mandatory; // mandatory
    mediumOfInstruction : String(50); // optional
    studentCapacity     : Integer; // optional
    accreditationID     : String(100); // optional
    establishedYear     : Integer; // optional
    status              : Association to Status;
    logoURL             : String(200); // optional
    principalName       : String(150); // optional
    adminEmail          : String(150); // optional
    adminPhone          : String(30); // optional

    addresses           : Composition of many Address;
}
