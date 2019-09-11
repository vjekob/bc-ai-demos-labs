page 50130 "Classification Setup"
{
    Caption = 'Classification Setup';
    PageType = Card;
    SourceTable = "Classification Setup";
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("API URI"; "API URI")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("API Key"; "API Key")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }

            group(Models)
            {
                Caption = 'Models';

                group(SalesVolume)
                {
                    Caption = 'Sales Volume Model';

                    field("Sales Volume Model"; "Sales Volume Model".HasValue())
                    {
                        Caption = 'Sales Volume Model Exists';
                        ApplicationArea = All;
                    }

                    field("Sales Volume Model Quality"; "Sales Volume Model Quality")
                    {
                        ApplicationArea = All;
                    }
                }

                group(Titanic)
                {
                    Caption = 'Titanic Prediction Model';

                    field("Titanic Prediction Model"; "Titanic Prediction Model".HasValue())
                    {
                        Caption = 'Titanic Prediction Model Exists';
                        ApplicationArea = All;
                    }

                    field("Titanic Prediction Model Qual."; "Titanic Predict. Model Quality")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        if not Get() then begin
            Init();
            Insert();
        end;
    end;
}