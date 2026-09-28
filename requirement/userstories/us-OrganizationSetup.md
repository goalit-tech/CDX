# Phase 1: Core Organization & Branch Infrastructure

---

## Story 1.1: Organization Setup

### Story Details

**As an Educational Trust Admin,**  
I want to register our main Organization entity in the system,  
So that I can manage all affiliated educational institutions under one umbrella.

**Acceptance Criteria:**

- Organizations entity with attributes capturing legal, operational, and contact details.
- Admin can create and query organizations via OData API.
- Each organization can have one or more addresses via composition.
- Audit fields are auto-managed using `managed`.
- Unique identifiers are generated using `cuid`.

### Mandatory Fields

- orgName – Official name of the organization/trust.
- orgCode – Unique code.
- orgCategory – Type of organization (Kindergarten, School, College, University, Coaching, Training).
- Addresses: addressLine1, city, country.

### Optional Fields

- scopeOfEducation – Levels covered (K–12, UG, PG, etc.).
- affiliationBody – Board/University affiliation.
- taxID, accreditationID, registrationDate, establishedYear, orgType, operationalStatus, logoURL.
- Addresses: addressLine2, stateProvince, postalCode, contactPhone, contactEmail, geoCoordinates, isPrimary, addressType.

---

## Story 1.2: Multi-School Branch Setup

### Story Details

**As an Educational Trust Admin,**  
I want to add multiple school branches across different cities under our parent organization,  
So that each branch can manage its own local operations independently.

**Acceptance Criteria:**

- Schools entity linked to Organizations via 1-to-Many association.
- Attributes include schoolName, branchCode, city, address, contactEmail.
- Support creating new schools in distinct cities attached to the organization.

### Mandatory Fields

- org – Association to parent Organization.
- schoolName – Branch name.
- branchCode – Unique branch code.
- schoolCategory – Type of branch (Kindergarten, Primary, Secondary, College, Coaching).
- Addresses: addressLine1, city, country.

### Optional Fields

- mediumOfInstruction – Language of instruction.
- studentCapacity – Max student capacity.
- accreditationID, schoolType, establishedYear, operationalStatus, logoURL, principalName, adminEmail, adminPhone.
- Addresses: addressLine2, stateProvince, postalCode, contactPhone, contactEmail, geoCoordinates, isPrimary, addressType.

---

## Story 1.3: School Profile Metadata

### Story Details

**As a Branch Admin,**  
I want to maintain detailed metadata for my school branch,  
So that accreditation and operational details are centrally stored.

**Acceptance Criteria:**

- Metadata fields: accreditationID, contactPhone, operationalStatus, establishedYear.
- Editable via CAP service endpoints.

### Mandatory Fields

- Already covered under School entity (schoolName, branchCode, org association, schoolCategory, address).

### Optional Fields

- accreditationID – Accreditation/certification ID.
- contactPhone – Admin office phone.
- operationalStatus – Current status (Active, Inactive, Suspended).
- establishedYear – Year branch was established.
- mediumOfInstruction, studentCapacity.

---

## 📖 Plain Language Examples

### Example 1: Single Organization with One Branch

- **Organization:** "Sunrise Educational Trust"
  - orgCode: "SET001"
  - orgCategory: "Trust"
  - Address: "123 MG Road, Bengaluru, India"
- **School Branch:** "Sunrise High School"
  - branchCode: "SHS001"
  - schoolCategory: "Secondary"
  - Address: "45 Residency Layout, Bengaluru, India"
  - principalName: "Dr. Anita Rao"

👉 In this case, the trust has one school branch. The Organization record holds the trust details, and the School record holds the branch details.

---

### Example 2: Trust with Multiple Types of Institutions

- **Organization:** "Bright Future Trust"
  - orgCode: "BFT001"
  - orgCategory: "Trust"
  - Address: "HQ – 10 Park Street, Kolkata, India"
- **School Branch 1:** "Bright Future Kindergarten"
  - branchCode: "BFK001"
  - schoolCategory: "Kindergarten"
  - Address: "Sector 5, Salt Lake, Kolkata, India"
- **School Branch 2:** "Bright Future College"
  - branchCode: "BFC001"
  - schoolCategory: "College"
  - Address: "College Road, Howrah, India"
- **School Branch 3:** "Bright Future Coaching Center"
  - branchCode: "BFCC001"
  - schoolCategory: "Coaching"
  - Address: "Main Bazaar, Durgapur, India"

👉 In this case, the trust manages **three different types of institutions** (Kindergarten, College, Coaching). All are linked to the same parent Organization record, but each branch has its own category, address, and metadata.
