sap.ui.define([
    "sap/fe/core/PageController"
], function (PageController) {
    "use strict";

    return PageController.extend("cdx.ui.dashbaord.view.AcademicYear", {
        onNavBack: function () {
            this.getAppComponent().getRouter().navTo("OrganizationMain", {}, true);
        }
    });
});