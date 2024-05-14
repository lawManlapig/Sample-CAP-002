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
    entity OrderHeaders as projection on entities.OrderHeaders;

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
    entity OrderItems as projection on entities.OrderItems;
    entity OrdersDetails as projection on entities.CV_OrdersWithDetails;
}
