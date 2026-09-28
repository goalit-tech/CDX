namespace campusdesk;

using { cuid, managed } from '@sap/cds/common';

//////////////////////////////////////////////////////
// Address Entity
//////////////////////////////////////////////////////
entity Addresses : cuid, managed {
    addressLine1  : String(200);   // mandatory
    city          : String(100);   // mandatory
    country       : String(100);   // mandatory

    addressLine2  : String(200);   // optional
    stateProvince : String(100);   // optional
    postalCode    : String(20);    // optional
    contactPhone  : String(30);    // optional
    contactEmail  : String(150);   // optional
    geoCoordinates: String(100);   // optional (lat/long)
    isPrimary     : Boolean default true;
    addressType   : String(50);    // optional (HQ, Branch, Residential, Billing)
}

//////////////////////////////////////////////////////
// Organization Entity
//////////////////////////////////////////////////////
entity Organizations : cuid, managed {
    orgName         : String(200); // mandatory
    orgCode         : String(50);  // mandatory

    orgCategory     : String(50);  // Enum: Kindergarten, School, College, University, Coaching, Training
    scopeOfEducation: String(100); // optional
    affiliationBody : String(100); // optional

    taxID           : String(100); // optional
    accreditationID : String(100); // optional
    registrationDate: Date;        // optional

    establishedYear : Integer;     // optional
    orgType         : String(50);  // optional (Trust, Society, Private, Govt, University)
    operationalStatus: String(20); // optional (Active, Inactive, Suspended)
    logoURL         : String(200); // optional

    addresses : Composition of many Addresses;
}

//////////////////////////////////////////////////////
// School Entity
//////////////////////////////////////////////////////
entity Schools : cuid, managed {
    org            : Association to Organizations; // mandatory
    schoolName     : String(200); // mandatory
    branchCode     : String(50);  // mandatory

    schoolCategory : String(50);  // Enum: Kindergarten, Primary, Secondary, College, Coaching
    mediumOfInstruction : String(50); // optional
    studentCapacity: Integer;     // optional

    accreditationID : String(100); // optional
    schoolType      : String(50);  // optional (Primary, Secondary, College, University)
    establishedYear : Integer;     // optional
    operationalStatus: String(20); // optional (Active, Inactive, Suspended)
    logoURL         : String(200); // optional

    principalName : String(150);   // optional
    adminEmail    : String(150);   // optional
    adminPhone    : String(30);    // optional

    addresses : Composition of many Addresses;
}
