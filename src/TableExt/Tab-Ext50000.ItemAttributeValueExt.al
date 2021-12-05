tableextension 50000 "Item Attribute Value Ext" extends "Item Attribute Value"
{
    fields
    {
        field(50000; Enabled; Boolean)
        {
            Caption = 'Enabled';
            DataClassification = ToBeClassified;
        }
        field(50001; "For Multiple Selection Option"; Boolean)
        {
            Caption = 'For Multiple Selection Option';
            DataClassification = ToBeClassified;
        }
    }
}
