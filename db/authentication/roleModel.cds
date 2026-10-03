namespace cdx.auth;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {cdx.auth.RoleGroup} from './roleGroupModel';

@assert.unique.useridemail: [
    userId,
    email
]
entity Role : cuid, managed {
    userId     : String(10);
    firstName  : String(40);
    middleName : String(40);
    lastName   : String(40);
    fullName   : String(122) = firstName || ' ' || middleName || ' ' || lastName stored;
    email      : String(255);
    isActive   : Boolean default true;
    password   : String(255);
    roleGroup  : Association to RoleGroup;
}
