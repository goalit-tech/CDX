namespace campusdesk;

using { cuid, managed } from '@sap/cds/common';

//////////////////////////////////////////////////////
// Employee Entity (covers teachers, principals, staff)
//////////////////////////////////////////////////////
@assert.unique.employeeID: [school, employeeID]
entity Employees : cuid, managed {
    school       : Association to Schools; // mandatory
    employeeName : String(150);            // mandatory
    employeeID   : String(50);             // mandatory, unique per school
    email        : String(150);            // mandatory
    employeeRole : String(50) enum { Teacher; Principal; Accountant; Librarian; HR; Admin; SupportStaff; }; // mandatory

    phone        : String(30);             // optional
    qualifications: String(200);           // optional
    specialization: String(100);           // optional
    hireDate     : Date;                   // optional
    status       : String(20) enum { Active; Inactive; }; // optional

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
    status       : String(20) enum { Active; Inactive; }; // optional

    guardianRelation : String(50);         // optional (Father, Mother, Guardian)
    guardianPhone    : String(30);         // optional
    guardianEmail    : String(150);        // optional

    emergencyContactName    : String(150); // optional
    emergencyContactPhone   : String(30);  // optional
    emergencyContactRelation: String(50);  // optional

    addresses : Composition of many Addresses; // optional

    enrollments : Composition of many Enrollments;
}

//////////////////////////////////////////////////////
// Enrollment Entity
//////////////////////////////////////////////////////
@assert.unique.rollNumber: [academicYear, grade, section, rollNumber]
entity Enrollments : cuid, managed {
    student      : Association to Students;      // mandatory
    academicYear : Association to AcademicYears; // mandatory
    grade        : Association to Grades;        // mandatory
    section      : Association to Sections;      // mandatory

    enrollmentDate : Date;                       // optional
    rollNumber     : String(50);                 // optional, unique per section/year when set
    status         : String(20) enum { Active; Transferred; Graduated; }; // optional
}

//////////////////////////////////////////////////////
// Role Entity (master list of predefined roles)
//////////////////////////////////////////////////////
entity Roles : cuid, managed {
    roleName  : String(50);        // mandatory (Admin, Teacher, Student, Accountant, Principal, Librarian, HR)

    description : String(200);     // optional
    status      : String(20) enum { Active; Inactive; }; // optional
}

//////////////////////////////////////////////////////
// Role Assignment Entity (assigns a Role to an Employee or a Student)
//////////////////////////////////////////////////////
entity RoleAssignments : cuid, managed {
    role     : Association to Roles;     // mandatory
    employee : Association to Employees; // set when role is assigned to an employee
    student  : Association to Students;  // set when role is assigned to a student
    // exactly one of employee/student must be set; enforced in service handler

    status : String(20) enum { Active; Inactive; }; // optional
}
