sap.ui.define([
    "sap/ui/core/Component",
    "sap/ui/core/ComponentContainer",
    "sap/m/MessageBox"
], function (Component, ComponentContainer, MessageBox) {
    "use strict";

    var auth = window.CDXAuth;
    if (!auth.isLoggedIn()) {
        window.location.replace(auth.getLoginUrl());
        return;
    }

    async function readJson(url) {
        var response = await fetch(url);
        if (!response.ok) {
            throw new Error("Unable to load application configuration.");
        }
        return response.json();
    }

    async function launch() {
        var registry = await readJson("/projects.json");
        var projectKey = new URLSearchParams(window.location.search).get("project") || registry.defaultProject;
        if (!Object.prototype.hasOwnProperty.call(registry.projects, projectKey)) {
            throw new Error("Unknown project: " + projectKey);
        }
        var project = registry.projects[projectKey];
        var baseUrl = new URL(project.url, window.location.origin);
        if (baseUrl.origin !== window.location.origin) {
            throw new Error("The component must be hosted on this application server.");
        }
        var manifest = await readJson(new URL("manifest.json", baseUrl).href);
        var dataSources = manifest["sap.app"].dataSources || {};
        var models = manifest["sap.ui5"].models || {};

        Object.keys(dataSources).forEach(function (key) {
            if (dataSources[key].uri) {
                var serviceUrl = new URL(dataSources[key].uri, baseUrl);
                dataSources[key].uri = serviceUrl.href;
            }
        });
        Object.keys(models).forEach(function (key) {
            var model = models[key];
            var source = dataSources[model.dataSource];
            if (!source || source.type !== "OData") {
                return;
            }
            if (new URL(source.uri).origin !== window.location.origin) {
                throw new Error("Authenticated OData services must use this application server.");
            }
            var isV4 = model.type === "sap.ui.model.odata.v4.ODataModel" ||
                String((source.settings || {}).odataVersion || "").startsWith("4");
            var headerSetting = isV4 ? "httpHeaders" : "headers";
            model.settings = model.settings || {};
            model.settings[headerSetting] = Object.assign({}, model.settings[headerSetting], {
                Authorization: auth.getAuthHeader()
            });
        });

        document.title = project.title || project.name;

        var component = await Component.create({
            name: project.name,
            url: baseUrl.href,
            manifest: manifest,
            componentData: { user: auth.getUser() }
        });
        new ComponentContainer({
            id: "container",
            component: component,
            handleValidation: true,
            height: "100%"
        }).placeAt("content");
    }

    launch().catch(function (error) {
        MessageBox.error(error.message);
    });
});