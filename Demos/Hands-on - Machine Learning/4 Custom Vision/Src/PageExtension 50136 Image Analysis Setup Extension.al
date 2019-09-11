pageextension 50136 "Image Analysis Setup Ext." extends "Image Analysis Setup"
{
    layout
    {
        addafter(General)
        {
            group("Custom Vision")
            {
                Caption = 'Custom Vision';

                field("Custom Vision API URI"; "Custom Vision API URI")
                {
                    ApplicationArea = All;
                }

                field("Custom Vision API Key"; "Custom Vision API Key")
                {
                    ApplicationArea = All;
                }

                field("Tag Confidence Threshold"; "Tag Confidence Threshold")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}