namespace cdx.org;

using {sap.common.CodeList} from '@sap/cds/common';

//////////////////////////////////////////////////////
// Code List Entities (no manual data, seeded via csv)
//////////////////////////////////////////////////////
@cds.persistence.skip
@readonly
entity OrganizationCategory : CodeList {
    key code : String(2);
}

@cds.persistence.skip
@readonly
entity OrganizationType : CodeList {
    key code : String(2);
}

@cds.persistence.skip
@readonly
entity CampusCategory : CodeList {
    key code : String(2);
}

@cds.persistence.skip
@readonly
entity CalendarEventType : CodeList {
    key code : String(2);
}
