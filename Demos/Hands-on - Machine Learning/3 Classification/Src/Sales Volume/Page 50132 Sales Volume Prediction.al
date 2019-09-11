page 50132 "Sales Volume Prediction"
{
    Caption = 'Sales Volume Prediction';
    PageType = List;
    SourceTable = "Sales Volume";
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Data)
            {
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }

                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }

                field(Volume; Volume)
                {
                    Editable = false;
                    Style = StrongAccent;
                    ApplicationArea = All;
                }

                field(Color; Color)
                {
                    ApplicationArea = All;
                }

                field(Size; Size)
                {
                    ApplicationArea = All;
                }

                field(Price; Price)
                {
                    ApplicationArea = All;
                }

                field(Confidence; Confidence)
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = (Confidence > 0) and (Confidence <= MinimumConfidence);
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
                    Classification: Codeunit "Sales Volume Classif. Mgt.";
                begin
                    Classification.Predict(Rec);
                end;
            }
        }
    }

    var
        MinimumConfidence: Decimal;
        EntryNo: Integer;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        EntryNo += 1;
        "Entry No." := EntryNo;
    end;

    trigger OnOpenPage();
    var
        Setup: Record "Classification Setup";
    begin
        Setup.Get();
        Setup.TestField("Sales Volume Model");
        MinimumConfidence := Setup."Sales Volume Model Quality";
    end;
}