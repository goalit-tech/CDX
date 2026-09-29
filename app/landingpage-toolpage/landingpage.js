/**
 * Lightweight FLP-style shell bootstrap, styled after the sap.tnt ToolPage demo app.
 * Does NOT depend on sap.ushell/sandbox.js - only on plain browser APIs (window.location.hash)
 * and core UI5 (sap.m, sap.tnt, sap.ui.core.Component), so it keeps working even if the ushell
 * sandbox test-resource is ever changed or removed.
 *
 * NOTE on hash isolation: sap.ui.core.routing.Router/Targets ("prefix" nested-hash-changer
 * option) and a history.replaceState-based cosmetic address-bar trick were both tried and
 * verified (via live testing) to NOT reliably isolate an embedded app's own router from the
 * shell's hash - the embedded app's router (and UI5's internal "hasher" hash cache) still end
 * up reading/matching the shell's tile id instead of an empty/nested hash, leaving the embedded
 * app blank. The only combination verified to work reliably: clear the browser hash right
 * before creating an embedded app's component (so its own router's initial match succeeds
 * against its default route), and never touch the browser hash again afterwards - the embedded
 * app then fully owns the hash for its own internal navigation, same as it would standalone.
 * Trade-off: the address bar shows the embedded app's own hash (e.g. "#"), not the shell's tile
 * id, while an app is open - the side-nav selection and header title still show which tile is active.
 *
 * - reads the same kind of config object as before (window["sap-landingpage-config"].applications)
 * - navigates via the URL hash (#<applicationId>), same concept as ushell's hash routing - honored
 *   once on initial page load for deep-linking to a tile, then handed off to the embedded app
 * - embeds target apps as UI5 components (applicationType "SAPUI5"), same as ushell "embedded" navigationMode
 *
 * Exposes window.cdx.landingpage.Container.createRenderer().placeAt(sId), analogous to
 * sap.ushell.Container.createRenderer().placeAt("content") in the old sandbox bootstrap.
 */
window.cdx = window.cdx || {};

(function () {
  "use strict";

  function getConfig() {
    return window["sap-landingpage-config"] || {};
  }

  function getApplications() {
    return getConfig().applications || {};
  }

  function getComponentName(sAdditionalInformation) {
    var iIdx = (sAdditionalInformation || "").indexOf("=");
    return iIdx > -1 ? sAdditionalInformation.slice(iIdx + 1) : sAdditionalInformation;
  }

  var oHashChanger = {
    getHash: function () {
      return window.location.hash.replace(/^#/, "");
    },
    setHash: function (sHash) {
      window.location.hash = sHash;
    },
  };

  function createRenderer() {
    var oComponentContainer = null;
    var oCurrentComponent = null;

    var oTitle = new sap.m.Title({
      text: getConfig().appTitle || "{{appTitle}}",
      level: "H4",
    });

    var oMenuButton = new sap.m.Button({
      icon: "sap-icon://menu2",
      type: sap.m.ButtonType.Transparent,
      tooltip: "Menu",
      press: function () {
        oToolPage.setSideExpanded(!oToolPage.getSideExpanded());
      },
    });

    var oHomeButton = new sap.m.Button({
      icon: "sap-icon://home",
      type: sap.m.ButtonType.Transparent,
      tooltip: "Home",
      press: function () {
        navigateTo("");
      },
    });

    var oToolHeader = new sap.tnt.ToolHeader({
      content: [oMenuButton, oTitle, new sap.tnt.ToolHeaderUtilitySeparator(), oHomeButton],
    });

    var oNavList = new sap.tnt.NavigationList({
      items: Object.keys(getApplications()).map(function (sAppId) {
        var oApp = getApplications()[sAppId];
        return new sap.tnt.NavigationListItem({
          key: sAppId,
          text: oApp.title || sAppId,
          icon: oApp.icon || "sap-icon://folder",
          select: function () {
            navigateTo(sAppId);
          },
        });
      }),
    });

    var oSideNavigation = new sap.tnt.SideNavigation({
      item: oNavList,
    });

    var oToolPage = new sap.tnt.ToolPage({
      header: oToolHeader,
      sideContent: oSideNavigation,
    });

    // swaps the ToolPage's main content directly (a VBox/FlexBox wrapper with height:100%
    // does NOT stretch its child to fill height, so embedded components would otherwise
    // render with 0 height and appear blank).
    function setMainContent(oControl) {
      oToolPage.removeAllMainContents();
      if (oControl) {
        oToolPage.addMainContent(oControl);
      }
    }

    function destroyCurrentApp() {
      if (oComponentContainer) {
        oComponentContainer.destroy();
        oComponentContainer = null;
      }
      if (oCurrentComponent) {
        oCurrentComponent.destroy();
        oCurrentComponent = null;
      }
    }

    function showHome() {
      oTitle.setText(getConfig().appTitle || "Home");
      oNavList.setSelectedKey("");
      oHashChanger.setHash("");
      destroyCurrentApp();

      var oTileContainer = new sap.m.FlexBox({ wrap: sap.m.FlexWrap.Wrap }).addStyleClass("sapUiSmallMargin");
      Object.keys(getApplications()).forEach(function (sAppId) {
        var oApp = getApplications()[sAppId];
        oTileContainer.addItem(
          new sap.m.GenericTile({
            header: oApp.title,
            subheader: oApp.description,
            press: function () {
              navigateTo(sAppId);
            },
            tileContent: new sap.m.TileContent({
              content: new sap.ui.core.Icon({ src: oApp.icon || "sap-icon://folder" }),
            }),
          }).addStyleClass("sapUiTinyMargin")
        );
      });

      setMainContent(oTileContainer);
    }

    function renderApp(sAppId) {
      var oApp = getApplications()[sAppId];
      if (!oApp) {
        showHome();
        return;
      }

      oTitle.setText(oApp.title || sAppId);
      oNavList.setSelectedKey(sAppId);
      destroyCurrentApp();

      if (oApp.applicationType === "SAPUI5") {
        // set the tile id as the visible hash (e.g. "#organizations-manage") so the address
        // bar reflects the active tile. Embedded apps with their own router (Fiori elements
        // List Report/Object Page) won't match this pattern on init, so their manifest routing
        // config must define a "bypassed" target (fallback to the default/list route) instead
        // of rendering blank - see app/organization/webapp/manifest.json for an example. Once
        // the embedded app navigates internally (e.g. list -> object page) it will overwrite
        // this hash with its own, which is an accepted trade-off (see repo memory).
      oHashChanger.setHash(sAppId);
        sap.ui.core.Component.create({
          name: getComponentName(oApp.additionalInformation),
          url: oApp.url,
          manifest: true,
        }).then(function (oComponent) {
          oCurrentComponent = oComponent;
          oComponentContainer = new sap.ui.core.ComponentContainer({
            component: oComponent,
            height: "100%",
            width: "100%",
          });
          setMainContent(oComponentContainer);
        //   oHashChanger.setHash(sAppId);
        });
      } else {
        setMainContent(new sap.m.MessageStrip({
          text: "Unsupported applicationType '" + oApp.applicationType + "' for " + sAppId,
          type: sap.ui.core.MessageType.Warning,
        }));
        // oHashChanger.setHash(sAppId);
      }
    }

    // shell-level navigation is driven by explicit calls (not by listening to hashchange):
    // embedded apps own the browser hash for their own internal routing once loaded, so
    // reacting to every hashchange here would fight with them (e.g. destroy the app the
    // moment it navigates from a list to an object page).
    function navigateTo(sAppId) {
      if (!sAppId) {
        showHome();
      } else {
        renderApp(sAppId);
      }
    }

    // the URL hash is still honored once, on initial load, for deep-linking to a tile
    // (e.g. bookmarked #organizations-manage) - same hash concept as the ushell sandbox.
    var sInitialHash = oHashChanger.getHash();
    if (sInitialHash) {
      renderApp(sInitialHash);
    } else {
      showHome();
    }

    return {
      placeAt: function (sId) {
        oToolPage.placeAt(sId);
      },
    };
  }

  cdx.landingpage = {
    Container: {
      createRenderer: createRenderer,
    },
  };
})();

