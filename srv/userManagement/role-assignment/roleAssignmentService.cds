namespace cdx.usr.service;

using cdx.usr as UserManagementModel from '../../../db/userManagement';

service RoleAssignmentService {
    annotate UserManagementModel.RoleAssignment with @odata.draft.enabled;

    entity RoleAssignment as projection on UserManagementModel.RoleAssignment;
}
