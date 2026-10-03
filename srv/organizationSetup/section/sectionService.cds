namespace cdx.org.service;

using cdx.org as OrganizationSetupModel from '../../../db/organizationSetup';

service SectionService @(requires: 'authenticated-user') {
    // annotate AcademicYear with  @odata.draft.enabled  @Common.SemanticKey: [];
    annotate OrganizationSetupModel.Section with @odata.draft.enabled;

    entity Section as projection on OrganizationSetupModel.Section;
}
