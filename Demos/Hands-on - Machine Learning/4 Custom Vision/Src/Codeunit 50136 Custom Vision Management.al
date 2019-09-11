codeunit 50136 "Custom Vision Management"
{
    SingleInstance = true;

    var
        ListType: List of [Text];
        ListAge: List of [Text];
        ListGender: List of [Text];
        TypeIDs: List of [Integer];
        AgeIDs: List of [Integer];
        GenderIDs: List of [Integer];
        TypeAttributeID: Integer;
        AgeAttributeID: Integer;
        GenderAttributeID: Integer;
        Initialized: Boolean;

    procedure Initialize();
    var
        LabelType: Label 'Human,Animal';
        LabelAge: Label 'Adult,Child';
        LabelGender: Label 'Male,Female';
    begin
        if Initialized then
            exit;

        ListType := Format(LabelType).Split(',');
        ListAge := Format(LabelAge).Split(',');
        ListGender := Format(LabelGender).Split(',');
        InitializeAtributes();

        Initialized := true;
    end;

    procedure SuggestItemAttributes(Item: Record Item);
    var
        CustomVisionTag: Record "Custom Vision Tag" temporary;
        AttrTypeValue: Integer;
        AttrAgeValue: Integer;
        AttrGenderValue: Integer;
    begin
        PerformTagAnalysis(Item, CustomVisionTag);

        AttrTypeValue := MatchAttribute(CustomVisionTag, ListType, TypeIDs);
        AttrAgeValue := MatchAttribute(CustomVisionTag, ListAge, AgeIDs);
        AttrGenderValue := MatchAttribute(CustomVisionTag, ListGender, GenderIDs);

        UpdateItemAttribute(Item, TypeAttributeID, AttrTypeValue);
        UpdateItemAttribute(Item, AgeAttributeID, AttrAgeValue);
        UpdateItemAttribute(Item, GenderAttributeID, AttrGenderValue);
    end;

    local procedure GetAttributeValueID(AttrID: Integer; AttrVal: Text): Integer;
    var
        ItemAttrVal: Record "Item Attribute Value";
    begin
        with ItemAttrVal do begin
            SetRange("Attribute ID", AttrID);
            SetRange(Value, AttrVal);
            if not FindFirst() then begin
                Reset();
                SetCurrentKey(ID);
                if FindLast() then;

                Init();
                "Attribute ID" := AttrID;
                ID += 1;
                Value := AttrVal;
                Insert();
            end;

            exit(ID);
        end;
    end;

    local procedure GetAttributeID(Attr: Text; Values: List of [Text]; ValueIDs: List of [Integer]): Integer;
    var
        ItemAttr: Record "Item Attribute";
        AttrVal: Text;
    begin
        with ItemAttr do begin
            SetRange(Name, Attr);
            if not FindFirst() then begin
                Reset();
                if FindLast() then;

                ID += 1;
                Init();
                Name := Attr;
                Type := ItemAttr.Type::Option;
                Insert();
            end;

            foreach AttrVal in Values do
                ValueIDs.Add(GetAttributeValueID(ID, AttrVal));

            exit(ID);
        end;
    end;

    local procedure InitializeAtributes();
    var
        LabelType: Label 'Figurine Type';
        LabelAge: Label 'Figurine Age';
        LabelGender: Label 'Figurine Gender';
    begin
        TypeAttributeID := GetAttributeID(LabelType, ListType, TypeIDs);
        AgeAttributeID := GetAttributeID(LabelAge, ListAge, AgeIDs);
        GenderAttributeID := GetAttributeID(LabelGender, ListGender, GenderIDs);
    end;

    local procedure PerformTagAnalysis(Item: Record Item; var CustomVisionTag: Record "Custom Vision Tag" temporary);
    var
        ImageAnalysisSetup: Record "Image Analysis Setup";
        ImageAnalysis: Codeunit "Image Analysis Management";
        Result: Codeunit "Image Analysis Result";
        ErrorMessage: Text;
        IsUsageLimitError: Boolean;
        EntryNo: Integer;
        i: Integer;
        ii: Integer;
    begin
        if Item.Picture.Count = 0 then
            Error('No media available for this item.');

        ImageAnalysisSetup.Get();
        ImageAnalysisSetup.TestField("Custom Vision API URI");
        ImageAnalysisSetup.TestField("Custom Vision API Key");

        ImageAnalysis.SetUriAndKey(
            ImageAnalysisSetup."Custom Vision API URI",
            ImageAnalysisSetup."Custom Vision API Key");
        ImageAnalysis.Initialize();

        for i := 1 to Item.Picture.Count do begin
            ImageAnalysis.SetMedia(Item.Picture.Item(i));
            if not ImageAnalysis.AnalyzeTags(Result) then begin
                ImageAnalysis.GetLastError(
                    ErrorMessage,
                    IsUsageLimitError);
                Error('Invocation error: %1', ErrorMessage);
            end;

            for ii := 1 to Result.TagCount do begin
                if Result.TagConfidence(ii) >= ImageAnalysisSetup."Tag Confidence Threshold" then begin
                    EntryNo += 1;
                    CustomVisionTag.Init();
                    CustomVisionTag."Entry No." := EntryNo;
                    CustomVisionTag.Tag := Result.TagName(ii);
                    CustomVisionTag.Confidence := Result.TagConfidence(ii);
                    CustomVisionTag.Insert();
                end;
            end;
        end;
    end;

    local procedure MatchAttribute(var CustomVisionTag: Record "Custom Vision Tag" temporary; Tags: List of [Text]; Values: List of [Integer]): Integer;
    var
        TagConfidences: List of [Decimal];
        Tag: Text;
        TagCount: Integer;
        BestConfidenceIndex: Integer;
        i: Integer;
        TagConfidence: Decimal;
        BestConfidence: Decimal;
    begin
        foreach Tag in Tags do begin
            TagCount := 0;
            TagConfidence := 0;

            CustomVisionTag.SetRange(Tag, Tag);
            if CustomVisionTag.FindSet() then
                repeat
                    TagCount += 1;
                    if TagCount = 1 then
                        TagConfidence := CustomVisionTag.Confidence
                    else
                        TagConfidence *= CustomVisionTag.Confidence;
                until CustomVisionTag.Next() = 0;

            if TagCount > 0 then
                TagConfidence := Power(TagConfidence, 1 / TagCount);
            TagConfidences.Add(TagConfidence);
        end;

        for i := 1 to TagConfidences.Count do begin
            TagConfidence := TagConfidences.Get(i);
            if TagConfidence > BestConfidence then begin
                BestConfidence := TagConfidence;
                BestConfidenceIndex := i;
            end;
        end;

        if BestConfidenceIndex > 0 then
            exit(Values.Get(BestConfidenceIndex))
    end;

    local procedure UpdateItemAttribute(Item: Record Item; ID: Integer; ValueID: Integer);
    var
        ItemAttrValMap: Record "Item Attribute Value Mapping";
    begin
        with ItemAttrValMap do begin
            "Table ID" := Database::Item;
            "No." := Item."No.";
            "Item Attribute ID" := ID;
            if Find() then
                Delete();

            if ValueID = 0 then
                exit;

            "Item Attribute Value ID" := ValueID;
            Insert();
        end;
    end;
}