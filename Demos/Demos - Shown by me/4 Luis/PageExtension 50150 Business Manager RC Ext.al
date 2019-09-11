pageextension 50150 "Business Manager RC Extension" extends "Business Manager Role Center"
{
    layout
    {
        addbefore(Control139)
        {
            part(TellMeMore; "Tell me more")
            {
                ApplicationArea = All;
            }
        }
    }
}