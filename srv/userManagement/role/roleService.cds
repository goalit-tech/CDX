namespace cdx.usr.service;

using cdx.usr as UserManagementModel from '../../../db/userManagement';

service RoleService @(requires: 'authenticated-user') {
    annotate UserManagementModel.Role with @odata.draft.enabled;

    entity Role as projection on UserManagementModel.Role;
}
