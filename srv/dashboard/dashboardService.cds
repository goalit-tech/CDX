namespace cdx.dsb.service;

using {cdx.org as orgMModel} from '../../db/organizationSetup';
using {cdx.usr as userModel} from '../../db/userManagement';

@cds.autoexpose: false
service DashboardService {
    @odata.draft.enabled: false
    entity Organizations as projection on orgMModel.Organization;

    entity AcademicYears as projection on orgMModel.AcademicYear;

    @odata.draft.enabled: false
    entity Campus        as projection on orgMModel.Campus;

    @odata.draft.enabled: false
    entity Employees     as projection on userModel.Employee;

    @odata.draft.enabled: false
    entity Students      as projection on userModel.Student;

    entity Roles         as projection on userModel.Role;

    entity EmployeeRoles as projection on userModel.EmployeeRole;

}
