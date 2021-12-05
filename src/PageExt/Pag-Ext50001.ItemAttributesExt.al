pageextension 50001 "Item Attributes Ext" extends "Item Attributes"
{
    layout
    {
        modify(Values)
        {
            Enabled = false;
            Visible = false;
        }

        addafter(Values)
        {
            field(ValuesCustom; Rec.GetValuesCustom())
            {
                ApplicationArea = All;
                Caption = 'Values';
                ToolTip = 'Specifies the values of the item attribute.';

                trigger OnDrillDown()
                begin
                    Rec.OpenItemAttributeValuesCustom();
                end;
            }
        }
    }

    actions
    {
    }

}
