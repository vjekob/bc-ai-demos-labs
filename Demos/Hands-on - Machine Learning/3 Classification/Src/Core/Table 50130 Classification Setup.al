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

    procedure GetModel(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        BlobRef: FieldRef;
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Rec);
        BlobRef := RecRef.Field(FieldNo("Sales Volume Model"));
        exit(TypeHelper.ReadBlob(BlobRef));
    end;

    procedure SetModel(Model: Text)
    var
        TypeHelper: Codeunit "Type Helper";
        RecRef: RecordRef;
    begin
        if not Rec.Get() then
            Rec.Insert();

        RecRef.GetTable(Rec);
        TypeHelper.SetBlobString(
            RecRef,
            FieldNo("Sales Volume Model"),
            Model);
        RecRef.SetTable(Rec);
    end;

    procedure GetTitanicModel(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        BlobRef: FieldRef;
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Rec);
        BlobRef := RecRef.Field(FieldNo("Titanic Prediction Model"));
        exit(TypeHelper.ReadBlob(BlobRef));
    end;

    procedure SetTitanicModel(Model: Text)
    var
        TypeHelper: Codeunit "Type Helper";
        RecRef: RecordRef;
    begin
        if not Rec.Get() then
            Rec.Insert();

        RecRef.GetTable(Rec);
        TypeHelper.SetBlobString(
            RecRef,
            FieldNo("Titanic Prediction Model"),
            Model);
        RecRef.SetTable(Rec);
    end;
}