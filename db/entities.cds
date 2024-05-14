namespace app.entities;

using {managed} from '@sap/cds/common';

//Entity
entity OrderHeaders : managed {
    key id                  : UUID;
    key ordernumber         : Int32          @(title: 'Order Number');
        customerid          : String(10)     @(title: 'Customer ID');
        documenttype        : String(4)      @(title: 'Document Type');
        salesorganization   : String(4)      @(title: 'Sales Organization');
        distributionchannel : String(2)      @(title: 'Distribution Channel');
        division            : String(2)      @(title: 'Division');
        netvalue            : Decimal(15, 2) @(title: 'Net Value');
// orderitems          : Association to many OrderItems
//                           on orderitems.ordernumber = $self;
}

entity OrderItems {
    key id          : UUID;
    key ordernumber : Association to OrderHeaders @(title: 'Order Number');
    key itemnumber  : String(10)                  @(title: 'Item Number');
        material    : String(18)                  @(title: 'Material Number');
        batch       : String(10)                  @(title: 'Batch');
        description : String(40)                  @(title: 'Description');
        price       : Decimal(15, 2)              @(title: 'Price');
}

entity Materials {
    key id             : UUID;
    key materialnumber : String(20) @(title: 'Material Number');
        materialname   : String(50) @(title: 'Material Name');
}

//View
//Makakapag Join ka lang kapag walang Association yung entities mo...
//Somehow, nag error siya kapag may Association yung entity na ginagamit mo sa CDS
view CV_OrdersWithDetails as
    select from OrderItems
    left outer join Materials
        on Materials.materialnumber = OrderItems.material
    {
        key OrderItems.ordernumber.ordernumber as OrderNumber,
            OrderItems.description             as Description,
        key OrderItems.material                as MaterialNumber,
            Materials.materialname             as MaterialName,
    }
