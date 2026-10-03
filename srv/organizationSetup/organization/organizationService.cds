namespace cdx.org.service;

using cdx.org as OrganizationSetupModel from '../../../db/organizationSetup';

service OrganizationService @(requires: 'authenticated-user') {
    // annotate AcademicYear with  @odata.draft.enabled  @Common.SemanticKey: [];
    annotate OrganizationSetupModel.Organization with @odata.draft.enabled;

    entity Organization as projection on OrganizationSetupModel.Organization;
}
