page 50111 "Prediction Overview"
{
    PageType = Worksheet;
    Caption = 'Prediction Overview';
    SourceTable = "Time Series Forecast";
    UsageCategory = Tasks;
    SourceTableTemporary = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(Prediction)
            {
                Caption = 'Prediction';

                field(CustomerNoFilter; CustomerNoFilter)
                {
                    Caption = 'Customer No. Filter';
                    ApplicationArea = All;
                }
                field(PeriodType; PeriodType)
                {
                    Caption = 'Period Type';
                    ApplicationArea = All;
                }
                field(NoForecastPeriods; NumberOfForecastPeriods)
                {
                    Caption = 'No. of Forecast Periods';
                    ApplicationArea = All;
                }
                field(NoPastPeriods; NumberOfPastPeriods)
                {
                    Caption = 'No. of Past Periods';
                    ApplicationArea = All;
                }
                field(ConfidenceLevel; ConfidenceLevel)
                {
                    Caption = 'Confidence Level';
                    ApplicationArea = All;
                }
                field(Algorithm; ForecastAlgorithm)
                {
                    Caption = 'Forecast Algorithm';
                    ApplicationArea = All;
                }
            }

            group(PurchaseOrder)
            {
                Caption = 'Purchase Order';

                field(VendorNo; VendorNo)
                {
                    Caption = 'Vendor No.';
                    TableRelation = Vendor;
                    ApplicationArea = All;
                }

                field(QualityBar; QualityBar)
                {
                    Caption = 'Quality Bar';
                    ApplicationArea = All;
                }
            }

            repeater(Lines)
            {
                Editable = false;
                field("Group ID"; "Group ID")
                {
                    ApplicationArea = All;
                }
                field("Period No."; "Period No.")
                {
                    ApplicationArea = All;
                }
                field("Period Start Date"; "Period Start Date")
                {
                    ApplicationArea = All;
                }
                field(Value; Value)
                {
                    ApplicationArea = All;
                }
                field(Delta; Delta)
                {
                    ApplicationArea = All;
                }
                field("Delta %"; "Delta %")
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
            action(CalculateForecastBulk)
            {
                Caption = 'Calculate Forecast';
                Image = CalculatePlan;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    MLForecast: Codeunit "Machine Learning Forecast";
                begin
                    MLForecast.CalculateForecastBulk(
                        CustomerNoFilter,
                        PeriodType,
                        NumberOfForecastPeriods,
                        NumberOfPastPeriods,
                        ConfidenceLevel,
                        ForecastAlgorithm,
                        Rec);
                    if Rec.FindFirst() then;
                end;
            }
        }
    }

    var
        CustomerNoFilter: Text;
        PeriodType: Option Date,Week,Month,Quarter,Year;
        NumberOfForecastPeriods: Integer;
        NumberOfPastPeriods: Integer;
        ConfidenceLevel: Integer;
        ForecastAlgorithm: Option ARIMA,ETS,STL,"ETS+ARIMA","ETS+STL",ALL;
        VendorNo: Code[20];
        QualityBar: Decimal;

    trigger OnInit();
    begin
        PeriodType := PeriodType::Month;
        NumberOfForecastPeriods := 1;
        NumberOfPastPeriods := 12;
        ConfidenceLevel := 80;
    end;
}