table 50100 "Item Category Tag"
{
    Caption = 'Item Category Tag';

    fields
    {
        field(1; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }

        field(2; Tag; Code[250])
        {
            Caption = 'Tag';
        }
    }

    keys
    {
        key(Primary; "Item Category Code", Tag) { Clustered = true; }
    }
}