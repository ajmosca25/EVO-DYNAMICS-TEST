reportextension 50000 "Standard Sales - Invoice Ext" extends "Standard Sales - Invoice"
{
    RDLCLayout = './src/ReportExt/Layout/CustomSalesInvoice.rdlc';
    WordLayout = './src/ReportExt/Layout/CustomSalesInvoice.docx';

    dataset
    {
        add(Line)
        {
            column(Attributes; Attributes)
            {
            }
        }
    }
}
