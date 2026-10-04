# CDX (Campus Digital Experience) – School Management System

**Platform:** SAP Cloud Application Programming Model (CAP)  
**Schema Prefix:** `cd_`  
**Project Key:** `cdesk`

---

## 1. Project Overview

The objective is to design and develop an **enterprise-grade School Management System** using SAP CAP. The system will support:

- Multi-school organizational structures
- Flexible academic session management
- Dynamic grade/class configurations
- Student and teacher lifecycle management
- Course delivery and timetable scheduling
- Attendance tracking and reporting
- Assessment, grading, and report card generation
- Fee and finance management

The system will be built incrementally, starting with **core administrative foundations** and evolving into **complex operational capabilities**.

---

## 2. Functional Requirements

### Module 1: Organization & School Setup

- **REQ-ORG-01 (Multi-Tenancy / Organization Level):**  
  Define an Organization entity representing an educational trust/group.
- **REQ-ORG-02 (School Branch Setup):**  
  Create multiple school branches under a single organization, supporting different or same cities.
- **REQ-ORG-03 (School Profile):**  
  Store metadata for each branch (address, contact info, accreditation IDs, operational settings).

---

### Module 2: Academic Year & Grade Configuration

- **REQ-ACA-01 (Academic Session Management):**  
  Define flexible Academic Years (e.g., 2024–2025) per branch with custom start/end dates.
- **REQ-ACA-02 (Dynamic Grade/Class Setup):**  
  Configure Grades (Grade 1, Grade 2, etc.) per academic year. Support expansion/reduction without altering historic data.
- **REQ-ACA-03 (Sections Management):**  
  Assign Sections (A, B, etc.) under each Grade for a given academic year.

---

### Module 3: User & Stakeholder Management

- **REQ-USR-01 (Student Profile Management):**  
  Capture student profiles (personal details, emergency contacts, admission history, assigned Grade/Section).
- **REQ-USR-02 (Teacher & Staff Management):**  
  Maintain staff records (qualifications, employment status, subject specialization).
- **REQ-USR-03 (Class & Subject Allocation):**  
  Map teachers as Class Teachers for sections or Subject Teachers for specific subjects.

---

### Module 4: Curriculum & Course Delivery

- **REQ-CUR-01 (Subject Catalog):**  
  Centralized master list of subjects mapped to grades per academic session.
- **REQ-CUR-02 (Timetable Management):**  
  Daily schedule matrices mapping time slots, subjects, classrooms, and teachers.

---

### Module 5: Attendance & Student Operations

- **REQ-ATT-01 (Daily Attendance Tracking):**  
  Teachers record daily or period-level attendance (Present, Absent, Late, Excused).
- **REQ-ATT-02 (Attendance Reporting):**  
  Generate aggregated attendance statistics per student, section, and school.

---

### Module 6: Assessment & Grading

- **REQ-EXM-01 (Exam & Evaluation Setup):**  
  Define terms, evaluation types (Quizzes, Midterms, Finals), weightages, and grading scales.
- **REQ-EXM-02 (Marks Entry & Report Cards):**  
  Teachers input marks, auto-calculate GPA/grades, and generate digital report cards.

---

### Module 7: Fee & Finance Management

- **REQ-FIN-01 (Fee Structure Definition):**  
  Configure customizable fee structures based on Grade, Academic Year, and Fee Categories (Tuition, Transport, Lab).
- **REQ-FIN-02 (Student Billing & Payment Collection):**  
  Generate invoices, record payments (Partial/Full), and track overdue balances.

---

## 3. Non-Functional & Technical Requirements

### Data Model

- Built using `.cds` files with SAP Core Data Services (Entities, Associations, Compositions).
- Schema prefix: `cd_` (e.g., `cd_students`, `cd_teachers`).

### Service Layer

- OData v4 REST services exposed via `@sap/cds` endpoints.
- Custom handlers for business logic.

### Extensibility

- SAP CAP annotations for dynamic UI draft handling.
- SAP Fiori Elements for UI generation.

### Data Isolation & Integrity

- Foreign key integrity enforced via CDS relationships (`Association to`, `Composition of`).
- Multi-tenancy isolation for organizations and branches.

---

## 4. Incremental Development Roadmap

1. **Phase 1 (OrganizationSetup / ORG):** Core setup (Organization, School, Academic Year, Grades).
2. **Phase 2 (UserManagement / USR):** User & Stakeholder Management (Students, Teachers, Staff).
3. **Phase 3 (CurriculumTimetable / CUR):** Curriculum & Timetable.
4. **Phase 4 (AttendanceTracking / ATT):** Attendance & Reporting.
5. **Phase 5 (AssessmentGrading / EXM):** Assessment & Grading.
6. **Phase 6 (FinanceManagement / FIN):** Fee & Finance Management.
7. **Phase 7 (AdvancedAnalytics / ANL):** Advanced analytics, dashboards, and integrations.

---

## 5. Naming Conventions

- **Project Key:** `cdesk`
- **Schema Prefix:** `cd_`
- **Table Examples:**
  - `cd_students`
  - `cd_teachers`
  - `cd_grades`
  - `cd_attendance`
  - `cd_fees`

---

## 6. Future Enhancements

- Parent portal with notifications.
- Mobile app integration.
- AI-driven analytics for performance tracking.
- Integration with external payment gateways.
