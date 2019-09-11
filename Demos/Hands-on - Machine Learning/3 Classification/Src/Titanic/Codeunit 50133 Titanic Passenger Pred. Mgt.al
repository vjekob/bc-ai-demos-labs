codeunit 50133 "Titanic Passenger Pred. Mgt."
{
    local procedure GetSetup(var Setup: Record "Classification Setup");
    begin
        Setup.Get();
        Setup.TestField("API URI");
        Setup.TestField("API Key");
    end;

    procedure Train();
    var
        Setup: Record "Classification Setup";
        TitanicPassenger: Record "Titanic Passenger";
        Prediction: Codeunit "ML Prediction Management";
        Model: Text;
        ModelQuality: Decimal;
    begin
        GetSetup(Setup);
        Prediction.Initialize(Setup."API URI", Setup."API Key", 0);

        Prediction.SetRecord(TitanicPassenger);
        Prediction.AddFeature(TitanicPassenger.FieldNo(Class));
        Prediction.AddFeature(TitanicPassenger.FieldNo(Age));
        //Prediction.AddFeature(TitanicPassenger.FieldNo("Age is Known"));
        Prediction.AddFeature(TitanicPassenger.FieldNo(Sex));
        Prediction.SetLabel(TitanicPassenger.FieldNo(Survived));

        Prediction.Train(Model, ModelQuality);

        Setup.SetTitanicModel(Model);
        Setup."Titanic Predict. Model Quality" := ModelQuality;
        Setup.Modify(true);

        Message('Model is trained. Quality is %1%',
            Round(ModelQuality * 100, 1));
    end;

    procedure Predict(var TitanicPassenger: Record "Titanic Passenger" temporary);
    var
        Setup: Record "Classification Setup";
        Prediction: Codeunit "ML Prediction Management";
    begin
        GetSetup(Setup);
        Setup.TestField("Titanic Prediction Model");
        Prediction.Initialize(Setup."API URI", Setup."API Key", 0);

        Prediction.SetRecord(TitanicPassenger);
        Prediction.AddFeature(TitanicPassenger.FieldNo(Class));
        Prediction.AddFeature(TitanicPassenger.FieldNo(Age));
        //Prediction.AddFeature(TitanicPassenger.FieldNo("Age is Known"));
        Prediction.AddFeature(TitanicPassenger.FieldNo(Sex));
        Prediction.SetConfidence(TitanicPassenger.FieldNo(Confidence));
        Prediction.SetLabel(TitanicPassenger.FieldNo(Survived));

        Prediction.Predict(Setup.GetTitanicModel());
    end;
}