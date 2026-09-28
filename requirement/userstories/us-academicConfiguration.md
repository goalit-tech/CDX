# Phase 2: Dynamic Academic Configuration

---

### Story 2.1: Academic Year Configuration

**As a School Branch Admin,**  
I want to define academic years (e.g., 2024–2025) with specific start and end dates,  
So that operations can be tracked per academic period.

**Acceptance Criteria:**

- AcademicYears entity scoped to a School.
- Fields: yearLabel, startDate, endDate, isCurrentSession.
- Only one session per school flagged as current.
- Audit handled via `managed`.
- Unique IDs via `cuid`.

**Mandatory Fields:**

- school – Association to parent School.
- yearLabel – Academic year label (e.g., “2024–2025”).
- startDate – Start date of the academic year.
- endDate – End date of the academic year.

**Optional Fields:**

- isCurrentSession – Boolean flag (only one per school).
- description – Notes about the academic year.

---

### Story 2.2: Dynamic Grade & Section Setup

**As a School Branch Admin,**  
I want to configure active grades and sections for a specific academic year,  
So that I can scale up or down without affecting historic data.

**Acceptance Criteria:**

- Grades entity mapped to AcademicYears.
- Sections entity as a composition of Grades.
- Historical setups remain untouched.
- Audit handled via `managed`.
- Unique IDs via `cuid`.

**Mandatory Fields (Grades):**

- academicYear – Association to AcademicYears.
- gradeName – Name of grade/class (e.g., “Grade 1”, “B.Sc. First Year”).

**Optional Fields (Grades):**

- gradeCode – Short code (e.g., “G1”, “FYBSC”).
- description – Notes about grade.

**Mandatory Fields (Sections):**

- grade – Association to parent Grade.
- sectionName – Section identifier (e.g., “A”, “B”).

**Optional Fields (Sections):**

- sectionCode – Short code (e.g., “SEC-A”).
- capacity – Max students allowed.
- description – Notes about section.

---

### Story 2.3: Academic Calendar Events

**As a Branch Admin,**  
I want to define key academic events (holidays, exams, parent meetings),  
So that the school calendar is visible to staff and students.

**Acceptance Criteria:**

- CalendarEvents entity linked to AcademicYear.
- Attributes: eventName, eventType, startDate, endDate.
- Audit handled via `managed`.
- Unique IDs via `cuid`.

**Mandatory Fields:**

- academicYear – Association to AcademicYears.
- eventName – Name of the event (e.g., “Annual Day”).
- eventType – Type of event (Holiday, Exam, Meeting, Orientation).
- startDate – Start date of event.
- endDate – End date of event.

**Optional Fields:**

- description – Notes about the event.
- location – Venue (e.g., “Main Auditorium”).

---

## 📖 Plain Language Examples

### Example 1: Single School Academic Setup

- **School:** Sunrise High School
  - Academic Year: “2024–2025” (start: 01‑Jun‑2024, end: 31‑Mar‑2025, isCurrentSession: true)
  - Grades: “Grade 1”, “Grade 2”
  - Sections: Grade 1 → Section A, Section B
  - Calendar Events: “Independence Day Holiday” (15‑Aug‑2024), “Parent Teacher Meeting” (10‑Sep‑2024).

👉 This setup allows Sunrise High School to run one academic year, with grades and sections defined, and events visible to staff/students.

---

### Example 2: Trust with Multiple Institutions

- **Organization:** Bright Future Trust
  - **School Branch 1:** Bright Future Kindergarten
    - Academic Year: “2024–2025”
    - Grades: Nursery, LKG, UKG
    - Sections: Nursery → Section A
    - Events: “Children’s Day Celebration” (14‑Nov‑2024).
  - **School Branch 2:** Bright Future College
    - Academic Year: “2024–2025”
    - Grades: B.Sc. First Year, B.Sc. Second Year
    - Sections: B.Sc. First Year → Section A, Section B
    - Events: “Midterm Exams” (01‑Dec‑2024 to 15‑Dec‑2024).

👉 The trust manages multiple institutions, each with its own academic year, grades, sections, and calendar events — all linked back to the parent Organization.
