page 50100 "Item Category Tags"
{
    Caption = 'Item Category Tags';
    PageType = List;
    SourceTable = "Item Category Tag";

    layout
    {
        area(Content)
        {
            repeater(Tags)
            {
                field(Tag; Tag)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}