namespace cdx.org.service;

using cdx.org as OrganizationSetupModel from '../../../db/organizationSetup';

service CampusService @(requires: 'authenticated-user') {
    // annotate AcademicYear with  @odata.draft.enabled  @Common.SemanticKey: [];
    annotate OrganizationSetupModel.Campus with @odata.draft.enabled;

    entity Campus as projection on OrganizationSetupModel.Campus;
}
