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
        {Value: email, Label: 'Email'},
        {Value: guardianName, Label: 'Guardian'},
        {Value: gender, Label: 'Gender'},
        {Value: phone, Label: 'Phone'},
        {Value: admissionDate, Label: 'Admission Date'},
    ],
    UI.PresentationVariant: {
        Text          : 'Student Dashboard',
        SortOrder     : [{Property: admissionDate, Descending: true}],
        Visualizations: ['@UI.LineItem'],
    },
) {
    studentName   @title: 'Student Name';
    email         @title: 'Email';
    guardianName  @title: 'Guardian';
    gender        @title: 'Gender';
    phone         @title: 'Phone';
    admissionDate @title: 'Admission Date';
};
