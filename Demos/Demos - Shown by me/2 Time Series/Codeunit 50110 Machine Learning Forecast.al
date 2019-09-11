codeunit 50110 "Machine Learning Forecast"
{
    procedure CalculateForecast(Customer: Record Customer): Decimal;
    var
        MLForecastSetup: Record "ML Forecast Setup";
        CustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        TempTimeSeriesBuffer: Record "Time Series Buffer" temporary;
        Date: Record Date;
        TempTimeSeriesForecast: Record "Time Series Forecast" temporary;
        TimeSeriesManagement: Codeunit "Time Series Management";
    begin
        MLForecastSetup.Get();
        TimeSeriesManagement.Initialize(
            MLForecastSetup."Endpoint URI", MLForecastSetup."API Key",
            0, false);

        CustLedgerEntry.SetRange("Customer No.", Customer."No.");
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Payment);

        TimeSeriesManagement.PrepareData(
            CustLedgerEntry,
            CustLedgerEntry.FieldNo("Customer No."),
            CustLedgerEntry.FieldNo("Posting Date"),
            CustLedgerEntry.FieldNo("Amount (LCY)"),
            Date."Period Type"::Month,
            WorkDate,
            12);

        TimeSeriesManagement.GetPreparedData(TempTimeSeriesBuffer);
        if TempTimeSeriesBuffer.FindSet() then
            repeat
                TempTimeSeriesBuffer.Value := -TempTimeSeriesBuffer.Value;
                TempTimeSeriesBuffer.Modify();
            until TempTimeSeriesBuffer.Next() = 0;

        TimeSeriesManagement.Forecast(1, 0, 0);
        TimeSeriesManagement.GetForecast(TempTimeSeriesForecast);
        if TempTimeSeriesForecast.FindFirst() then
            exit(TempTimeSeriesForecast.Value);
    end;

    procedure CalculateForecastBulk(
        CustNoFilter: Text;
        PeriodType: Option Date,Week,Month,Quarter,Year;
        NumberOfForecastPeriods: Integer;
        NumberOfPastPeriods: Integer;
        ConfidenceLevel: Integer;
        ForecastAlgorithm: Option ARIMA,ETS,STL,"ETS+ARIMA","ETS+STL",ALL;
        var TempTimeSeriesForecast: Record "Time Series Forecast" temporary);
    var
        MLForecastSetup: Record "ML Forecast Setup";
        CustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        TempTimeSeriesForecast2: Record "Time Series Forecast" temporary;
        TimeSeriesManagement: Codeunit "Time Series Management";
    begin
        if not TempTimeSeriesForecast.IsTemporary() then
            Error('TempTimeSeriesForecast must be temporary.');

        MLForecastSetup.Get();
        TimeSeriesManagement.Initialize(
            MLForecastSetup."Endpoint URI", MLForecastSetup."API Key",
            0, false);

        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Payment);
        CustLedgerEntry.SetFilter("Customer No.", CustNoFilter);

        TimeSeriesManagement.PrepareData(
           CustLedgerEntry,
           CustLedgerEntry.FieldNo("Customer No."),
           CustLedgerEntry.FieldNo("Posting Date"),
           CustLedgerEntry.FieldNo("Amount (LCY)"),
           PeriodType,
           WorkDate,
           NumberOfPastPeriods);

        TimeSeriesManagement.Forecast(
            NumberOfForecastPeriods,
            ConfidenceLevel,
            ForecastAlgorithm);
        TimeSeriesManagement.GetForecast(TempTimeSeriesForecast2);

        TempTimeSeriesForecast.Reset();
        TempTimeSeriesForecast.DeleteAll();
        if TempTimeSeriesForecast2.FindSet() then
            repeat
                TempTimeSeriesForecast := TempTimeSeriesForecast2;
                TempTimeSeriesForecast.Insert();
            until TempTimeSeriesForecast2.Next() = 0;
    end;
}