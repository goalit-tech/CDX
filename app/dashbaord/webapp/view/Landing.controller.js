sap.ui.define(
  [
    "sap/fe/core/PageController",
    "sap/ui/model/json/JSONModel",
    "sap/ui/model/resource/ResourceModel",
    "sap/m/MessageBox",
  ],
  function (PageController, JSONModel, ResourceModel, MessageBox) {
    "use strict";

    var NAV_ROUTES = {
      home: "OrganizationMain",
      organization: "Organizations",
      "academic-year": "AcademicYear",
      "calendar-event": "CalendarEvents",
      campus: "Campus",
      grade: "Grade",
      section: "Section",
      employee: "Employees",
      student: "Students",
      enrollment: "Enrollment",
      role: "Roles",
      "role-assignment": "RoleAssignments",
      accounts: "UserAccounts",
    };

    return PageController.extend("cdx.ui.dashbaord.view.Landing", {
      onInit: function () {
        PageController.prototype.onInit.apply(this, arguments);
        var oResourceModel = new ResourceModel({
          bundleUrl: sap.ui.require.toUrl(
            "cdx/ui/dashbaord/i18n/i18n.properties",
          ),
        });
        this.getView().setModel(oResourceModel, "i18n");

        var oResourceBundle = oResourceModel.getResourceBundle();
        var oComponentData = this.getAppComponent().getComponentData() || {};
        var sDisplayName =
          (oComponentData.user && oComponentData.user.id) || "";
        this.getView().setModel(
          new JSONModel({
            user: oComponentData.user,
            displayName: sDisplayName,
            initials: sDisplayName.substring(0, 2).toUpperCase(),
            welcomeText: oResourceBundle.getText("landingWelcome"),
          }),
          "app",
        );
        var bIsAdmin = Array.isArray(oComponentData.user && oComponentData.user.roles) &&
          oComponentData.user.roles.includes("admin");
        this.byId("navItemAccounts").setVisible(bIsAdmin);
        this.byId("tileAccounts").setVisible(bIsAdmin);

        // selection lives on the NavigationList, not the individual item
        this.byId("mainNavList").setSelectedKey("home");
      },

      onToggleSideNav: function () {
        var oToolPage = this.byId("toolPage");
        oToolPage.setSideExpanded(!oToolPage.getSideExpanded());
      },

      onAvatarPress: function (oEvent) {
        this.byId("userMenu").openBy(oEvent.getSource());
      },

      onLogout: function () {
        var oResourceBundle = this.getView()
          .getModel("i18n")
          .getResourceBundle();
        MessageBox.confirm(oResourceBundle.getText("logoutConfirmation"), {
          title: oResourceBundle.getText("navLogout"),
          actions: [MessageBox.Action.YES, MessageBox.Action.NO],
          emphasizedAction: MessageBox.Action.NO,
          initialFocus: MessageBox.Action.NO,
          onClose: function (sAction) {
            if (sAction === MessageBox.Action.YES) {
              window.location.replace("/logout.html");
            }
          },
        });
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
        if (Object.prototype.hasOwnProperty.call(NAV_ROUTES, sKey)) {
          this.getAppComponent().getRouter().navTo(NAV_ROUTES[sKey]);
        }
      },
    });
  },
);
