table 50136 "Custom Vision Tag"
{
    Caption = 'Custom Vision Tag';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }

        field(3; Tag; Text[250])
        {
            Caption = 'Tag';
        }

        field(4; Confidence; Decimal)
        {
            Caption = 'Confidence';
        }
    }

    keys
    {
        key(Primary; "Entry No.") { }
    }
}