codeunit 50119 "Items History Generator"
{
    var
        LineNo: Integer;

    trigger OnRun()
    begin
        PrepareItemJournalTemplateIfNeeded();
        PrepareItemJournalBatchIfNeeded();
        FixILE();
        InsertItemJnlLine('1896-S', 9, 0);
        InsertItemJnlLine('1896-S', 13, 1);
        InsertItemJnlLine('1896-S', 15, 2);
        InsertItemJnlLine('1896-S', 18, 3);
        InsertItemJnlLine('1896-S', 14, 4);
        InsertItemJnlLine('1896-S', 15, 5);
        InsertItemJnlLine('1896-S', 10, 6);
        InsertItemJnlLine('1896-S', 11, 7);
        InsertItemJnlLine('1896-S', 9, 8);
        InsertItemJnlLine('1896-S', 9, 9);
        InsertItemJnlLine('1896-S', 8, 10);
        InsertItemJnlLine('1896-S', 6, 11);
        InsertItemJnlLine('1896-S', 10, 12);
        InsertItemJnlLine('1896-S', 15, 13);
        InsertItemJnlLine('1896-S', 18, 14);
        InsertItemJnlLine('1896-S', 9, 15);
        InsertItemJnlLine('1896-S', 13, 16);
        InsertItemJnlLine('1896-S', 15, 17);
        InsertItemJnlLine('1896-S', 18, 18);
        InsertItemJnlLine('1896-S', 14, 19);
        InsertItemJnlLine('1896-S', 15, 20);
        InsertItemJnlLine('1896-S', 10, 21);
        InsertItemJnlLine('1896-S', 11, 22);
        InsertItemJnlLine('1896-S', 9, 23);
        InsertItemJnlLine('1896-S', 9, 24);
        InsertItemJnlLine('1896-S', 8, 25);
        InsertItemJnlLine('1896-S', 6, 26);
        InsertItemJnlLine('1896-S', 10, 27);
        InsertItemJnlLine('1896-S', 15, 28);
        InsertItemJnlLine('1896-S', 18, 29);
        InsertItemJnlLine('1896-S', 9, 30);
        InsertItemJnlLine('1896-S', 13, 31);
        InsertItemJnlLine('1896-S', 15, 32);
        InsertItemJnlLine('1896-S', 18, 33);
        InsertItemJnlLine('1896-S', 14, 34);
        InsertItemJnlLine('1896-S', 15, 35);
        InsertItemJnlLine('1896-S', 10, 36);
        InsertItemJnlLine('1896-S', 11, 37);

        InsertItemJnlLine('1900-S', 8, 0);
        InsertItemJnlLine('1900-S', 10, 1);
        InsertItemJnlLine('1900-S', 11, 2);
        InsertItemJnlLine('1900-S', 11, 3);
        InsertItemJnlLine('1900-S', 7, 4);
        InsertItemJnlLine('1900-S', 7, 5);
        InsertItemJnlLine('1900-S', 8, 6);
        InsertItemJnlLine('1900-S', 8, 7);
        InsertItemJnlLine('1900-S', 4, 8);
        InsertItemJnlLine('1900-S', 6, 9);
        InsertItemJnlLine('1900-S', 7, 10);
        InsertItemJnlLine('1900-S', 3, 11);
        InsertItemJnlLine('1900-S', 8, 12);
        InsertItemJnlLine('1900-S', 12, 13);
        InsertItemJnlLine('1900-S', 10, 14);

        InsertItemJnlLine('1906-S', 6, 0);
        InsertItemJnlLine('1906-S', 8, 1);
        InsertItemJnlLine('1906-S', 9, 2);
        InsertItemJnlLine('1906-S', 9, 3);
        InsertItemJnlLine('1906-S', 6, 4);
        InsertItemJnlLine('1906-S', 5, 5);
        InsertItemJnlLine('1906-S', 7, 6);
        InsertItemJnlLine('1906-S', 7, 7);
        InsertItemJnlLine('1906-S', 3, 8);
        InsertItemJnlLine('1906-S', 10, 9);
        InsertItemJnlLine('1906-S', 6, 10);
        InsertItemJnlLine('1906-S', 2, 11);
        InsertItemJnlLine('1906-S', 6, 12);
        InsertItemJnlLine('1906-S', 10, 13);
        InsertItemJnlLine('1906-S', 10, 14);

        InsertItemJnlLine('1908-S', 5, 0);
        InsertItemJnlLine('1908-S', 5, 1);
        InsertItemJnlLine('1908-S', 6, 2);
        InsertItemJnlLine('1908-S', 6, 3);
        InsertItemJnlLine('1908-S', 5, 4);
        InsertItemJnlLine('1908-S', 5, 5);
        InsertItemJnlLine('1908-S', 4, 6);
        InsertItemJnlLine('1908-S', 6, 7);
        InsertItemJnlLine('1908-S', 4, 8);
        InsertItemJnlLine('1908-S', 4, 9);
        InsertItemJnlLine('1908-S', 4, 10);
        InsertItemJnlLine('1908-S', 3, 11);
        InsertItemJnlLine('1908-S', 5, 12);
        InsertItemJnlLine('1908-S', 6, 13);
        InsertItemJnlLine('1908-S', 7, 14);

        InsertItemJnlLine('1920-S', 5, 0);
        InsertItemJnlLine('1920-S', 4, 1);
        InsertItemJnlLine('1920-S', 7, 2);
        InsertItemJnlLine('1920-S', 6, 3);
        InsertItemJnlLine('1920-S', 7, 4);
        InsertItemJnlLine('1920-S', 5, 5);
        InsertItemJnlLine('1920-S', 5, 6);
        InsertItemJnlLine('1920-S', 6, 7);
        InsertItemJnlLine('1920-S', 4, 8);
        InsertItemJnlLine('1920-S', 4, 9);
        InsertItemJnlLine('1920-S', 4, 10);
        InsertItemJnlLine('1920-S', 2, 11);
        InsertItemJnlLine('1920-S', 6, 12);
        InsertItemJnlLine('1920-S', 6, 13);
        InsertItemJnlLine('1920-S', 6, 14);

        InsertItemJnlLine('1928-S', 10, 0);
        InsertItemJnlLine('1928-S', 11, 1);
        InsertItemJnlLine('1928-S', 13, 2);
        InsertItemJnlLine('1928-S', 13, 3);
        InsertItemJnlLine('1928-S', 11, 4);
        InsertItemJnlLine('1928-S', 13, 5);
        InsertItemJnlLine('1928-S', 11, 6);
        InsertItemJnlLine('1928-S', 10, 7);
        InsertItemJnlLine('1928-S', 9, 8);
        InsertItemJnlLine('1928-S', 10, 9);
        InsertItemJnlLine('1928-S', 9, 10);
        InsertItemJnlLine('1928-S', 6, 11);
        InsertItemJnlLine('1928-S', 11, 12);
        InsertItemJnlLine('1928-S', 13, 13);
        InsertItemJnlLine('1928-S', 16, 14);

        InsertItemJnlLine('1936-S', 8, 0);
        InsertItemJnlLine('1936-S', 9, 1);
        InsertItemJnlLine('1936-S', 10, 2);
        InsertItemJnlLine('1936-S', 11, 3);
        InsertItemJnlLine('1936-S', 9, 4);
        InsertItemJnlLine('1936-S', 10, 5);
        InsertItemJnlLine('1936-S', 8, 6);
        InsertItemJnlLine('1936-S', 9, 7);
        InsertItemJnlLine('1936-S', 7, 8);
        InsertItemJnlLine('1936-S', 9, 9);
        InsertItemJnlLine('1936-S', 7, 10);
        InsertItemJnlLine('1936-S', 5, 11);
        InsertItemJnlLine('1936-S', 9, 12);
        InsertItemJnlLine('1936-S', 11, 13);
        InsertItemJnlLine('1936-S', 13, 14);

        InsertItemJnlLine('1960-S', 7, 0);
        InsertItemJnlLine('1960-S', 7, 1);
        InsertItemJnlLine('1960-S', 9, 2);
        InsertItemJnlLine('1960-S', 9, 3);
        InsertItemJnlLine('1960-S', 8, 4);
        InsertItemJnlLine('1960-S', 8, 5);
        InsertItemJnlLine('1960-S', 7, 6);
        InsertItemJnlLine('1960-S', 7, 7);
        InsertItemJnlLine('1960-S', 5, 8);
        InsertItemJnlLine('1960-S', 6, 9);
        InsertItemJnlLine('1960-S', 6, 10);
        InsertItemJnlLine('1960-S', 4, 11);
        InsertItemJnlLine('1960-S', 7, 12);
        InsertItemJnlLine('1960-S', 8, 13);
        InsertItemJnlLine('1960-S', 9, 14);

        InsertItemJnlLine('1964-S', 5, 0);
        InsertItemJnlLine('1964-S', 5, 1);
        InsertItemJnlLine('1964-S', 6, 2);
        InsertItemJnlLine('1964-S', 6, 3);
        InsertItemJnlLine('1964-S', 5, 4);
        InsertItemJnlLine('1964-S', 5, 5);
        InsertItemJnlLine('1964-S', 4, 6);
        InsertItemJnlLine('1964-S', 6, 7);
        InsertItemJnlLine('1964-S', 4, 8);
        InsertItemJnlLine('1964-S', 4, 9);
        InsertItemJnlLine('1964-S', 4, 10);
        InsertItemJnlLine('1964-S', 2, 11);
        InsertItemJnlLine('1964-S', 6, 12);
        InsertItemJnlLine('1964-S', 5, 13);
        InsertItemJnlLine('1964-S', 7, 14);

        InsertItemJnlLine('1968-S', 6, 0);
        InsertItemJnlLine('1968-S', 6, 1);
        InsertItemJnlLine('1968-S', 8, 2);
        InsertItemJnlLine('1968-S', 9, 3);
        InsertItemJnlLine('1968-S', 8, 4);
        InsertItemJnlLine('1968-S', 8, 5);
        InsertItemJnlLine('1968-S', 7, 6);
        InsertItemJnlLine('1968-S', 8, 7);
        InsertItemJnlLine('1968-S', 5, 8);
        InsertItemJnlLine('1968-S', 9, 9);
        InsertItemJnlLine('1968-S', 6, 10);
        InsertItemJnlLine('1968-S', 4, 11);
        InsertItemJnlLine('1968-S', 7, 12);
        InsertItemJnlLine('1968-S', 6, 13);
        InsertItemJnlLine('1968-S', 8, 14);

        InsertItemJnlLine('1972-S', 7, 0);
        InsertItemJnlLine('1972-S', 7, 1);
        InsertItemJnlLine('1972-S', 9, 2);
        InsertItemJnlLine('1972-S', 10, 3);
        InsertItemJnlLine('1972-S', 9, 4);
        InsertItemJnlLine('1972-S', 10, 5);
        InsertItemJnlLine('1972-S', 6, 6);
        InsertItemJnlLine('1972-S', 6, 7);
        InsertItemJnlLine('1972-S', 5, 8);
        InsertItemJnlLine('1972-S', 7, 9);
        InsertItemJnlLine('1972-S', 5, 10);
        InsertItemJnlLine('1972-S', 3, 11);
        InsertItemJnlLine('1972-S', 6, 12);
        InsertItemJnlLine('1972-S', 7, 13);
        InsertItemJnlLine('1972-S', 9, 14);

        InsertItemJnlLine('1980-S', 4, 0);
        InsertItemJnlLine('1980-S', 4, 1);
        InsertItemJnlLine('1980-S', 6, 2);
        InsertItemJnlLine('1980-S', 5, 3);
        InsertItemJnlLine('1980-S', 5, 4);
        InsertItemJnlLine('1980-S', 5, 5);
        InsertItemJnlLine('1980-S', 4, 6);
        InsertItemJnlLine('1980-S', 4, 7);
        InsertItemJnlLine('1980-S', 3, 8);
        InsertItemJnlLine('1980-S', 3, 9);
        InsertItemJnlLine('1980-S', 3, 10);
        InsertItemJnlLine('1980-S', 2, 11);
        InsertItemJnlLine('1980-S', 4, 12);
        InsertItemJnlLine('1980-S', 4, 13);
        InsertItemJnlLine('1980-S', 5, 14);

        InsertItemJnlLine('1988-S', 5, 0);
        InsertItemJnlLine('1988-S', 5, 1);
        InsertItemJnlLine('1988-S', 6, 2);
        InsertItemJnlLine('1988-S', 5, 3);
        InsertItemJnlLine('1988-S', 6, 4);
        InsertItemJnlLine('1988-S', 6, 5);
        InsertItemJnlLine('1988-S', 3, 6);
        InsertItemJnlLine('1988-S', 4, 7);
        InsertItemJnlLine('1988-S', 4, 8);
        InsertItemJnlLine('1988-S', 5, 9);
        InsertItemJnlLine('1988-S', 5, 10);
        InsertItemJnlLine('1988-S', 3, 11);
        InsertItemJnlLine('1988-S', 5, 12);
        InsertItemJnlLine('1988-S', 6, 13);
        InsertItemJnlLine('1988-S', 7, 14);

        InsertItemJnlLine('1996-S', 7, 0);
        InsertItemJnlLine('1996-S', 6, 1);
        InsertItemJnlLine('1996-S', 10, 2);
        InsertItemJnlLine('1996-S', 10, 3);
        InsertItemJnlLine('1996-S', 9, 4);
        InsertItemJnlLine('1996-S', 9, 5);
        InsertItemJnlLine('1996-S', 7, 6);
        InsertItemJnlLine('1996-S', 9, 7);
        InsertItemJnlLine('1996-S', 7, 8);
        InsertItemJnlLine('1996-S', 7, 9);
        InsertItemJnlLine('1996-S', 6, 10);
        InsertItemJnlLine('1996-S', 4, 11);
        InsertItemJnlLine('1996-S', 7, 12);
        InsertItemJnlLine('1996-S', 10, 13);
        InsertItemJnlLine('1996-S', 12, 14);

        InsertItemJnlLine('2000-S', 5, 0);
        InsertItemJnlLine('2000-S', 5, 1);
        InsertItemJnlLine('2000-S', 7, 2);
        InsertItemJnlLine('2000-S', 8, 3);
        InsertItemJnlLine('2000-S', 7, 4);
        InsertItemJnlLine('2000-S', 7, 5);
        InsertItemJnlLine('2000-S', 5, 6);
        InsertItemJnlLine('2000-S', 7, 7);
        InsertItemJnlLine('2000-S', 5, 8);
        InsertItemJnlLine('2000-S', 6, 9);
        InsertItemJnlLine('2000-S', 5, 10);
        InsertItemJnlLine('2000-S', 3, 11);
        InsertItemJnlLine('2000-S', 5, 12);
        InsertItemJnlLine('2000-S', 7, 13);
        InsertItemJnlLine('2000-S', 8, 14);

        Page.Run(PAGE::"Item Journal");
    end;

    local procedure PrepareItemJournalTemplateIfNeeded();
    var
        ItemJnlTempl: Record "Item Journal Template";
    begin
        ItemJnlTempl.Name := 'ITEM';
        if ItemJnlTempl.Find('=') then
            exit;

        ItemJnlTempl.Description := 'Item Journal Template';
        ItemJnlTempl.Validate(Type, ItemJnlTempl.Type::Item);
        ItemJnlTempl.Validate("No. Series", 'IJNL-GEN');
        ItemJnlTempl.Insert(false);
    end;

    local procedure PrepareItemJournalBatchIfNeeded();
    var
        ItemJnlBatch: Record "Item Journal Batch";
    begin
        ItemJnlBatch.Name := 'DEFAULT';
        ItemJnlBatch."Journal Template Name" := 'ITEM';
        IF ItemJnlBatch.Find('=') then
            exit;

        ItemJnlBatch.Description := 'Default Journal';
        ItemJnlBatch.Validate("No. Series", 'IJNL-GEN');
        ItemJnlBatch.Insert(false);
    end;

    local procedure InsertItemJnlLine(ItemNo: Code[20]; Qty: Decimal; DateOffset: Integer)
    var
        ItemJournalLine: Record 83;
        ItemJnlBatch: Record 233;
        NoSeriesMgt: Codeunit 396;
    begin
        ItemJournalLine.Init();
        ItemJournalLine."Journal Batch Name" := 'DEFAULT';
        ItemJournalLine."Journal Template Name" := 'ITEM';
        LineNo += 10;
        ItemJournalLine."Line No." := LineNo;
        ItemJournalLine.Insert(true);

        ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::Sale);
        ItemJournalLine.Validate("Posting Date", CALCDATE('<-' + Format(DateOffset) + 'M>', WorkDate()));

        ItemJnlBatch.GET(ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name");
        If ItemJnlBatch."No. Series" <> '' then
            ItemJournalLine."Document No." := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", ItemJournalLine."Posting Date", FALSE);

        ItemJournalLine.Validate("Item No.", ItemNo);
        ItemJournalLine.Validate(Quantity, Qty);

        //ItemJournalLine.Validate("Gen. Bus. Posting Group",'DOMESTIC');
        ItemJournalLine.Validate("Gen. Prod. Posting Group", 'RETAIL');
        ItemJournalLine.Modify(true);
    end;

    local procedure FixILE()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetFilter("Item No.", '????-S');
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.ModifyAll("Entry Type", ItemLedgerEntry."Entry Type"::"Negative Adjmt.", FALSE);
    end;
}

