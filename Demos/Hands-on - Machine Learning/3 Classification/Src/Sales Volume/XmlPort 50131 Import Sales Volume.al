xmlport 50131 "Import Sales Volume"
{
    Format = VariableText;
    FieldSeparator = ';';
    Direction = Import;

    schema
    {
        textelement(root)
        {
            tableelement(Volume; "Sales Volume")
            {
                fieldelement(Price; Volume."Item No.") { }
                fieldelement(Gender; Volume."Posting Date") { }
                fieldelement(Material; Volume.Volume) { }
                fieldelement(SleeveLength; Volume.Color) { }
                fieldelement(IsChristmas; Volume.Size) { }
                fieldelement(DecemberSales; Volume.Price) { }
            }
        }
    }
}