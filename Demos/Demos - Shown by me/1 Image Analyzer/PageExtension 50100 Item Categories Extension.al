pageextension 50100 "Item Categories Extension" extends "Item Categories"
{
    actions
    {
        addfirst(Navigation)
        {
            action(Tags)
            {
                Caption = 'Tags';
                Image = BulletList;
                ApplicationArea = All;

                RunObject = page "Item Category Tags";
                RunPageLink = "Item Category Code" = field (Code);
            }
        }
    }
}