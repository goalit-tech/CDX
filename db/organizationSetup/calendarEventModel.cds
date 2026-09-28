namespace siemens.cdx.org;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {siemens.cdx.org.AcademicYear} from './academicYearModel';
using {siemens.cdx.org.CalendarEventType} from './codeListModel';

entity CalendarEvent : cuid, managed {
    academicYear : Association to AcademicYear; // mandatory
    eventName    : String(200); // mandatory
    eventType    : Association to CalendarEventType; // mandatory
    startDate    : Date; // mandatory
    endDate      : Date; // mandatory

    description  : String(200); // optional
    location     : String(200); // optional
}
