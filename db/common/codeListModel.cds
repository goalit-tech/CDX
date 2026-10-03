namespace cdx.common;

using {sap.common.CodeList} from '@sap/cds/common';

//////////////////////////////////////////////////////
// Code List Entities (no manual data, seeded via csv)
//////////////////////////////////////////////////////

@cds.persistence.skip
@readonly
entity Status : CodeList {
    key code : String(2);
}

@cds.persistence.skip
@readonly
entity AddressType : CodeList {
    key code : String(2);
}

// type AddressTypeEnuypm : String(50) enum {
//     HQ;
//     Branch;
//     Residential;
//     Billing;
// };

// reusable enum for polymorphic entityId references (e.g. Address.entityType)
type EntityName : String(30) enum {
    Organization;
    Campus;
    Employee;
    Student;
};
