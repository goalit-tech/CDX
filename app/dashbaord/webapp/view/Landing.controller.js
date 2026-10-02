sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/ui/model/resource/ResourceModel",
    "sap/m/URLHelper"
], function (Controller, JSONModel, ResourceModel, URLHelper) {
    "use strict";

    // side-nav/tile keys that already have a dedicated app
    var FUNCTIONAL_TARGETS = {
        organization: "index.html"
    };

    var NAV_TITLES = {
        "academic-year": "navAcademicYear",
        "calendar-event": "navCalendarEvent",
        "campus": "navCampus",
        "grade": "navGrade",
        "section": "navSection",
        "employee": "navEmployee",
        "student": "navStudent",
        "enrollment": "navEnrollment",
        "role": "navRole",
        "role-assignment": "navRoleAssignment"
    };

    return Controller.extend("cdx.ui.dashbaord.view.Landing", {
        onInit: function () {
            var oResourceModel = new ResourceModel({
                bundleUrl: sap.ui.require.toUrl("cdx/ui/dashbaord/i18n/i18n.properties")
            });
            this.getView().setModel(oResourceModel, "i18n");

            var oResourceBundle = oResourceModel.getResourceBundle();

            this.getView().setModel(new JSONModel({
                view: "home",
                welcomeText: oResourceBundle.getText("landingWelcome"),
                comingSoonTitle: ""
            }), "app");

            // selection lives on the NavigationList, not the individual item
            this.byId("mainNavList").setSelectedKey("home");
        },

        onToggleSideNav: function () {
            var oToolPage = this.byId("toolPage");
            oToolPage.setSideExpanded(!oToolPage.getSideExpanded());
        },

        onItemSelect: function (oEvent) {
            var sKey = oEvent.getParameter("item").getKey();
            this._navigateTo(sKey);
        },

        onTilePress: function (oEvent) {
            var sKey = oEvent.getSource().data("target");
            this.byId("mainNavList").setSelectedKey(sKey);
            this._navigateTo(sKey);
        },

        _navigateTo: function (sKey) {
            if (sKey === "home") {
                this.getView().getModel("app").setProperty("/view", "home");
                return;
            }
            if (FUNCTIONAL_TARGETS[sKey]) {
                URLHelper.redirect(FUNCTIONAL_TARGETS[sKey]);
                return;
            }

            var oResourceBundle = this.getView().getModel("i18n").getResourceBundle();
            var sTitleKey = NAV_TITLES[sKey];
            var oAppModel = this.getView().getModel("app");
            oAppModel.setProperty("/comingSoonTitle", sTitleKey ? oResourceBundle.getText(sTitleKey) : "");
            oAppModel.setProperty("/view", sKey);
        }
    });
});
