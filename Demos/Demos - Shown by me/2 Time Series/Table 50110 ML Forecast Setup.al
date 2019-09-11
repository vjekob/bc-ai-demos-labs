table 50110 "ML Forecast Setup"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            Editable = false;
        }
        field(2; "Endpoint URI"; Text[250])
        {
            Caption = 'Endpoint URI';
        }
        field(3; "API Key"; Text[250])
        {
            Caption = 'API Key';
        }
    }

    keys
    {
        key(PrimaryKey; "Primary Key") { }
    }
}