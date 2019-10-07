page 50140 "Computer Vision Demos"
{
    PageType = Card;
    UsageCategory = Tasks;
    ApplicationArea = All;

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
            action(RecognizeHandwriting)
            {
                Caption = 'Handwriting recognition';
                Image = Picture;
                ApplicationArea = All;

                trigger OnAction();
                var
                    TempBlob: Codeunit "Temp Blob";
                    FileMng: Codeunit "File Management";
                    ComputerVisionMgt: Codeunit "Computer Vision Management";
                begin
                    FileMng.BLOBImportWithFilter(TempBlob, 'Choose file', '', 'Images only|*.jpg', '*.jpg');
                    Message(ComputerVisionMgt.RecognizeHandwriting(TempBlob));
                end;
            }
        }
    }
}