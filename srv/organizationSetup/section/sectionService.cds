namespace siemens.cdx.org.service;

using siemens.cdx.org as OrganizationSetupModel from '../../../db/organizationSetup';

service SectionService {
    // annotate AcademicYear with  @odata.draft.enabled  @Common.SemanticKey: [];
    annotate OrganizationSetupModel.Section with @odata.draft.enabled;

    entity Section as projection on OrganizationSetupModel.Section;
}
