namespace cdx.common;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {cdx.common.AddressType} from './codeListModel';
using {cdx.common.EntityName} from './codeListModel';

//////////////////////////////////////////////////////
// Address Entity
//////////////////////////////////////////////////////
entity Address : cuid, managed {
    entityId       : UUID;
    entityName     : EntityName; // mandatory
    addressLine1   : String(200); // mandatory
    city           : String(100); // mandatory
    country        : String(100); // mandatory

    addressLine2   : String(200); // optional
    stateProvince  : String(100); // optional
    postalCode     : String(20); // optional
    contactPhone   : String(30); // optional
    contactEmail   : String(150); // optional
    geoCoordinates : String(100); // optional (lat/long)
    isPrimary      : Boolean default true;
    addressType    : Association to AddressType; // optional
}
