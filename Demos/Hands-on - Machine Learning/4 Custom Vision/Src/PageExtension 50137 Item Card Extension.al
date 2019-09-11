pageextension 50137 "Item Card Extension" extends "Item Card"
{
    actions
    {
        addlast(Item)
        {
            action(SuggestAttributes)
            {
                Caption = 'Suggest Attributes';
                Promoted = true;
                PromotedCategory = Category4;

                Image = SuggestTables;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    CustomVisionManagement.SuggestItemAttributes(Rec);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        CustomVisionManagement: Codeunit "Custom Vision Management";

    trigger OnOpenPage();
    begin
        CustomVisionManagement.Initialize();
    end;
}