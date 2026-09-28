namespace siemens.cdx.org.service;

using siemens.cdx.org as OrganizationSetupModel from '../../../db/organizationSetup';

service AcademicYearService {
    // annotate AcademicYear with  @odata.draft.enabled  @Common.SemanticKey: [];
    annotate OrganizationSetupModel.AcademicYear with @odata.draft.enabled;

    entity AcademicYear as projection on OrganizationSetupModel.AcademicYear;
}
