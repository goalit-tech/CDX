namespace cdx.usr.service;

using { cdx.auth.service.UserInfo } from '../authentication/authService';
using { cdx.auth.Role, cdx.auth.RoleGroup } from '../../db/authentication';

service UserAdministrationService @(requires: 'admin') {
    action createUser(
        username: String(10),
        password: String(255),
        firstName: String(40),
        lastName: String(40),
        email: String(255),
        roleGroupName: String(40)
    ) returns UserInfo;
}