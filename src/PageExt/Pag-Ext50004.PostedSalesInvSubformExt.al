pageextension 50004 "Posted Sales Inv Subform Ext" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field(Attributes; Rec.Attributes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

}
