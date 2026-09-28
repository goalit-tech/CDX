namespace siemens.cdx.common;

using {
    cuid,
    managed
} from '@sap/cds/common';

//////////////////////////////////////////////////////
// Address Entity
//////////////////////////////////////////////////////
entity Address : cuid, managed {
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
    addressType    : String(50) enum {
        HQ;
        Branch;
        Residential;
        Billing;
    }; // optional
}
