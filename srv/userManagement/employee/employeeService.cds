namespace cdx.usr.service;

using cdx.usr as UserManagementModel from '../../../db/userManagement';

service EmployeeService @(requires: 'authenticated-user') {
    annotate UserManagementModel.Employee with @odata.draft.enabled;

    entity Employee as projection on UserManagementModel.Employee;
}
