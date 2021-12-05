pageextension 50003 "Item Attribute Values Ext" extends "Item Attribute Values"
{
    layout
    {
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
    begin
        Rec.SetRange("For Multiple Selection Option", false);
    end;
}
