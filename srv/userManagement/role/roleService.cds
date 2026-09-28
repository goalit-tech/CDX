namespace siemens.cdx.usr.service;

using siemens.cdx.usr as UserManagementModel from '../../../db/userManagement';

service RoleService {
    annotate UserManagementModel.Role with @odata.draft.enabled;

    entity Role as projection on UserManagementModel.Role;
}
