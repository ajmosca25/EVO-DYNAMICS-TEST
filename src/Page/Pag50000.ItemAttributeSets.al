page 50000 "Item Attribute Sets"
{

    Caption = 'Item Attribute Sets';
    PageType = Worksheet;
    SourceTable = "Item Attribute Value";
    SourceTableTemporary = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Enabled"; Rec."Enabled")
                {
                    ApplicationArea = All;
                }
                field("Value"; Rec."Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
