tableextension 50136 "Image Analysis Setup Ext." extends "Image Analysis Setup"
{
    fields
    {
        field(50136; "Custom Vision API URI"; Text[250])
        {
            Caption = 'Custom Vision API URI';
        }

        field(50137; "Custom Vision API Key"; Text[250])
        {
            Caption = 'Custom Vision API Key';
        }

        field(50138; "Tag Confidence Threshold"; Decimal)
        {
            Caption = 'Tag Confidence Threshold';
            InitValue = 0.5;
        }
    }
}