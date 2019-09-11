codeunit 50150 Luis
{
    local procedure GetLuisResponse(Utterance: Text) Result: JsonObject;
    var
        Url: Text;
        Client: HttpClient;
        Response: HttpResponseMessage;
        TextContent: Text;
    begin
        Url := StrSubstNo('https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/00ec542a-e832-4aa0-9df1-852d4b4a9841?staging=true&verbose=true&timezoneOffset=-360&subscription-key=deaa6b6fd2d547f0a927e2142ff5827f&q=%1', Utterance);
        Client.Get(Url, Response);
        Response.Content.ReadAs(TextContent);
        Result.ReadFrom(TextContent);
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

    local procedure GetIntent(Luis: JsonObject): Text;
    var
        TopScore: JsonObject;
    begin
        TopScore := GetObject(Luis, 'topScoringIntent');
        exit(GetValue(TopScore, 'intent'));
    end;

    local procedure GetEntityByType(Luis: JsonObject; RequestedType: Text): Text;
    var
        Entities: JsonArray;
        Entity: JsonToken;
        EntityObj: JsonObject;
        EntityValue: Text;
        EntityType: Text;
    begin
        Entities := GetArray(Luis, 'entities');
        if (Entities.Count() = 0) then
            exit;

        foreach Entity in Entities do begin
            EntityObj := Entity.AsObject();
            EntityValue := GetValue(EntityObj, 'entity');
            EntityType := GetValue(EntityObj, 'type');
            if EntityType.StartsWith(RequestedType) then
                exit(EntityValue);
        end;
    end;

    procedure ProcessUtterance(Utterance: Text);
    var
        IntentManagement: Codeunit "LUIS Intent Management";
        LuisResponse: JsonObject;
        Entity: Text;
        EntityType: Text;
        Item: Text;
        Url: Text;
    begin
        LuisResponse := GetLuisResponse(Utterance);

        BindSubscription(IntentManagement);

        case GetIntent(LuisResponse) of
            'Customer.Create':
                begin
                    Entity := GetEntityByType(LuisResponse, 'BC.Customer');
                    IntentManagement.CustomerCreate(Entity);
                end;
            'Customer.SetImage':
                begin
                    Entity := GetEntityByType(LuisResponse, 'BC.Customer');
                    Url := GetEntityByType(LuisResponse, 'builtin.url');
                    IntentManagement.CustomerSetImage(Entity, Url);
                end;
            'Customer.OpenCard':
                begin
                    Entity := GetEntityByType(LuisResponse, 'BC.Customer');
                    IntentManagement.CustomerOpenCard(Entity);
                end;
            'Customer.Delete':
                begin
                    Entity := GetEntityByType(LuisResponse, 'BC.Customer');
                    IntentManagement.CustomerDelete(Entity);
                end;
            'SalesOrder.Create':
                begin
                    Entity := GetEntityByType(LuisResponse, 'BC.Customer');
                    Item := GetEntityByType(LuisResponse, 'BC.Item');
                    IntentManagement.SalesOrderCreate(Entity, Item);
                end;
        end;

        UnbindSubscription(IntentManagement);
    end;
}