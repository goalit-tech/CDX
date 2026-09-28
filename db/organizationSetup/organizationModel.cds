namespace siemens.cdx.org;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {siemens.cdx.common.Address, } from '../common';
using {siemens.cdx.org.OrganizationCategory} from './codeListModel';
using {siemens.cdx.org.OrganizationType} from './codeListModel';
using {siemens.cdx.common.Status} from '../common';


@assert.unique.orgCode: [orgCode]
entity Organization : cuid, managed {
    orgName          : String(100)                         @mandatory; // mandatory
    orgCode          : String(20)                          @mandatory; // mandatory, unique

    orgCategory      : Association to OrganizationCategory @mandatory; // mandatory
    scopeOfEducation : String(100); // optional
    affiliationBody  : String(100); // optional

    taxID            : String(30); // optional
    accreditationID  : String(50); // optional
    registrationDate : Date; // optional

    establishedYear  : Integer; // optional
    orgType          : Association to OrganizationType; // optional
    Status           : Association to Status; // optional
    logoURL          : String(150); // optional
    addresses        : Composition of many Address
                           on  addresses.entityId   = ID
                           and addresses.entityName = 'Organization';
}
