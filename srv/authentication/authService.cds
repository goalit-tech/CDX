namespace cdx.auth.service;

service AuthService @(requires: 'authenticated-user') {
    function whoami() returns {
        id        : String;
        firstName : String(40);
        lastName  : String(40);
        fullName  : String(80);
        email     : String(80);
        roles     : array of String;
        
    };
}
