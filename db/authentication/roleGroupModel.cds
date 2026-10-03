namespace cdx.auth;

using {
    cuid,
    managed
} from '@sap/cds/common';
using {cdx.auth.Role} from './roleModel';

entity RoleGroup : cuid, managed {
    roleGroupName : String(40) @assert.unique;
    description   : String(255);
    roles         : Association to many Role
                        on roles.roleGroup = $self;
}
