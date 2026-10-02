# Getting Started

Welcome to your new CAP project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`readme.md` | this getting started guide

## Next Steps

- Open a new terminal and run `cds watch`
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start with your domain model, in a CDS file in `db/`

## Learn More

Learn more at <https://cap.cloud.sap>.

## Standalone Login And Component Host

Open `/login.html` after starting CAP. Login and logout use plain HTML and
JavaScript in `app/`, with no dependency on a dashboard view or controller.
After successful authentication, the URL becomes `/login.html?project=dashboard`
(or the selected project's key), and the page loads UI5 using `Component.create`
and `ComponentContainer`. UI5 is not loaded for the signed-out login form.
Logout always returns to `/login.html` without query parameters. `/index.html`
is retained only as a redirect to the appropriate login or authenticated URL.

Configure projects in `app/projects.json`. Each project has a component `name`,
a same-origin component `url` ending in `/`, and an optional `title`.
`defaultProject` selects the project after signing in at `/login.html`.
To switch to another registered project after signing in, open
`/login.html?project=your-project-key`. Signed-out visits to a project URL
redirect to `/login.html` without query parameters.
The host supplies authorization headers to manifest-declared OData V2/V4 models
before creating the component. Backend services remain responsible for access
control; project selection is not an authorization check.

The host owns the Log Out action. UI5 projects contain only their application
logic, without login/logout handlers or session guards. The dashboard's own
entry page can still be used independently, but the authenticated workflow uses
the shared host.

This development flow uses CAP mocked Basic authentication and browser session
storage. Use an identity-provider-backed server session for production.
