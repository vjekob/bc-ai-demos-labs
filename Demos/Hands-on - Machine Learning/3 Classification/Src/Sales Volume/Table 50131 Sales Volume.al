table 50131 "Sales Volume"
{
    Caption = 'Sales Volume';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }

        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }

        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }

        field(4; Volume; Option)
        {
            Caption = 'Volume';
            OptionMembers = None,VeryLow,Low,Medium,High,VeryHigh,Extraordinary;
            OptionCaption = 'None,VeryLow,Low,Medium,High,VeryHigh,Extraordinary';
        }

        field(5; Color; Option)
        {
            Caption = 'Color';
            OptionMembers = Red,Green,Blue;
            OptionCaption = 'Red,Green,Blue';
        }

        field(6; Size; Option)
        {
            Caption = 'Size';
            OptionMembers = S,M,L,XL;
            OptionCaption = 'S,M,L,XL';
        }

        field(7; Price; Decimal)
        {
            Caption = 'Price';
        }

        field(8; Confidence; Decimal)
        {
            Caption = 'Confidence';
        }
    }

    keys
    {
        key(Primary; "Entry No.") { }
    }
}