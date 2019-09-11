page 50133 "Titanic Passengers"
{
    Caption = 'Titanic Passengers';
    PageType = List;
    SourceTable = "Titanic Passenger";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Passengers)
            {
                field(Name; Name) { ApplicationArea = All; }
                field(Class; Class) { ApplicationArea = All; }
                field(Age; Age) { ApplicationArea = All; }
                field("Age is Known"; "Age is Known") { ApplicationArea = All; }
                field(Sex; Sex) { ApplicationArea = All; }
                field(Survived; Survived) { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Import)
            {
                Caption = 'Import';
                Ellipsis = true;
                Image = ImportExcel;
                ApplicationArea = All;

                trigger OnAction();
                var
                    TitanicPassenger: Record "Titanic Passenger";
                begin
                    TitanicPassenger.DeleteAll();
                    Xmlport.Run(Xmlport::"Import Titanic Passengers", false, true);
                end;
            }

            action(Train)
            {
                Caption = 'Train Model';
                Image = CalculatePlan;
                ApplicationArea = All;

                trigger OnAction();
                var
                    Prediction: Codeunit "Titanic Passenger Pred. Mgt.";
                begin
                    Prediction.Train();
                end;
            }
        }
    }
}