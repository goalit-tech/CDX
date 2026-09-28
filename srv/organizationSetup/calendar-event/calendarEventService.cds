namespace siemens.cdx.org.service;

using siemens.cdx.org as OrganizationSetupModel from '../../../db/organizationSetup';

service CalendarEventService {
    // annotate AcademicYear with  @odata.draft.enabled  @Common.SemanticKey: [];
    annotate OrganizationSetupModel.CalendarEvent with @odata.draft.enabled;

    entity CalendarEvent as projection on OrganizationSetupModel.CalendarEvent;
}
