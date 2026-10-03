namespace cdx.org.service;

using cdx.org as OrganizationSetupModel from '../../../db/organizationSetup';

service CalendarEventService @(requires: 'authenticated-user') {
    // annotate AcademicYear with  @odata.draft.enabled  @Common.SemanticKey: [];
    annotate OrganizationSetupModel.CalendarEvent with @odata.draft.enabled;

    entity CalendarEvent as projection on OrganizationSetupModel.CalendarEvent;
}
