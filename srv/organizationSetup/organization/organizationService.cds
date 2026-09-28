namespace siemens.cdx.org.service;

using siemens.cdx.org as OrganizationSetupModel from '../../../db/organizationSetup';

service OrganizationService {
    // annotate AcademicYear with  @odata.draft.enabled  @Common.SemanticKey: [];
    annotate OrganizationSetupModel.Organization with @odata.draft.enabled;

    entity Organization as projection on OrganizationSetupModel.Organization;
}
