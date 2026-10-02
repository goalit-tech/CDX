sap.ui.define([
    "sap/fe/core/PageController",
    "sap/ui/model/json/JSONModel",
    "sap/ui/model/resource/ResourceModel"
], function (PageController, JSONModel, ResourceModel) {
    "use strict";

    var ROUTE_TITLES = {
        Organizations: "navOrganizations",
        CalendarEvents: "navCalendarEvent",
        Campus: "navCampus",
        Grade: "navGrade",
        Section: "navSection",
        Employees: "navEmployee",
        Students: "navStudent",
        Enrollment: "navEnrollment",
        Roles: "navRole",
        RoleAssignments: "navRoleAssignment"
    };

    return PageController.extend("cdx.ui.dashbaord.view.Module", {
        onInit: function () {
            PageController.prototype.onInit.apply(this, arguments);
            this.getView().setModel(new ResourceModel({
                bundleUrl: sap.ui.require.toUrl("cdx/ui/dashbaord/i18n/i18n.properties")
            }), "i18n");
            this.getView().setModel(new JSONModel({ title: "" }), "page");
            this._oRouter = this.getAppComponent().getRouter();
            this._oRouter.attachRouteMatched(this._onRouteMatched, this);
            var oRoute = this._oRouter.getRouteInfoByHash(this._oRouter.getHashChanger().getHash());
            if (oRoute) {
                this._setTitle(oRoute.name);
            }
        },

        _onRouteMatched: function (oEvent) {
            this._setTitle(oEvent.getParameter("name"));
        },

        _setTitle: function (sRouteName) {
            if (Object.prototype.hasOwnProperty.call(ROUTE_TITLES, sRouteName)) {
                var oBundle = this.getView().getModel("i18n").getResourceBundle();
                this.getView().getModel("page").setProperty("/title", oBundle.getText(ROUTE_TITLES[sRouteName]));
            }
        },

        onNavBack: function () {
            this._oRouter.navTo("OrganizationMain", {}, true);
        },

        onExit: function () {
            this._oRouter.detachRouteMatched(this._onRouteMatched, this);
            PageController.prototype.onExit.apply(this, arguments);
        }
    });
});