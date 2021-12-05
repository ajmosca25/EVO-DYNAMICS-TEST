codeunit 50000 Events
{
    trigger OnRun()
    var
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnAfterInitFromSalesLine', '', false, false)]
    local procedure OnAfterInitFromSalesLine(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line")
    var
        ItemAttributeValMapping: Record "Item Attribute Value Mapping";
        ItemAttributeVal: Record "Item Attribute Value";
    begin
        if (SalesLine.Type = SalesLine.Type::Item) then begin
            SalesInvLine.Attributes := '';
            ItemAttributeValMapping.Reset();
            ItemAttributeValMapping.SetRange("Table ID", Database::Item);
            ItemAttributeValMapping.SetRange("No.", SalesLine."No.");
            if ItemAttributeValMapping.FindSet() then begin
                repeat
                    ItemAttributeVal.Reset();
                    ItemAttributeVal.SetRange("Attribute ID", ItemAttributeValMapping."Item Attribute ID");
                    ItemAttributeVal.SetRange(ID, ItemAttributeValMapping."Item Attribute Value ID");
                    if ItemAttributeVal.FindSet() then begin
                        ItemAttributeVal.CalcFields("Attribute Name");
                        if SalesInvLine.Attributes <> '' then
                            SalesInvLine.Attributes := SalesInvLine.Attributes + ' | ' + ItemAttributeVal."Attribute Name" + ':' + ItemAttributeVal.Value
                        else
                            SalesInvLine.Attributes := ItemAttributeVal."Attribute Name" + ':' + ItemAttributeVal.Value;
                    end;
                until ItemAttributeValMapping.Next() = 0;
            end;
        end;
    end;
}
