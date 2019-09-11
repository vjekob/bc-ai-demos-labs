page 50101 "Tag Identification"
{
    Caption = 'Tag Identification';
    PageType = StandardDialog;
    SourceTable = "Item Category Tag";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(Tags)
            {
                field(Tag; Tag)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Match; Match)
                {
                    Caption = 'Match';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if Match then begin
                            if not SelectedTags.Contains(Tag) then
                                SelectedTags.Add(Tag);
                        end else begin
                            if SelectedTags.Contains(Tag) then
                                SelectedTags.Remove(Tag);
                        end;
                    end;
                }
            }
        }
    }

    var
        SelectedTags: List of [Text];
        Match: Boolean;

    procedure SetTags(Item: Record Item; Tags: List of [Text]);
    var
        Tag: Text;
    begin
        if Tags.Count() = 0 then
            Error('No tags have been identified. This is weird.');

        foreach Tag in Tags do begin
            Rec."Item Category Code" := Item."Item Category Code";
            Rec.Tag := Tag;
            Rec.Insert();
        end;
    end;

    procedure ApplyTags();
    var
        ItemCategoryTag: Record "Item Category Tag";
    begin
        if SelectedTags.Count() = 0 then
            Error('No tags were selected. Nothing was changed.');

        if Rec.FindSet() then
            repeat
                if SelectedTags.Contains(Tag) then begin
                    ItemCategoryTag := Rec;
                    if not ItemCategoryTag.Insert() then;
                end;
            until Rec.Next() = 0;
    end;
}