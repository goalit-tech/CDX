(function () {
    "use strict";

    var credentialsKey = "cdx.auth.credentials";
    var userKey = "cdx.auth.user";

    window.CDXAuth = {
        signIn: async function (username, password) {
            var bytes = new TextEncoder().encode(username + ":" + password);
            var header = "Basic " + btoa(Array.from(bytes, function (byte) {
                return String.fromCharCode(byte);
            }).join(""));
            var response = await fetch("/odata/v4/auth/whoami", {
                headers: { Authorization: header, Accept: "application/json" }
            });
            if (!response.ok) {
                throw new Error("Invalid username or password. Please try again.");
            }
            var user = await response.json();
            sessionStorage.setItem(credentialsKey, header);
            sessionStorage.setItem(userKey, JSON.stringify(user));
            return user;
        },
        signOut: function () {
            sessionStorage.removeItem(credentialsKey);
            sessionStorage.removeItem(userKey);
        },
        getUser: function () {
            try {
                return JSON.parse(sessionStorage.getItem(userKey));
            } catch (error) {
                return null;
            }
        },
        getAuthHeader: function () {
            return sessionStorage.getItem(credentialsKey);
        },
        isLoggedIn: function () {
            return !!this.getAuthHeader() && !!this.getUser();
        },
        getLaunchUrl: async function () {
            var project = new URLSearchParams(window.location.search).get("project");
            if (!project) {
                var response = await fetch("/projects.json");
                if (!response.ok) {
                    throw new Error("Unable to load application configuration.");
                }
                var registry = await response.json();
                project = registry.defaultProject;
            }
            return "/login.html?sap-ui-xx-viewCache=false&project=" + encodeURIComponent(project);
        },
        getLoginUrl: function () {
            return "/login.html";
        }
    };
}());