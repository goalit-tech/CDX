namespace cdx.usr.service;

using cdx.usr as UserManagementModel from '../../../db/userManagement';

service EmployeeService {
    annotate UserManagementModel.Employee with @odata.draft.enabled;

    entity Employee as projection on UserManagementModel.Employee;
}
