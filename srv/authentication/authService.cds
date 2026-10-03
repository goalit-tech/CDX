namespace cdx.auth.service;

using { cdx.auth.Role, cdx.auth.RoleGroup } from '../../db/authentication';

type UserInfo {
    id        : String(10);
    firstName : String(40);
    lastName  : String(40);
    fullName  : String(122);
    email     : String(255);
    roles     : array of String;
}

type LoginResult {
    accessToken : LargeString;
    tokenType   : String(10);
    expiresIn   : Integer;
    user        : UserInfo;
}

service AuthenticationService @(requires: 'any') {
    action login(username: String, password: String) returns LoginResult;
    action bootstrapAdmin(
        username: String,
        password: String,
        firstName: String(40),
        lastName: String(40),
        email: String(255)
    ) returns UserInfo;
}
