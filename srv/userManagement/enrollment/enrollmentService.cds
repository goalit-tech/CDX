namespace cdx.usr.service;

using cdx.usr as UserManagementModel from '../../../db/userManagement';

service EnrollmentService {
    // annotate UserManagementModel.Enrollment with @odata.draft.enabled;

    entity Enrollment as projection on UserManagementModel.Enrollment;
}
