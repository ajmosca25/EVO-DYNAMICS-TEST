pageextension 50002 "Item Attribute Ext" extends "Item Attribute"
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
                Editable = false;
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
