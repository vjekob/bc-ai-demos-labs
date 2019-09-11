codeunit 50131 "Sales Volume Classif. Mgt."
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
        SalesVolume: Record "Sales Volume";
        Prediction: Codeunit "ML Prediction Management";
        Model: Text;
        ModelQuality: Decimal;
    begin
        GetSetup(Setup);
        Prediction.Initialize(Setup."API URI", Setup."API Key", 0);

        Prediction.SetRecord(SalesVolume);
        Prediction.AddFeature(SalesVolume.FieldNo(Color));
        Prediction.AddFeature(SalesVolume.FieldNo(Size));
        Prediction.AddFeature(SalesVolume.FieldNo(Price));
        Prediction.SetLabel(SalesVolume.FieldNo(Volume));

        Prediction.Train(Model, ModelQuality);

        Setup.SetModel(Model);
        Setup."Sales Volume Model Quality" := ModelQuality;
        Setup.Modify(true);

        Message('Model is trained. Quality is %1%',
            Round(ModelQuality * 100, 1));
    end;

    procedure Predict(var SalesVolumeTemp: Record "Sales Volume" temporary);
    var
        Setup: Record "Classification Setup";
        Prediction: Codeunit "ML Prediction Management";
    begin
        GetSetup(Setup);
        Setup.TestField("Sales Volume Model");
        Prediction.Initialize(Setup."API URI", Setup."API Key", 0);

        Prediction.SetRecord(SalesVolumeTemp);
        Prediction.AddFeature(SalesVolumeTemp.FieldNo(Color));
        Prediction.AddFeature(SalesVolumeTemp.FieldNo(Size));
        Prediction.AddFeature(SalesVolumeTemp.FieldNo(Price));
        Prediction.SetConfidence(SalesVolumeTemp.FieldNo(Confidence));
        Prediction.SetLabel(SalesVolumeTemp.FieldNo(Volume));

        Prediction.Predict(Setup.GetModel());
    end;
}