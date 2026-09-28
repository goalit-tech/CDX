namespace siemens.cdx.org.service;

using siemens.cdx.org as OrganizationSetupModel from '../../../db/organizationSetup';

service GradeService {
    // annotate AcademicYear with  @odata.draft.enabled  @Common.SemanticKey: [];
    // annotate OrganizationSetupModel.Grade with @odata.draft.enabled;

    entity Grade as projection on OrganizationSetupModel.Grade;
}
