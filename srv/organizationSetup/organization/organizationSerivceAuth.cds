using cdx.org.service.OrganizationService as orgService from './organizationService';

annotate orgService.Organization with @(requires: ['Admin']);
