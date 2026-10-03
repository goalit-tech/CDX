namespace cdx.org.service;

using cdx.org as OrganizationSetupModel from '../../../db/organizationSetup';

service GradeService @(requires: 'authenticated-user') {
    // annotate AcademicYear with  @odata.draft.enabled  @Common.SemanticKey: [];
    // annotate OrganizationSetupModel.Grade with @odata.draft.enabled;

    entity Grade as projection on OrganizationSetupModel.Grade;
}
