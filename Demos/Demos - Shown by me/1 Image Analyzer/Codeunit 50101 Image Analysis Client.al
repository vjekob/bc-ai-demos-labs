codeunit 50101 "Image Analysis Client"
{
    procedure AnalyzeItemPicture(Item: Record Item; Tags: List of [Text]) Found: Boolean;
    var
        ItemCategoryTag: Record "Item Category Tag";
        ImageAnalysis: Codeunit "Image Analysis Management";
        Result: Codeunit "Image Analysis Result";
        ErrorMessage: Text;
        IsUsageLimitError: Boolean;
        i: Integer;
    begin
        Item.TestField("Item Category Code");
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
            Tags.Add(Result.TagName(i));
            Found := Found or ItemCategoryTag.Get(
                Item."Item Category Code",
                Result.TagName(i));
            if Found then
                exit;
        end;
    end;

    procedure AnalyzeEmployeePhoto(Rec: Record Employee);
    var
        ImageAnalysis: Codeunit "Image Analysis Management";
        Result: Codeunit "Image Analysis Result";
        ErrorMessage: Text;
        IsUsageLimitError: Boolean;
        Faces: Text;
        ExpectedAge: Integer;
        DetectedAge: Integer;
        AgeDifference: Integer;
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

        if Result.FaceCount() = 0 then
            Error('This is embarrassing, we could not identify a single face in that picture.');

        if Result.FaceCount() > 1 then
            Error('Do you also have a group photo in your passport? Come on, give us a single face.');

        if ((LowerCase(Result.FaceGender(1)) = 'male') and (Rec.Gender = Rec.Gender::Female)) or
            ((LowerCase(Result.FaceGender(1)) = 'female') and (Rec.Gender = Rec.Gender::Male))
        then begin
            if Rec.Gender = Rec.Gender::Male then
                Error('You must upload a picture of %1, not his sister.', Rec.FullName())
            else
                Error('You must upload a picture of %1, not her brother.', Rec.FullName());
        end;

        Rec.TestField("Birth Date");
        ExpectedAge := Date2DMY(Today, 3) - Date2DMY(Rec."Birth Date", 3);
        DetectedAge := Result.FaceAge(1);
        AgeDifference := DetectedAge - ExpectedAge;
        if Abs(AgeDifference) >= 3 then begin
            if Rec.Gender = Rec.Gender::Male then begin
                if AgeDifference < 0 then
                    Error('This seems to be %1''s younger brother.', Rec.FullName())
                else
                    Error('Who is this? %1''s father?', Rec.FullName());
            end else begin
                if AgeDifference < 0 then
                    Error('This seems to be %1''s younger sister.', Rec.FullName())
                else
                    Error('Who is this? %1''s mother?', Rec.FullName());
            end;
        end;

        Message('The picture seems to be ok.');
    end;
}