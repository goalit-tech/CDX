namespace siemens.cdx.usr.service;

using siemens.cdx.usr as UserManagementModel from '../../../db/userManagement';

service StudentService {
    annotate UserManagementModel.Student with @odata.draft.enabled;

    entity Students as projection on UserManagementModel.Student;
}
