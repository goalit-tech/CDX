namespace campusdesk;

using { cuid, managed } from '@sap/cds/common';


//////////////////////////////////////////////////////
// Academic Year Entity
//////////////////////////////////////////////////////
entity AcademicYears : cuid, managed {
    school       : Association to Schools; // mandatory, links back to Phase 1
    yearLabel    : String(50);             // mandatory
    startDate    : Date;                   // mandatory
    endDate      : Date;                   // mandatory

    isCurrentSession : Boolean;            // optional
    description      : String(200);        // optional

    grades : Composition of many Grades;
    events : Composition of many CalendarEvents;
}

//////////////////////////////////////////////////////
// Grade Entity
//////////////////////////////////////////////////////
entity Grades : cuid, managed {
    academicYear : Association to AcademicYears; // mandatory
    gradeName    : String(100);                  // mandatory

    gradeCode    : String(50);                   // optional
    description  : String(200);                  // optional

    sections : Composition of many Sections;
}

//////////////////////////////////////////////////////
// Section Entity
//////////////////////////////////////////////////////
entity Sections : cuid, managed {
    grade       : Association to Grades; // mandatory
    sectionName : String(50);            // mandatory

    sectionCode : String(50);            // optional
    capacity    : Integer;               // optional
    description : String(200);           // optional
}

//////////////////////////////////////////////////////
// Academic Calendar Events Entity
//////////////////////////////////////////////////////
entity CalendarEvents : cuid, managed {
    academicYear : Association to AcademicYears; // mandatory
    eventName    : String(200);                  // mandatory
    eventType    : String(50) enum { Holiday; Exam; Meeting; Orientation; }; // mandatory
    startDate    : Date;                         // mandatory
    endDate      : Date;                         // mandatory

    description  : String(200);                  // optional
    location     : String(200);                  // optional
}
