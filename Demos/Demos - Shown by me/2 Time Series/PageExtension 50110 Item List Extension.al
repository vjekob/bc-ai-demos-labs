pageextension 50110 "Customer List Extension" extends "Customer List"
{
    actions
    {
        addlast(Navigation)
        {
            action(MonthlyForecast)
            {
                Caption = 'Get Monthly Payment Forecast';
                Image = Forecast;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction();
                var
                    MLForecast: Codeunit "Machine Learning Forecast";
                begin
                    Message('Monthly payment forecast: %1',
                        MLForecast.CalculateForecast(Rec));
                end;
            }
        }
    }
}