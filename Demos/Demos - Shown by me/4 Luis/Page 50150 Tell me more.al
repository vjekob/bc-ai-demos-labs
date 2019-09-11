page 50150 "Tell me more"
{
    Caption = 'Tell me more...';
    PageType = CardPart;

    layout
    {
        area(Content)
        {
            field(Utterance; Utterance)
            {
                ShowCaption = false;
                ApplicationArea = All;

                trigger OnValidate();
                var
                    Luis: Codeunit Luis;
                begin
                    Luis.ProcessUtterance(Utterance);
                    Utterance := '';
                end;
            }
        }
    }

    var
        Utterance: Text;
}