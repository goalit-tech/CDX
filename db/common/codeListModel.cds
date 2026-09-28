namespace siemens.cdx.common;

using {sap.common.CodeList} from '@sap/cds/common';

//////////////////////////////////////////////////////
// Code List Entities (no manual data, seeded via csv)
//////////////////////////////////////////////////////

@cds.persistence.skip
entity Status : CodeList {
    key code : String(2);
}
