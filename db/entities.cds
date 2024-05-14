namespace app.entities;

using {managed} from '@sap/cds/common';

//Entity
entity OrderHeaders : managed {
    key id                  : UUID;
    key ordernumber         : Int32;
        customerid          : String(10);
        documenttype        : String(4);
        salesorganization   : String(4);
        distributionchannel : String(2);
        division            : String(2);
        netvalue            : Decimal(15, 2);
// orderitems          : Association to many OrderItems
//                           on orderitems.ordernumber = $self;
}

entity OrderItems {
    key id          : UUID;
    key ordernumber : Association to OrderHeaders;
    key itemnumber  : String(10);
        material    : String(18);
        batch       : String(10);
        description : String(40);
        price       : Decimal(15, 2);
}

entity Materials {
    key id             : UUID;
    key materialnumber : String(20);
        materialname   : String(50);
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
            OrderItems.description as Description,
        key OrderItems.material as MaterialNumber,
            Materials.materialname as MaterialName,
    }
