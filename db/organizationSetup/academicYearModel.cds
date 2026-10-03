namespace cdx.org;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {cdx.org.Campus} from './campusModel';
using {cdx.org.Grade} from './gradeModel';
using {cdx.org.CalendarEvent} from './calendarEventModel';

entity AcademicYear : cuid, managed {
    campus           : Association to Campus; // mandatory, links back to Phase 1
    yearLabel        : String(20); // mandatory
    startDate        : Date; // mandatory
    endDate          : Date; // mandatory

    isCurrentSession : Boolean; // optional
    description      : String(150); // optional

    grades           : Composition of many Grade
                           on grades.academicYear = $self;
    events           : Composition of many CalendarEvent
                           on events.academicYear = $self;
}
