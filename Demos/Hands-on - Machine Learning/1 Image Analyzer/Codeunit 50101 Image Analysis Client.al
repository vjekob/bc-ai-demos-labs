codeunit 50101 "Image Analysis Client"
{
    procedure AnalyzeItemTags(Item: Record Item)
    var
        ImageAnalysis: Codeunit "Image Analysis Management";
        Result: Codeunit "Image Analysis Result";
        ErrorMessage: Text;
        IsUsageLimitError: Boolean;
        i: Integer;
        Tags: Text;
    begin
        if Item.Picture.Count = 0 then
            Error('No media available for this item.');

        ImageAnalysis.Initialize();
        ImageAnalysis.SetMedia(Item.Picture.Item(1));
        if not ImageAnalysis.AnalyzeTags(Result) then begin
            ImageAnalysis.GetLastError(
                ErrorMessage,
                IsUsageLimitError);
            Error('Invocation error: %1', ErrorMessage);
        end;

        for i := 1 to Result.TagCount do begin
            Tags += StrSubstNo('%1 (%2)',
                Result.TagName(i),
                Result.TagConfidence(i));
            if (i < Result.TagCount) then
                Tags += ', ';
        end;
        Message('Tags identified: %1\\%2', Result.TagCount, Tags);
    end;

    procedure AnalyzeEmployeePhoto(Rec: Record Employee)
    var
        ImageAnalysis: Codeunit "Image Analysis Management";
        Result: Codeunit "Image Analysis Result";
        ErrorMessage: Text;
        IsUsageLimitError: Boolean;
        i: Integer;
        Faces: Text;
    begin
        if IsNullGuid(Rec.Image.MediaId) then
            Error('No picture available for this employee.');

        ImageAnalysis.Initialize();
        ImageAnalysis.SetMedia(Rec.Image.MediaId());
        if not ImageAnalysis.AnalyzeFaces(Result) then begin
            ImageAnalysis.GetLastError(
                ErrorMessage,
                IsUsageLimitError);
            Error('Invocation error: %1', ErrorMessage);
        end;

        for i := 1 to Result.FaceCount do begin
            Faces += StrSubstno('%1 (%2)',
                Result.FaceGender(i),
                Result.FaceAge(i));
            if (i < Result.FaceCount) then
                Faces += ', ';
        end;
        Message('Faces identified: %1\\%2', Result.FaceCount, Faces);
    end;

    procedure AnalyzeCompanyLogo(Rec: Record "Company Information")
    var
        TempBlob: Record TempBlob temporary;
        ImageAnalysis: Codeunit "Image Analysis Management";
        Result: Codeunit "Image Analysis Result";
        ErrorMessage: Text;
        IsUsageLimitError: Boolean;
        i: Integer;
        Tags: Text;
    begin
        if not Rec.Picture.HasValue() then
            Error('No media available for this item.');

        Rec.CalcFields(Picture);
        TempBlob.Blob := Rec.Picture;

        ImageAnalysis.Initialize();
        ImageAnalysis.SetBlob(TempBlob);
        if not ImageAnalysis.AnalyzeColors(Result) then begin
            ImageAnalysis.GetLastError(
                ErrorMessage,
                IsUsageLimitError);
            Error('Invocation error: %1', ErrorMessage);
        end;

        Message('Company logo is dominantly %1, on the %2 background.',
            Result.DominantColorForeground(),
            Result.DominantColorBackground());
    end;
}