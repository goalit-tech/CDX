(function () {
    "use strict";

    var activeProjectUrl;

    window.addEventListener("popstate", synchronizeNavigation);
    window.addEventListener("pageshow", function (event) {
        if (event.persisted) {
            synchronizeNavigation();
        }
    });

    if (window.CDXAuth.isLoggedIn()) {
        loadProject().catch(function (error) {
            var errorStrip = document.getElementById("errorStrip");
            errorStrip.textContent = error.message;
            errorStrip.hidden = false;
        });
        return;
    }

    if (window.location.search || window.location.hash) {
        window.location.replace(window.CDXAuth.getLoginUrl());
        return;
    }

    var form = document.getElementById("loginForm");
    var username = document.getElementById("username");
    var password = document.getElementById("password");
    var errorStrip = document.getElementById("errorStrip");
    var signInButton = document.getElementById("signInButton");

    form.addEventListener("submit", async function (event) {
        event.preventDefault();
        errorStrip.hidden = true;
        if (!username.value.trim() || !password.value) {
            errorStrip.textContent = "Please enter both username and password.";
            errorStrip.hidden = false;
            return;
        }
        signInButton.disabled = true;
        form.setAttribute("aria-busy", "true");
        try {
            await window.CDXAuth.signIn(username.value.trim(), password.value);
            await loadProject();
        } catch (error) {
            errorStrip.textContent = error.message;
            errorStrip.hidden = false;
            password.value = "";
            password.focus();
        } finally {
            signInButton.disabled = false;
            form.removeAttribute("aria-busy");
        }
    });

    function synchronizeNavigation() {
        if (window.CDXAuth.isLoggedIn()) {
            loadProject().catch(function (error) {
                var errorStrip = document.getElementById("errorStrip");
                if (errorStrip) {
                    errorStrip.textContent = error.message;
                    errorStrip.hidden = false;
                }
            });
        } else if (document.getElementById("app") || window.location.search || window.location.hash) {
            window.location.replace(window.CDXAuth.getLoginUrl());
        }
    }

    async function loadProject() {
        var launchUrl = activeProjectUrl || await window.CDXAuth.getLaunchUrl();
        if (!window.CDXAuth.isLoggedIn()) {
            return;
        }
        activeProjectUrl = launchUrl;
        if (window.location.pathname + window.location.search !== launchUrl) {
            window.history.replaceState(window.history.state, "", launchUrl + window.location.hash);
        }
        if (document.getElementById("sap-ui-bootstrap")) {
            return;
        }

        var host = document.getElementById("componentHost");
        document.body.replaceChildren(host.content.cloneNode(true));
        document.body.className = "sapUiBody sapUiSizeCompact cdxHost";

        var bootstrap = document.createElement("script");
        bootstrap.id = "sap-ui-bootstrap";
        bootstrap.src = "https://sapui5.hana.ondemand.com/1.152.0/resources/sap-ui-core.js";
        bootstrap.setAttribute("data-sap-ui-theme", "sap_horizon");
        bootstrap.setAttribute("data-sap-ui-resource-roots", JSON.stringify({ "cdx.shell": "/" }));
        bootstrap.setAttribute("data-sap-ui-on-init", "module:cdx/shell/launcher");
        bootstrap.setAttribute("data-sap-ui-compat-version", "edge");
        bootstrap.setAttribute("data-sap-ui-async", "true");
        bootstrap.setAttribute("data-sap-ui-frame-options", "trusted");
        document.head.appendChild(bootstrap);
    }
}());