codeunit 50140 "Computer Vision Management"
{
    var
        APIURI: Label 'https://westcentralus.api.cognitive.microsoft.com/vision/v2.0/%1%2';
        APIKey: Label '644766c8b846419cb4af52acc89b8917';

    local procedure Url(Command: Text; Parameters: Text): Text;
    begin
        if Parameters <> '' then
            Parameters := '?' + Parameters;

        exit(StrSubstNo(APIURI, Command, Parameters));
    end;

    local procedure Authorize(Headers: HttpHeaders);
    begin
        Headers.Add('Ocp-Apim-Subscription-Key', APIKey);
    end;

    local procedure SetContentType(Content: HttpContent; ContentType: Text);
    var
        Headers: HttpHeaders;
    begin
        Content.GetHeaders(Headers);
        Headers.Add('Content-Type', ContentType);
    end;

    local procedure MakeSureNoError(OperationSuccess: Boolean; ResponseMessage: HttpResponseMessage);
    var
        ResponseContent: Text;
    begin
        if (not OperationSuccess or (not ResponseMessage.IsSuccessStatusCode()))
        then begin
            ResponseMessage.Content.ReadAs(ResponseContent);
            Error('Something went wrong: %1', ResponseContent);
        end;
    end;

    local procedure PostBlob(Url: Text; TempBlob: Codeunit "Temp Blob"; var Response: HttpResponseMessage);
    var
        Client: HttpClient;
        Content: HttpContent;
        Headers: HttpHeaders;
        ResponseMessage: HttpResponseMessage;
        Stream: InStream;
    begin
        Content.GetHeaders(Headers);
        Headers.Clear();
        Authorize(Headers);
        SetContentType(Content, 'application/octet-stream');

        TempBlob.CreateInStream(Stream);
        Content.WriteFrom(Stream);
        MakeSureNoError(Client.Post(Url, Content, ResponseMessage), ResponseMessage);
        Response := ResponseMessage;
    end;

    local procedure Get(Url: Text; Response: HttpResponseMessage);
    var
        Client: HttpClient;
        Headers: HttpHeaders;
        ResponseMessage: HttpResponseMessage;
    begin
        Headers := Client.DefaultRequestHeaders();
        Authorize(Headers);
        MakeSureNoError(Client.Get(Url, ResponseMessage), ResponseMessage);
        Response := ResponseMessage;
    end;

    local procedure GetValue(JObject: JsonObject; JKey: Text): Text;
    var
        JToken: JsonToken;
    begin
        JObject.Get(JKey, JToken);
        exit(JToken.AsValue().AsText());
    end;

    local procedure GetObject(JObject: JsonObject; JKey: Text): JsonObject;
    var
        JToken: JsonToken;
    begin
        JObject.Get(JKey, JToken);
        exit(JToken.AsObject());
    end;

    local procedure GetArray(JObject: JsonObject; JKey: Text): JsonArray;
    var
        JToken: JsonToken;
    begin
        JObject.Get(JKey, JToken);
        exit(JToken.AsArray());
    end;

    local procedure GetRecognitionResult(JObject: JsonObject) Result: Text;
    var
        RecognitionResult: JsonObject;
        Lines: JsonArray;
        LineToken: JsonToken;
        Line: JsonObject;
    begin
        RecognitionResult := GetObject(JObject, 'recognitionResult');
        Lines := GetArray(RecognitionResult, 'lines');
        foreach LineToken in Lines do begin
            Line := LineToken.AsObject();
            if Result <> '' then Result += '\';
            Result += GetValue(Line, 'text');
        end;
    end;

    procedure RecognizeHandwriting(TempBlob: Codeunit "Temp Blob"): Text;
    var
        Response: HttpResponseMessage;
        Headers: HttpHeaders;
        Texts: array[1] of Text;
        ResponseUrl: Text;
        ResponseContent: Text;
        JObject: JsonObject;
        Success: Boolean;
    begin
        PostBlob(Url('recognizeText', 'mode=Handwritten'), TempBlob, Response);
        Response.Headers.GetValues('Operation-Location', Texts);
        ResponseUrl := Texts[1];
        Sleep(1000);
        repeat
            Get(ResponseUrl, Response);
            Response.Content.ReadAs(ResponseContent);
            JObject.ReadFrom(ResponseContent);
            Success := GetValue(JObject, 'status') <> 'Running';
            if not Success then
                Sleep(1000);
        until Success;

        exit(GetRecognitionResult(JObject));
    end;
}