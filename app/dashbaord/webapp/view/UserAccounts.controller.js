sap.ui.define(
    [
        "sap/fe/core/PageController",
        "sap/m/MessageBox",
        "sap/m/MessageToast"
    ],
    function (PageController, MessageBox, MessageToast) {
        "use strict";

        return PageController.extend("cdx.ui.dashbaord.view.UserAccounts", {
            onNavBack: function () {
                this.getAppComponent().getRouter().navTo("OrganizationMain", {}, true);
            },

            onCreateAccount: async function (event) {
                var button = event.getSource();
                var resourceBundle = this.getView().getModel("i18n").getResourceBundle();
                var account = {
                    username: this.byId("accountUsernameInput").getValue().trim(),
                    firstName: this.byId("accountFirstNameInput").getValue().trim(),
                    lastName: this.byId("accountLastNameInput").getValue().trim(),
                    email: this.byId("accountEmailInput").getValue().trim(),
                    password: this.byId("accountPasswordInput").getValue(),
                    roleGroupName: this.byId("accountRoleSelect").getSelectedKey()
                };

                button.setEnabled(false);
                try {
                    var response = await fetch("/odata/v4/user-administration/createUser", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json",
                            Accept: "application/json",
                            Authorization: window.CDXAuth.getAuthHeader()
                        },
                        body: JSON.stringify(account)
                    });
                    var result = await response.json().catch(function () { return {}; });
                    if (!response.ok) {
                        throw new Error((result.error && result.error.message) || resourceBundle.getText("accountCreateFailed"));
                    }

                    this.byId("accountUsernameInput").setValue("");
                    this.byId("accountFirstNameInput").setValue("");
                    this.byId("accountLastNameInput").setValue("");
                    this.byId("accountEmailInput").setValue("");
                    this.byId("accountPasswordInput").setValue("");
                    MessageToast.show(resourceBundle.getText("accountCreated", [result.id || account.username]));
                } catch (error) {
                    MessageBox.error(error.message);
                } finally {
                    this.byId("accountPasswordInput").setValue("");
                    button.setEnabled(true);
                }
            }
        });
    }
);