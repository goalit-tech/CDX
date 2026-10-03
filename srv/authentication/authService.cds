namespace cdx.auth.service;

type UserInfo {
    id        : String(10);
    firstName : String(40);
    lastName  : String(40);
    fullName  : String(122);
    email     : String(255);
}

type LoginResult {
    accessToken : LargeString;
    tokenType   : String(10);
    expiresIn   : Integer;
    user        : UserInfo;
}

service AuthenticationService @(requires: 'any') {
    action login(username: String, password: String) returns LoginResult;
}
