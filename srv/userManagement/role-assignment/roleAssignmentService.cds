namespace cdx.usr.service;

using cdx.usr as UserManagementModel from '../../../db/userManagement';

service RoleAssignmentService @(requires: 'authenticated-user') {
    annotate UserManagementModel.RoleAssignment with @odata.draft.enabled;

    entity RoleAssignment as projection on UserManagementModel.RoleAssignment;
}
