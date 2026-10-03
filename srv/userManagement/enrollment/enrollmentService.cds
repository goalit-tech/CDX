namespace cdx.usr.service;

using cdx.usr as UserManagementModel from '../../../db/userManagement';

service EnrollmentService @(requires: 'authenticated-user') {
    // annotate UserManagementModel.Enrollment with @odata.draft.enabled;

    entity Enrollment as projection on UserManagementModel.Enrollment;
}
