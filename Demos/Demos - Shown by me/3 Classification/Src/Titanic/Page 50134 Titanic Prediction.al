page 50134 "Titanic Prediction"
{
    Caption = 'Titanic Prediction';
    PageType = List;
    SourceTable = "Titanic Passenger";
    SourceTableTemporary = true;
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
                field(Survived; Survived)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Confidence; Confidence)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Predict)
            {
                Caption = 'Predict';
                Image = CalculatePlan;
                ApplicationArea = All;

                trigger OnAction();
                var
                    Prediction: Codeunit "Titanic Passenger Pred. Mgt.";
                begin
                    Prediction.Predict(Rec);
                end;
            }
        }
    }

    var
        NextId: Integer;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        NextId += 1;
        Id := NextId;
    end;

    trigger OnOpenPage();
    var
        Setup: Record "Classification Setup";
    begin
        Setup.Get();
        Setup.TestField("Titanic Prediction Model");
    end;
}