(function () {
    "use strict";

    var credentialsKey = "cdx.auth.credentials";
    var userKey = "cdx.auth.user";

    window.CDXAuth = {
        signIn: async function (username, password) {
            var response = await fetch("/odata/v4/authentication/login", {
                method: "POST",
                headers: { "Content-Type": "application/json", Accept: "application/json" },
                body: JSON.stringify({ username: username, password: password })
            });
            if (!response.ok) {
                throw new Error("Invalid username or password. Please try again.");
            }
            var result = await response.json();
            sessionStorage.setItem(credentialsKey, result.accessToken);
            sessionStorage.setItem(userKey, JSON.stringify(result.user));
            sessionStorage.setItem("cdx.auth.expiresAt", String(Date.now() + result.expiresIn * 1000));
            return result.user;
        },
        signOut: function () {
            sessionStorage.removeItem(credentialsKey);
            sessionStorage.removeItem(userKey);
            sessionStorage.removeItem("cdx.auth.expiresAt");
        },
        getUser: function () {
            try {
                return JSON.parse(sessionStorage.getItem(userKey));
            } catch (error) {
                return null;
            }
        },
        getAuthHeader: function () {
            var token = sessionStorage.getItem(credentialsKey);
            return token ? "Bearer " + token : null;
        },
        isLoggedIn: function () {
            var expiresAt = Number(sessionStorage.getItem("cdx.auth.expiresAt"));
            return !!this.getAuthHeader() && !!this.getUser() && expiresAt > Date.now();
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