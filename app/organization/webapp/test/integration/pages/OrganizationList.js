sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'cdx.ui.org.organization',
            componentId: 'OrganizationList',
            contextPath: '/Organization'
        },
        CustomPageDefinitions
    );
});