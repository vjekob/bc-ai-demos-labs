page 50131 "Sales Volume"
{
    Caption = 'Sales Volume';
    PageType = List;
    SourceTable = "Sales Volume";
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
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Import)
            {
                Caption = 'Import data';
                Ellipsis = true;
                Image = ImportExcel;
                ApplicationArea = All;

                trigger OnAction();
                var
                    SalesVolume: Record "Sales Volume";
                    Confirmation: Label 'Do you want to empty the %1 table first?';
                begin
                    if not SalesVolume.IsEmpty() then
                        if (Confirm(Confirmation, false, SalesVolume.TableCaption())) then
                            SalesVolume.DeleteAll();

                    Xmlport.Run(Xmlport::"Import Sales Volume", false, true);
                end;
            }

            action(Train)
            {
                Caption = 'Train Model';
                Image = CalculatePlan;
                ApplicationArea = All;

                trigger OnAction();
                var
                    Classification: Codeunit "Sales Volume Classif. Mgt.";
                begin
                    Classification.Train();
                end;
            }
        }
    }
}