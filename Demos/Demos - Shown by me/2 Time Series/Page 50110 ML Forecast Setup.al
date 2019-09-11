page 50110 "ML Forecast Setup"
{
    PageType = Card;
    Caption = 'Machine Learning Forecast Setup';
    SourceTable = "ML Forecast Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Endpoint URI"; "Endpoint URI")
                {
                    Caption = 'Endpoint URI';
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("API Key"; "API Key")
                {
                    Caption = 'API Key';
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert();
        end;
    end;
}