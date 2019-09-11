xmlport 50133 "Import Titanic Passengers"
{
    Format = VariableText;
    FieldSeparator = ';';
    Direction = Import;

    schema
    {
        textelement(root)
        {
            tableelement(TitanicPassenger; "Titanic Passenger")
            {
                fieldelement(Name; TitanicPassenger.Name) { }
                fieldelement(Class; TitanicPassenger.Class) { }
                textelement(Age)
                {
                    trigger OnAfterAssignVariable();
                    begin
                        TitanicPassenger.Age := 0;
                        TitanicPassenger."Age is Known" := false;
                        if Age <> '' then begin
                            Evaluate(TitanicPassenger.Age, Age);
                            TitanicPassenger."Age is Known" := true;
                        end;
                    end;
                }
                fieldelement(Sex; TitanicPassenger.Sex) { }
                fieldelement(Survived; TitanicPassenger.Survived) { }
            }
        }
    }
}