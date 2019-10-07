table 50130 "Classification Setup"
{
    Caption = 'Classification Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            Editable = false;
        }

        field(2; "API URI"; Text[250])
        {
            Caption = 'API URI';
        }

        field(3; "API Key"; Text[250])
        {
            Caption = 'API Key';
        }

        field(4; "Sales Volume Model"; Blob)
        {
            Caption = 'Sales Volume Model';
        }

        field(5; "Sales Volume Model Quality"; Decimal)
        {
            Caption = 'Sales Volume Model Quality';
            Editable = false;
        }

        field(6; "Titanic Prediction Model"; Blob)
        {
            Caption = 'Titanic Prediction Model';
        }

        field(7; "Titanic Predict. Model Quality"; Decimal)
        {
            Caption = 'Titanic Prediction Model Quality';
            Editable = false;
        }
    }

    procedure GetModel() Content: Text
    var
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
    begin
        TempBlob.FromRecord(Rec, FieldNo("Sales Volume Model"));
        TempBlob.CreateInStream(InStream, TextEncoding::UTF8);
        InStream.Read(Content);
    end;

    procedure SetModel(Model: Text)
    var
        OutStream: OutStream;
    begin
        if not Rec.Get() then
            Rec.Insert();

        "Sales Volume Model".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.Write(Model);
    end;

    procedure GetTitanicModel() Content: Text
    var
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
    begin
        TempBlob.FromRecord(Rec, FieldNo("Titanic Prediction Model"));
        TempBlob.CreateInStream(InStream, TextEncoding::UTF8);
        InStream.Read(Content);
    end;

    procedure SetTitanicModel(Model: Text)
    var
        OutStream: OutStream;
    begin
        if not Rec.Get() then
            Rec.Insert();

        "Titanic Prediction Model".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.Write(Model);
    end;
}