tableextension 50002 "Sales Invoice Line Ext" extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "Attributes"; Text[1024])
        {
            DataClassification = ToBeClassified;
        }
    }
}
