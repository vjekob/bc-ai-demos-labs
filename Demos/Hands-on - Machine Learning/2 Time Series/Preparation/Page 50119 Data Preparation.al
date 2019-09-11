page 50119 "Data Preparation"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
        }
    }

    actions
    {
        area(Processing)
        {
            action(PrepareData)
            {
                Caption = 'Prepare Data';
                Image = DataEntry;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"Items History Generator");
                end;
            }
        }
    }
}