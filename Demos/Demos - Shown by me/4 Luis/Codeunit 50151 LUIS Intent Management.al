codeunit 50151 "LUIS Intent Management"
{
    EventSubscriberInstance = Manual;

    var
        EntityName: Text;
        ActionProcessed: Boolean;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnCustomerCreate(var Rec: Record Customer);
    begin
        if ActionProcessed then
            exit;

        Rec.Name := EntityName;
        ActionProcessed := true;
    end;

    procedure CustomerCreate(Entity: Text);
    var
        Cust: Record Customer;
        CustFind: Record Customer;
        CustomerExists: Label 'Customer "%1" already exists. Do you want to edit it instead?';
        CustomerAnother: Label 'Do you really want to create another customer named "%1"?';
        CreateNew: Boolean;
    begin
        EntityName := Entity;
        CreateNew := true;
        CustFind.SetFilter(Name, StrSubstNo('@%1', Entity));
        if CustFind.FindFirst() then begin
            if not Confirm(CustomerExists, false, CustFind.Name) then begin
                if not Confirm(CustomerAnother, false, CustFind.Name) then
                    exit;
            end else begin
                Cust := CustFind;
                CreateNew := false;
            end;
        end;

        if CreateNew then begin
            Cust.Name := Entity;
            Cust.Insert(true);
            Commit();
        end;

        Page.RunModal(Page::"Customer Card", Cust);
    end;

    procedure CustomerSetImage(Entity: Text; Url: Text);
    var
        CustFind: Record Customer;
        Cust: Record Customer;
        CLient: HttpClient;
        REsponse: HttpResponseMessage;
        Stream: InStream;
        Media: Record "Tenant Media";
        FileId: Text;
    begin
        CustFind.SetFilter(Name, StrSubstNo('@%1', Entity));
        if CustFind.FindFirst() then begin
            Cust.Get(CustFind."No.");
            //Client.Get(Url, Response);
            TryDownloadFromUrl(Stream, Url);
            //Response.COntent.ReadAs(Stream);
            FileId := CreateGuid;
            Cust.Image.ImportStream(Stream, FileId);
            Cust.Modify(true);
        end;
    end;

    local procedure TryDownloadFromUrl(var InStream: InStream; Url: Text)
    var
        HttClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
    begin
        HttClient.Get(url, HttpResponseMessage);
        HttpResponseMessage.Content.ReadAs(InStream);
        TempBlob.CreateOutStream(OutStream);
        CopyStream(OutStream, InStream);
    end;

    procedure CustomerOpenCard(Entity: Text);
    var
        CustFind: Record Customer;
    begin
        CustFind.SetFilter(Name, StrSubstNo('@%1', Entity));
        if CustFind.FindFirst() then begin
            Page.Run(Page::"Customer Card", CustFind);
        end;
    end;

    procedure CustomerDelete(Entity: Text);
    var
        CustFind: Record Customer;
    begin
        CustFind.SetFilter(Name, StrSubstNo('@%1', Entity));
        if CustFind.FindFirst() then begin
            if not Confirm('Awwwww, come on! Really?') then
                exit;

            CustFind.Delete(true);
        end else
            Message('No such customer. Good for them! What kind of person deletes customers anyway?');
    end;

    procedure SalesOrderCreate(EntityCustomer: Text; EntityItem: Text);
    var
        Cust: Record Customer;
        Item: Record Item;
        SalesOrder: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        Cust.SetFilter(Name, StrSubstNo('@%1', EntityCustomer));
        if not Cust.FindFirst() then begin
            Message('No such customer: %1', EntityCustomer);
            exit;
        end;
        Item.SetFilter(Description, StrSubstNo('@*%1*', EntityItem));
        if not Item.FindFirst() then begin
            Message('No such item: %1', EntityItem);
            exit;
        end;

        SalesOrder."Document Type" := SalesOrder."Document Type"::Order;
        SalesOrder.Insert(true);
        SalesOrder.Validate("Sell-to Customer No.", Cust."No.");
        SalesOrder.Modify(true);

        SalesLine."Document Type" := SalesLine."Document Type"::Order;
        SalesLine."Document No." := SalesOrder."No.";
        SalesLine.Insert(true);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", Item."No.");
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify(true);

        Page.Run(Page::"Sales Order", SalesOrder);
    end;
}