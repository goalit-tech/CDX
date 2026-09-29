using siemens.cdx.usr.service.StudentService as service from '../../srv/userManagement/student/studentService';

annotate service.Students with @(
    UI.HeaderInfo         : {
        TypeName      : 'Student',
        TypeNamePlural: 'Students',
        Title         : {Value: studentName},
        Description   : {Value: email},
    },
    UI.Identification     : [{Value: studentName}],
    UI.SelectionFields    : [
        gender,
        admissionDate
    ],
    UI.LineItem           : [
        {Value: studentName, Label: 'Student Name'},
        {Value: gender, Label: 'Gender'},
        {Value: dateOfBirth, Label: 'Date of Birth'},
        {Value: email, Label: 'Email'},
        {Value: phone, Label: 'Phone'},
        {Value: admissionDate, Label: 'Admission Date'},
    ],
    UI.PresentationVariant: {
        Text          : 'Students Overview',
        SortOrder     : [{Property: studentName, Descending: false}],
        Visualizations: ['@UI.LineItem'],
    },
) {
    studentName   @title: 'Student Name';
    email         @title: 'Email';
    gender        @title: 'Gender';
    dateOfBirth   @title: 'Date of Birth';
    phone         @title: 'Phone';
    admissionDate @title: 'Admission Date';
};
