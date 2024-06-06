namespace app.fashionShop ;
using { Currency } from '@sap/cds/common';

type Flag : String(1);

entity Sections {
    key id : UUID ;
        name : String(16) ;
        description : String(64) ;
        // Fashion_Types : Association to many Fashion_Types on Fashion_Types.section = $self ;
}

entity Fashion_Types{
    key id : UUID;
        section : Association to Sections ;
        typename : String(16) ;
        description : String(64) ;
        // Fashion_items : Association to many Fashion_Items on Fashion_items.FashionType = $self;
}

entity Fashion_Items{
    key id : UUID ;
        FashionType: Association to Fashion_Types ;
        itemname : String(16) ;
        brand : String(64);
        size : String(8) ;
        material : String(16) ;
        price : String(10) ;
        currency : Currency;
        isAvailable : Flag ;
}

view YC_FashionShop as select from Fashion_Items as FItem 
{
    FItem.FashionType.section.id as sectionId,
    FItem.FashionType.section.name as sectionName,
    FItem.FashionType.section.description as sectionDescription,
    FItem.FashionType.id as fashionTypeId,
    FItem.FashionType.typename as fashionTypeName,
    FItem.FashionType.description as fashionTypeDesc,
    FItem.id as fashionItemId,
    FItem.itemname as fashionItemName,
    FItem.brand as brand,
    FItem.size as size,
    FItem.material as material,
    FItem.price as price,
    FItem.currency as currency,
    FItem.isAvailable as isAvailable,
    CONCAT(FItem.brand,FItem.itemname) as itemDetails : String(32),
    CASE 
        WHEN FItem.price >= 500 then 'Premium'
        WHEN FItem.price >= 100 and FItem.price < 500 then 'Mid-Range'
        else 'Low-Range'
    END as priceRange: String(10)

} ;//where FItem.isAvailable = 'X';

view YC_FashionType as select from Fashion_Types {

   Fashion_Types.id as fashionTypeId,
   Fashion_Types.typename as fashionTypeName,
   Fashion_Types.section.name as sectionName,

};