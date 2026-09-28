# Phase 3: Stakeholders & Roster Management

---

### Story 3.1: Employee Directory & Qualification Tracking

**As a School HR Admin,**  
I want to onboard all employees (teachers, principals, staff) and record their profile and role,  
So that they can be assigned to classes, subjects, or administrative duties.

**Acceptance Criteria:**

- Employees entity with personal details, employeeID, email, role, qualifications.
- Linked to a primary School branch (and optionally Organization).
- Audit handled via `managed`.
- Unique IDs via `cuid`.

**Mandatory Fields:**

- school – Association to parent School.
- employeeName – Full name.
- employeeID – Unique employee identifier.
- email – Contact email.
- employeeRole – Role (Teacher, Principal, Accountant, Librarian, HR, Admin, Support Staff).

**Optional Fields:**

- phone, qualifications, specialization, hireDate, status (Active/Inactive), address (composition).

---

### Story 3.2: Student Enrollment & Academic Assignment

**As a School Registrar,**  
I want to enroll new students and assign them to a Grade and Section,  
So that records reflect their current placement.

**Acceptance Criteria:**

- Students entity with demographics and guardian contacts.
- Enrollments entity linking Student → AcademicYear → Grade → Section.
- Enrollment history preserved across years.

**Mandatory Fields (Students):**

- school – Association to parent School.
- studentName – Full name.
- dateOfBirth – Date of birth.
- guardianName – Primary guardian name.

**Optional Fields (Students):**

- gender, email, phone, address (composition), admissionDate, status (Active/Inactive).

**Mandatory Fields (Enrollments):**

- student – Association to Students.
- academicYear – Association to AcademicYears.
- grade – Association to Grades.
- section – Association to Sections.

**Optional Fields (Enrollments):**

- enrollmentDate, rollNumber, status (Active, Transferred, Graduated).

---

### Story 3.3: Role-Based Access Control

**As a System Admin,**  
I want to assign roles (Admin, Teacher, Student, Accountant, Principal, Librarian),  
So that users only access relevant modules.

**Acceptance Criteria:**

- Roles entity with predefined roles.
- CAP service enforces role-based authorization.

**Mandatory Fields:**

- userID – Reference to Employee or Student.
- roleName – Role assigned (Admin, Teacher, Student, Accountant, Principal, Librarian, HR).

**Optional Fields:**

- description – Notes about role.
- status – Active/Inactive.

---

## 📖 Plain Language Examples

### Example 1: Single School Setup

- **School:** Sunrise High School
  - Employee: "Ravi Kumar", employeeID: T001, role: Teacher, specialization: Mathematics.
  - Employee: "Anita Rao", employeeID: P001, role: Principal.
  - Student: "Ananya Sharma", DOB: 12‑Mar‑2012, guardian: "Mr. Sharma".
  - Enrollment: Ananya → AcademicYear 2024–2025 → Grade 7 → Section A.
  - Roles: Ravi → Teacher role, Anita → Admin role, Ananya → Student role.

---

### Example 2: Trust with Multiple Institutions

- **Organization:** Bright Future Trust
  - **School Branch 1:** Bright Future Kindergarten
    - Employee: "Meena Joshi", role: Teacher (Early Childhood).
    - Employee: "Rajesh Singh", role: Accountant.
    - Student: "Rohan Gupta", DOB: 05‑Jan‑2021, guardian: "Mrs. Gupta".
    - Enrollment: Rohan → AcademicYear 2024–2025 → Nursery → Section A.
    - Roles: Meena → Teacher role, Rajesh → Accountant role, Rohan → Student role.
  - **School Branch 2:** Bright Future College
    - Employee: "Dr. Arvind Rao", role: Teacher (Physics).
    - Employee: "Sonal Mehta", role: Librarian.
    - Student: "Priya Nair", DOB: 10‑Oct‑2005, guardian: "Mr. Nair".
    - Enrollment: Priya → AcademicYear 2024–2025 → B.Sc. First Year → Section B.
    - Roles: Arvind → Teacher role, Sonal → Librarian role, Priya → Student role.
