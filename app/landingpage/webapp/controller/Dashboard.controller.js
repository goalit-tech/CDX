sap.ui.define(
  ["sap/ui/core/mvc/Controller", "sap/ui/model/json/JSONModel"],
  (Controller, JSONModel) => {
    "use strict";

    return Controller.extend("cdx.ui.landingpage.controller.Dashboard", {
      onInit() {
        // Dashboard UI model
        const oDashboardModel = new JSONModel({
          userName: "School Administrator",
          userInitials: "SA",
          userRole: "Administrator",

          organizationCount: 12,
          campusCount: 8,
          studentCount: 2450,
          employeeCount: 180,

          currentAcademicYear: "2025 - 2026",
        });

        this.getView().setModel(oDashboardModel, "dashboard");
      },

      // =====================================================
      // HEADER
      // =====================================================

      onToggleSideNavigation() {
        const oToolPage = this.byId("campusDeskToolPage");

        oToolPage.setSideExpanded(!oToolPage.getSideExpanded());
      },

      onHomePress() {
        const oSideNavigation = this.byId("dashboardSideNavigation");

        const oNavigationList = oSideNavigation.getItem();

        if (oNavigationList) {
          oNavigationList.setSelectedKey("home");
        }
      },

      onNotificationsPress() {
        sap.m.MessageToast.show("Notifications will be available here.");
      },

      onProfilePress() {
        sap.m.MessageToast.show("User profile");
      },

      // =====================================================
      // SIDE NAVIGATION
      // =====================================================

      onNavigationSelect(oEvent) {
        const oItem = oEvent.getParameter("item");

        const sKey = oItem.getKey();

        switch (sKey) {
          case "home":
            break;

          case "organizations":
            sap.m.MessageToast.show("Organizations");
            break;

          case "campus":
            sap.m.MessageToast.show("Campuses");
            break;

          case "academicYears":
            sap.m.MessageToast.show("Academic Years");
            break;

          case "students":
            sap.m.MessageToast.show("Students");
            break;

          case "employees":
            sap.m.MessageToast.show("Employees");
            break;

          case "roles":
            sap.m.MessageToast.show("Roles & Access");
            break;

          case "settings":
            sap.m.MessageToast.show("Settings");
            break;

          case "support":
            sap.m.MessageToast.show("Help & Support");
            break;

          default:
            break;
        }
      },

      // =====================================================
      // KPI
      // =====================================================

      onOrganizationsPress() {
        sap.m.MessageToast.show("Organizations");
      },

      onCampusPress() {
        sap.m.MessageToast.show("Campuses");
      },

      onStudentsPress() {
        sap.m.MessageToast.show("Students");
      },

      onEmployeesPress() {
        sap.m.MessageToast.show("Employees");
      },

      // =====================================================
      // ACADEMIC YEARS
      // =====================================================

      onAcademicYearsPress() {
        sap.m.MessageToast.show("Academic Years");
      },

      // =====================================================
      // ROLES
      // =====================================================

      onRolesPress() {
        sap.m.MessageToast.show("Roles & Access");
      },
    });
  },
);
