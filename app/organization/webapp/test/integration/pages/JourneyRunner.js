sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"cdx/ui/org/organization/test/integration/pages/OrganizationList",
	"cdx/ui/org/organization/test/integration/pages/OrganizationObjectPage"
], function (JourneyRunner, OrganizationList, OrganizationObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('cdx/ui/org/organization') + '/test/flp.html#app-preview',
        pages: {
			onTheOrganizationList: OrganizationList,
			onTheOrganizationObjectPage: OrganizationObjectPage
        },
        async: true
    });

    return runner;
});

