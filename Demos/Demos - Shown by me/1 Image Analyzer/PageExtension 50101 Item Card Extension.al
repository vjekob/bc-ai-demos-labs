pageextension 50101 "Item Card Extension" extends "Item Card"
{
    actions
    {
        addlast(ItemActionGroup)
        {
            action(ImageAnalysis)
            {
                Caption = 'Validate Picture';
                Image = Picture;
                ApplicationArea = All;

                trigger OnAction();
                var
                    Test: codeunit "Image Analysis Client";
                    Tags: List of [Text];
                begin
                    if Test.AnalyzeItemPicture(Rec, Tags) then begin
                        Message('The picture seems to be spot on.');
                        exit;
                    end;

                    if Confirm('The image does not seem to represent an item in the %1 category.\\But hey, we might be wrong. If you believe the image is correct, do you want to help us better identify the picture next time?', false, "Item Category Code") then
                        ProcessTags(Tags);
                end;
            }
        }
    }

    local procedure ProcessTags(Tags: List of [Text]);
    var
        TagIdentification: Page "Tag Identification";
    begin
        TagIdentification.SetTags(Rec, Tags);
        if TagIdentification.RunModal() = Action::OK then
            TagIdentification.ApplyTags();
    end;
}