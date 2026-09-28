# SAP CAPM School Management System – Evolutionary User Stories

**Project Name:** CampusDesk (CampusDrive)  
**Schema Prefix:** `cd_`  
**Project Key:** `cdesk`

---

## Phase 1: Core Organization & Branch Infrastructure

### Story 1.1: Organization Setup

**As an Educational Trust Admin,**  
I want to register our main Organization entity in the system,  
So that I can manage all affiliated educational institutions under one umbrella.

**Acceptance Criteria:**

- Organizations CDS entity with attributes (ID, name, taxID, headquartersAddress, website).
- Admin can create and query organizations via OData API.

---

### Story 1.2: Multi-School Branch Setup

**As an Educational Trust Admin,**  
I want to add multiple school branches across different cities under our parent organization,  
So that each branch can manage its own local operations independently.

**Acceptance Criteria:**

- Schools entity linked to Organizations via 1-to-Many association.
- Attributes: ID, schoolName, branchCode, city, address, contactEmail.
- Support creating new schools in distinct cities attached to the organization.

---

### Story 1.3: School Profile Metadata

**As a Branch Admin,**  
I want to maintain detailed metadata for my school branch,  
So that accreditation and operational details are centrally stored.

**Acceptance Criteria:**

- Metadata fields: accreditationID, contactPhone, operationalStatus, establishedYear.
- Editable via CAP service endpoints.

---

## Phase 2: Dynamic Academic Configuration

### Story 2.1: Academic Year Configuration

**As a School Branch Admin,**  
I want to define academic years (e.g., 2024–2025) with specific start and end dates,  
So that operations can be tracked per academic period.

**Acceptance Criteria:**

- AcademicYears entity scoped to a School.
- Fields: ID, yearLabel, startDate, endDate, isCurrentSession.
- Only one session per school flagged as current.

---

### Story 2.2: Dynamic Grade & Section Setup

**As a School Branch Admin,**  
I want to configure active grades and sections for a specific academic year,  
So that I can scale up or down without affecting historic data.

**Acceptance Criteria:**

- Grades entity mapped to AcademicYears.
- Sections entity as a composition of Grades.
- Historical setups remain untouched.

---

### Story 2.3: Academic Calendar Events

**As a Branch Admin,**  
I want to define key academic events (holidays, exams, parent meetings),  
So that the school calendar is visible to staff and students.

**Acceptance Criteria:**

- CalendarEvents entity linked to AcademicYear.
- Attributes: eventName, eventType, startDate, endDate.

---

## Phase 3: Stakeholders & Roster Management

### Story 3.1: Teacher Profile & Qualification Tracking

**As a School HR Admin,**  
I want to onboard teachers and record their profile and subject specializations,  
So that they can be assigned to classes and subjects.

**Acceptance Criteria:**

- Teachers entity with personal details, employeeID, email, qualifications.
- Linked to a primary School branch.

---

### Story 3.2: Student Enrollment & Academic Assignment

**As a School Registrar,**  
I want to enroll new students and assign them to a Grade and Section,  
So that records reflect their current placement.

**Acceptance Criteria:**

- Students entity with demographics and guardian contacts.
- Enrollments entity linking Student → AcademicYear → Grade → Section.
- Enrollment history preserved across years.

---

### Story 3.3: Role-Based Access Control

**As a System Admin,**  
I want to assign roles (Admin, Teacher, Student, Accountant),  
So that users only access relevant modules.

**Acceptance Criteria:**

- Roles entity with predefined roles.
- CAP service enforces role-based authorization.

---

## Phase 4: Academics & Operations

### Story 4.1: Subject Mapping & Teacher Allocation

**As an Academic Coordinator,**  
I want to define subjects for each grade and assign teachers,  
So that course distribution is established.

**Acceptance Criteria:**

- Subjects entity linked to Grades.
- SubjectAssignments entity linking Teacher, Subject, Section.

---

### Story 4.2: Daily Student Attendance

**As a Class Teacher,**  
I want to mark daily attendance for students in my section,  
So that participation is tracked.

**Acceptance Criteria:**

- Attendance entity with date, enrollment_ID, status (Present, Absent, Late, Excused).
- Prevent duplicate entries for same student/date.

---

### Story 4.3: Timetable Management

**As a Branch Admin,**  
I want to configure daily timetables,  
So that classes are scheduled efficiently.

**Acceptance Criteria:**

- Timetable entity mapping timeSlot → Subject → Teacher → Section.
- CAP service validates overlapping schedules.

---

## Phase 5: Assessment & Financial Operations

### Story 5.1: Gradebook & Examination Management

**As a Subject Teacher,**  
I want to enter exam scores and calculate grades,  
So that performance reports can be generated.

**Acceptance Criteria:**

- Exams entity under AcademicYears and Subjects.
- Gradesheet entity mapping Student → Exam → score → computed grade.

---

### Story 5.2: Fee Structure & Invoicing

**As a School Accountant,**  
I want to generate invoices and record payments,  
So that receivables are tracked.

**Acceptance Criteria:**

- FeeStructures entity defines costs per Grade/Year.
- Invoices auto-populate for enrolled students.
- Payments composition logs partial/full settlements.

---

### Story 5.3: Overdue Fee Tracking

**As a School Accountant,**  
I want to track overdue invoices,  
So that reminders can be sent.

**Acceptance Criteria:**

- Overdue flag on Invoices.
- CAP service generates overdue report per student.

---

## Phase 6: Advanced Features (Future)

- Parent Portal with notifications.
- Student performance dashboards.
- Mobile app integration.
- Payment gateway integration.
- AI-driven analytics for attendance and grades.
