namespace siemens.cdx.org;

using {sap.common.CodeList} from '@sap/cds/common';

//////////////////////////////////////////////////////
// Code List Entities (no manual data, seeded via csv)
//////////////////////////////////////////////////////
@cds.persistence.skip
entity OrganizationCategory : CodeList {
    key code : String(5);
}

@cds.persistence.skip
entity OrganizationType : CodeList {
    key code : String(5);
}

@cds.persistence.skip
entity CampusCategory : CodeList {
    key code : String(5);
}

@cds.persistence.skip
entity CalendarEventType : CodeList {
    key code : String(5);
}
