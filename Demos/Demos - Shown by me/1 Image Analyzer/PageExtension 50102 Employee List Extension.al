pageextension 50102 "Employee Card Extension" extends "Employee Card"
{
    actions
    {
        addlast("E&mployee")
        {
            action(ImageAnalysis)
            {
                Caption = 'Validate Picture';
                Image = Picture;
                ApplicationArea = All;

                trigger OnAction();
                var
                    Test: codeunit "Image Analysis Client";
                begin
                    Test.AnalyzeEmployeePhoto(Rec);
                end;
            }
        }
    }
}