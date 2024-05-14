using app.entities from '../db/entities';

//Service
//Adding restrictions/security using 'require : authenticated-user'
service entitiessrv @(require: 'authenticated-user') {
    //Add security in entity by using
    // entity OrderHeaders @(restrict: [
    //     {
    //         grant: ['*'], //means this user can do all CRUD operations
    //         to   : 'salesorderAdmin'
    //     },
    //     {
    //         grant: ['READ'],
    //         to   : 'salesorderRead'

    //     }
    // ])             as projection on entities.OrderHeaders;
    entity OrderHeaders  as projection on entities.OrderHeaders;

    @cds.redirection.target: true
    // entity OrderItems @(restrict: [
    //     {
    //         grant: [
    //             'WRITE',
    //             'UPDATE',
    //             'DELETE'
    //         ],
    //         to   : 'salesorderUser',
    //     },
    //     {
    //         grant: ['READ'],
    //         to   : 'salesorderUser',
    //         where: ' created_by = `aaa@gmail.com` '
    //     }
    // ])             as projection on entities.OrderItems;
    entity OrderItems    as projection on entities.OrderItems;

    entity OrdersDetails as projection on entities.CV_OrdersWithDetails;
}

//Odata Draft Annotation >> This will enable Drafts and "Create" & "Edit" functionality.. basta madami madadagadag sa app
@odata.draft.enabled
//Annotation
annotate entities.CV_OrdersWithDetails with @(UI: {
    // CreateHidden : true,
    DeleteHidden : true,
    //Header Info (Yung makikita mo sa screen)
    HeaderInfo: {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'SO TypeName',
        TypeNamePlural: 'SO TypeName (Plural)',
        Title         : {Value: OrderNumber}, //object declaration
        Description   : {Value: 'SO Description Field'}
    },

    //Selection Fields
    SelectionFields  : [
        MaterialName,
        MaterialNumber,
        OrderNumber
    ],

    //Line Item
    LineItem  : [
        {Value: MaterialNumber},
        {Value: MaterialName}
    ],

    //Facets
    Facets  : [{
        $Type : 'UI.CollectionFacet',
        ID: '1', //Grouping number.. incase you need to add more in the future
        Label : 'Material Details',
        Facets: [{
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#ItemDetails',
        }],
    },
    {
        $Type : 'UI.CollectionFacet',
        ID: '2', //Grouping number.. incase you need to add more in the future
        Label : 'Order Details',
        Facets: [{
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#OrderDetails',
        }],
    }],

    //Field Group (Dapat aligned ito to dun sa Facet > Target)
    FieldGroup #ItemDetails : {
        $Type : 'UI.FieldGroupType',
        Data: [
            {Value: MaterialNumber},
            {Value: MaterialName}
        ]},

    FieldGroup #OrderDetails : {
        $Type : 'UI.FieldGroupType',
        Data: [
            {Value: OrderNumber},
            {Value: Description}
        ]}
});
