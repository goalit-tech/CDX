namespace siemens.cdx.org;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {siemens.cdx.org.Campus} from './campusModel';
using {siemens.cdx.org.Grade} from './gradeModel';
using {siemens.cdx.org.CalendarEvent} from './calendarEventModel';

entity AcademicYear : cuid, managed {
    campus           : Association to Campus; // mandatory, links back to Phase 1
    yearLabel        : String(20); // mandatory
    startDate        : Date; // mandatory
    endDate          : Date; // mandatory

    isCurrentSession : Boolean; // optional
    description      : String(150); // optional

    grades           : Composition of many Grade;
    events           : Composition of many CalendarEvent;
}
