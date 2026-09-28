namespace campusdesk;

using { cuid, managed } from '@sap/cds/common';

//////////////////////////////////////////////////////
// Employee Entity (covers teachers, principals, staff)
//////////////////////////////////////////////////////
entity Employees : cuid, managed {
    school       : Association to Schools; // mandatory
    employeeName : String(150);            // mandatory
    employeeID   : String(50);             // mandatory
    email        : String(150);            // mandatory
    employeeRole : String(50);             // mandatory (Teacher, Principal, Accountant, Librarian, HR, Admin, Support Staff)

    phone        : String(30);             // optional
    qualifications: String(200);           // optional
    specialization: String(100);           // optional
    hireDate     : Date;                   // optional
    status       : String(20);             // optional (Active, Inactive)

    addresses : Composition of many Addresses; // optional
}

//////////////////////////////////////////////////////
// Student Entity
//////////////////////////////////////////////////////
entity Students : cuid, managed {
    school       : Association to Schools; // mandatory
    studentName  : String(150);            // mandatory
    dateOfBirth  : Date;                   // mandatory
    guardianName : String(150);            // mandatory

    gender       : String(20);             // optional
    email        : String(150);            // optional
    phone        : String(30);             // optional
    admissionDate: Date;                   // optional
    status       : String(20);             // optional (Active, Inactive)

    addresses : Composition of many Addresses; // optional

    enrollments : Composition of many Enrollments;
}

//////////////////////////////////////////////////////
// Enrollment Entity
//////////////////////////////////////////////////////
entity Enrollments : cuid, managed {
    student      : Association to Students;      // mandatory
    academicYear : Association to AcademicYears; // mandatory
    grade        : Association to Grades;        // mandatory
    section      : Association to Sections;      // mandatory

    enrollmentDate : Date;                       // optional
    rollNumber     : String(50);                 // optional
    status         : String(20);                 // optional (Active, Transferred, Graduated)
}

//////////////////////////////////////////////////////
// Role Entity
//////////////////////////////////////////////////////
entity Roles : cuid, managed {
    userID    : UUID;              // mandatory (links to Employee or Student)
    roleName  : String(50);        // mandatory (Admin, Teacher, Student, Accountant, Principal, Librarian, HR)

    description : String(200);     // optional
    status      : String(20);      // optional (Active, Inactive)
}
