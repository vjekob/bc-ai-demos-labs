pageextension 50102 "Employee List Extension" extends "Employee List"
{
    actions
    {
        addlast("E&mployee")
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
                    Test.AnalyzeEmployeePhoto(Rec);
                end;
            }
        }
    }
}