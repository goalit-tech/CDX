sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"cdx/ui/dashbaord/test/integration/pages/OrganizationMain"
], function (JourneyRunner, OrganizationMain) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('cdx/ui/dashbaord') + '/test/flp.html#app-preview',
        pages: {
			onTheOrganizationMain: OrganizationMain
        },
        async: true
    });

    return runner;
});

