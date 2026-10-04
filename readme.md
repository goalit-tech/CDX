# CDX (Campus Digital Experience) - School Management System

Welcome to the CDX CAP project.

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

Login posts credentials to `AuthenticationService.login`. Accounts are read from
`cdx.auth.Role`; store passwords as `scrypt$<salt>$<hash>` values generated with
the `hashPassword` helper in `srv/authentication/security.js`. For local setup,
generate a password hash with:

```powershell
node -e "require('./srv/authentication/security').hashPassword(process.argv[1]).then(console.log)" "YourStrongPassword"
```

For local development, account data is stored in the ignored `db.sqlite` file.
Set `JWT_SECRET` to a random value of at least 32 bytes before starting the app,
and keep the same value when restarting it so existing tokens remain valid:

```powershell
npm run db:init
$env:JWT_SECRET = node -e "console.log(require('crypto').randomBytes(32).toString('base64'))"
npx cds watch
```

With the server running, open a second terminal in the project directory and
create the first administrator interactively. The script hides password input
and calls the unauthenticated bootstrap action, which only succeeds while the
account table is empty:

```powershell
npm run bootstrap-admin
```

Sign in at `/login.html` with that account. Administrators can then open
**User Management > Accounts** to create admin or faculty accounts. The account
creation action requires an admin JWT; only the one-time bootstrap action is
unauthenticated. Keep the app local until bootstrap is complete and do not
expose this local-password flow as a production identity provider.

The login action returns a short-lived HS256 bearer token. Every business OData
service requires an authenticated user, and the CAP custom authentication
implementation validates the bearer token and populates `cds.context.user`.

This custom strategy follows CAP's documented authentication middleware
contract. For production use with SAP identity providers, configure CAP's `jwt`,
`xsuaa`, or `ias` strategy and issue tokens through that trusted provider rather
than using local password-based token issuance.
