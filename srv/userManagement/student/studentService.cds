namespace cdx.usr.service;

using cdx.usr as UserManagementModel from '../../../db/userManagement';

service StudentService @(requires: 'authenticated-user') {
    annotate UserManagementModel.Student with @odata.draft.enabled;

    entity Students as projection on UserManagementModel.Student;
}
