using siemens.cdx.org.service.OrganizationService as service from '../../srv/organizationSetup/organization/organizationService';
annotate service.Organization with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'orgName',
                Value : orgName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'orgCode',
                Value : orgCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'orgCategory_code',
                Value : orgCategory_code,
            },
            {
                $Type : 'UI.DataField',
                Label : 'scopeOfEducation',
                Value : scopeOfEducation,
            },
            {
                $Type : 'UI.DataField',
                Label : 'affiliationBody',
                Value : affiliationBody,
            },
            {
                $Type : 'UI.DataField',
                Label : 'taxID',
                Value : taxID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'accreditationID',
                Value : accreditationID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'registrationDate',
                Value : registrationDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'establishedYear',
                Value : establishedYear,
            },
            {
                $Type : 'UI.DataField',
                Label : 'orgType_code',
                Value : orgType_code,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status_code',
                Value : Status_code,
            },
            {
                $Type : 'UI.DataField',
                Label : 'logoURL',
                Value : logoURL,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'orgName',
            Value : orgName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'orgCode',
            Value : orgCode,
        },
        {
            $Type : 'UI.DataField',
            Label : 'orgCategory_code',
            Value : orgCategory_code,
        },
        {
            $Type : 'UI.DataField',
            Label : 'scopeOfEducation',
            Value : scopeOfEducation,
        },
        {
            $Type : 'UI.DataField',
            Label : 'affiliationBody',
            Value : affiliationBody,
        },
    ],
);

