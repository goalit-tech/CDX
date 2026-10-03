using {cdx.org as orgModel} from '../../db/organizationSetup';
using {cdx.usr as usrModel} from '../../db/userManagement';

service AdminService @(requires: 'authenticated-user') {
    entity Organization   as projection on orgModel.Organization;
    entity Campus         as projection on orgModel.Campus;
    entity AcademicYear   as projection on orgModel.AcademicYear;
    entity Grade          as projection on orgModel.Grade;
    entity Section        as projection on orgModel.Section;
    entity CalendarEvent  as projection on orgModel.CalendarEvent;
    entity Employee       as projection on usrModel.Employee;
    entity Student        as projection on usrModel.Student;
    entity Enrollment     as projection on usrModel.Enrollment;
    entity Role           as projection on usrModel.Role;
    entity RoleAssignment as projection on usrModel.RoleAssignment;
}
