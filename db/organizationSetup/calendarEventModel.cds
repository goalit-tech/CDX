namespace siemens.cdx.org;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {siemens.cdx.org.AcademicYear} from './academicYearModel';
using {siemens.cdx.org.CalendarEventType} from './codeListModel';

entity CalendarEvent : cuid, managed {
    academicYear : Association to AcademicYear; // mandatory
    eventName    : String(100); // mandatory
    eventType    : Association to CalendarEventType; // mandatory
    startDate    : Date; // mandatory
    endDate      : Date; // mandatory

    description  : String(150); // optional
    location     : String(150); // optional
}
