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
    addressType   : String(50) enum { HQ; Branch; Residential; Billing; }; // optional
}

//////////////////////////////////////////////////////
// Organization Entity
//////////////////////////////////////////////////////
@assert.unique.orgCode: [orgCode]
entity Organizations : cuid, managed {
    orgName         : String(200); // mandatory
    orgCode         : String(50);  // mandatory, unique

    orgCategory     : String(50) enum { Kindergarten; School; College; University; Coaching; Training; }; // mandatory
    scopeOfEducation: String(100); // optional
    affiliationBody : String(100); // optional

    taxID           : String(100); // optional
    accreditationID : String(100); // optional
    registrationDate: Date;        // optional

    establishedYear : Integer;     // optional
    orgType         : String(50) enum { Trust; Society; Private; Govt; University; }; // optional
    operationalStatus: String(20) enum { Active; Inactive; Suspended; }; // optional
    logoURL         : String(200); // optional

    addresses : Composition of many Addresses;
}

//////////////////////////////////////////////////////
// School Entity
//////////////////////////////////////////////////////
@assert.unique.branchCode: [org, branchCode]
entity Schools : cuid, managed {
    org            : Association to Organizations; // mandatory
    schoolName     : String(200); // mandatory
    branchCode     : String(50);  // mandatory, unique per org

    schoolCategory : String(50) enum { Kindergarten; Primary; Secondary; College; Coaching; University; }; // mandatory
    mediumOfInstruction : String(50); // optional
    studentCapacity: Integer;     // optional

    accreditationID : String(100); // optional
    establishedYear : Integer;     // optional
    operationalStatus: String(20) enum { Active; Inactive; Suspended; }; // optional
    logoURL         : String(200); // optional

    principalName : String(150);   // optional
    adminEmail    : String(150);   // optional
    adminPhone    : String(30);    // optional

    addresses : Composition of many Addresses;
}
