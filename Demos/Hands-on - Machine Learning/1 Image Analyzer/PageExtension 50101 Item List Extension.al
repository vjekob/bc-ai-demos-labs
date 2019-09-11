pageextension 50101 "Item List Extension" extends "Item List"
{
    actions
    {
        addlast(Item)
        {
            action(ImageAnalysis)
            {
                Caption = 'Run Image Analysis';
                Image = Picture;
                ApplicationArea = All;

                trigger OnAction();
                var
                    Test: codeunit "Image Analysis Client";
                begin
                    Test.AnalyzeItemTags(Rec);
                end;
            }
        }
    }
}