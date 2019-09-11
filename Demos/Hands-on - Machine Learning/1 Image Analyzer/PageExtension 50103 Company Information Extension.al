pageextension 50103 "Company Information Extension" extends "Company Information"
{
    actions
    {
        addlast(Navigation)
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
                    Test.AnalyzeCompanyLogo(Rec);
                end;
            }
        }
    }
}