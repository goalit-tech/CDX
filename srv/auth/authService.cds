namespace siemens.cdx.auth.service;

service AuthService @(requires: 'authenticated-user') {
    function whoami() returns {
        id    : String;
        roles : array of String;
    };
}
