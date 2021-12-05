pageextension 50000 "Item Attribute Value List Ext" extends "Item Attribute Value List"
{
    layout
    {
        modify(Value)
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                ItemAttributeVal: Record "Item Attribute Value";
                ItemAttributeVal2: Record "Item Attribute Value";
                TmpItemAttributeVal: Record "Item Attribute Value" temporary;
                ItemAttributeSets: Page "Item Attribute Sets";
                ItemAttributeValue: Record "Item Attribute Value";
                ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
                ItemAttribute: Record "Item Attribute";
                OptionSelected: List of [Text];
                OptionValue: Text;
            begin
                if (Rec."Attribute Type" = Rec."Attribute Type"::Option) then begin
                    if (Rec.Value <> '') then begin
                        OptionValue := Rec.Value;
                        OptionSelected := OptionValue.Split(',');
                    end;

                    ItemAttributeVal.Reset();
                    ItemAttributeVal.SetRange("Attribute ID", Rec."Attribute ID");
                    ItemAttributeVal.SetRange(Blocked, false);
                    ItemAttributeVal.SetFilter(Value, '<>%1', '');
                    ItemAttributeVal.SetRange("For Multiple Selection Option", false);
                    if ItemAttributeVal.FindSet() then begin
                        repeat
                            TmpItemAttributeVal.Init();
                            TmpItemAttributeVal.TransferFields(ItemAttributeVal);
                            if OptionSelected.Count <> 0 then begin
                                if OptionSelected.Contains(ItemAttributeVal.Value) then begin
                                    TmpItemAttributeVal.Enabled := true;
                                end;
                            end;
                            TmpItemAttributeVal.Insert();
                        until ItemAttributeVal.Next() = 0;
                    end;

                    if Page.RunModal(Page::"Item Attribute Sets", TmpItemAttributeVal) = Action::LookupOK then begin
                        TmpItemAttributeVal.SetRange(Enabled, true);
                        if TmpItemAttributeVal.FindSet() then begin
                            Rec.Value := '';
                            repeat
                                if Rec.Value <> '' then
                                    Rec.Value := Rec.Value + ',' + TmpItemAttributeVal.Value
                                else
                                    Rec.Value := TmpItemAttributeVal.Value;
                            until TmpItemAttributeVal.Next() = 0;
                        end else begin
                            Rec.Value := '';
                        end;

                        if Rec.Value <> '' then begin
                            ItemAttributeVal.Reset();
                            ItemAttributeVal.SetRange("Attribute ID", Rec."Attribute ID");
                            ItemAttributeVal.SetRange(Value, Rec.Value);
                            if not ItemAttributeVal.FindSet() then begin
                                Clear(ItemAttributeVal2);
                                ItemAttributeVal2.Init();
                                ItemAttributeVal2."Attribute ID" := Rec."Attribute ID";
                                ItemAttributeVal2."Attribute Name" := Rec."Attribute Name";
                                ItemAttributeVal2.Value := Rec.Value;
                                ItemAttributeVal2."For Multiple Selection Option" := true;
                                ItemAttributeVal2.Insert();
                            end;
                        end;

                        if not Rec.FindAttributeValue(ItemAttributeValue) then
                            Rec.InsertItemAttributeValue(ItemAttributeValue, Rec);

                        ItemAttributeValueMapping.SetRange("Table ID", DATABASE::Item);
                        ItemAttributeValueMapping.SetRange("No.", RelatedRecordCode);
                        ItemAttributeValueMapping.SetRange("Item Attribute ID", ItemAttributeValue."Attribute ID");
                        if ItemAttributeValueMapping.FindFirst then begin
                            ItemAttributeValueMapping."Item Attribute Value ID" := ItemAttributeValue.ID;
                            ItemAttributeValueMapping.Modify();
                        end;

                        ItemAttribute.Get(Rec."Attribute ID");
                        if ItemAttribute.Type <> ItemAttribute.Type::Option then
                            if Rec.FindAttributeValueFromRecord(ItemAttributeValue, xRec) then
                                if not ItemAttributeValue.HasBeenUsed then
                                    ItemAttributeValue.Delete();
                    end;
                end;
            end;
        }
    }

    actions
    {
    }
}
