table 50133 "Titanic Passenger"
{
    Caption = 'Titanic Passenger';

    fields
    {
        field(1; Id; Integer)
        {
            Caption = 'Id';
            AutoIncrement = true;
        }

        field(2; Name; Text[250])
        {
            Caption = 'Name';
        }

        field(3; Class; Option)
        {
            Caption = 'Class';
            OptionMembers = "1st","2nd","3rd";
            OptionCaption = '1st,2nd,3rd';
        }

        field(4; Age; Integer)
        {
            Caption = 'Age';
            BlankZero = true;

            trigger OnValidate();
            begin
                "Age is Known" := Age > 0;
            end;
        }

        field(5; "Age is Known"; Boolean)
        {
            Caption = 'Age is Known';

            trigger OnValidate();
            begin
                if (Age > 0) and (not "Age is Known") then
                    Age := 0;
                if (Age = 0) and "Age is Known" then
                    "Age is Known" := false;
            end;
        }

        field(6; Sex; Option)
        {
            Caption = 'Sex';
            OptionMembers = Male,Female;
            OptionCaption = 'Male,Female';
        }

        field(7; Survived; Boolean)
        {
            Caption = 'Survived';
        }

        field(8; Confidence; Decimal)
        {
            Caption = 'Confidence';
            BlankZero = true;
            Editable = false;
        }
    }

    keys
    {
        key(Primary; Id) { Clustered = true; }
    }
}