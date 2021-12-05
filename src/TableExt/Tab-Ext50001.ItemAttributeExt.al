tableextension 50001 "Item Attribute Ext" extends "Item Attribute"
{
    fields
    {
    }

    procedure GetValuesCustom() Values: Text
    var
        ItemAttributeValue: Record "Item Attribute Value";
    begin
        if Rec.Type <> Rec.Type::Option then
            exit('');
        ItemAttributeValue.SetRange("Attribute ID", Rec.ID);
        ItemAttributeValue.SetRange("For Multiple Selection Option", false);
        if ItemAttributeValue.FindSet then
            repeat
                if Values <> '' then
                    Values += ',';
                Values += ItemAttributeValue.Value;
            until ItemAttributeValue.Next() = 0;
    end;

    procedure OpenItemAttributeValuesCustom()
    var
        ItemAttributeValue: Record "Item Attribute Value";
    begin
        ItemAttributeValue.SetRange("Attribute ID", Rec.ID);
        ItemAttributeValue.SetRange("For Multiple Selection Option", false);
        if Rec.Type = Rec.Type::Option then
            PAGE.Run(PAGE::"Item Attribute Values", ItemAttributeValue);
    end;
}
