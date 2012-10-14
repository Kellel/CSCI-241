with Tree_Expression; use Tree_Expression;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Command_Line; use Ada.Command_Line;

procedure main is
    Tree : Expression_Node_Ptr;
begin
    Tree := Construct(Argument(1));
    put_line ( "Prefix: " & Prefix_Notation (Tree));
    put_line ( "Infix: " & Infix_Notation (Tree));
    put_line ( "Postfix: " & Postfix_Notation (Tree));
    put ("Value: ");
    put (Item=>Evaluate(Tree),Aft=>2, Exp=>0);
    new_line;
exception
    when Constraint_Error => 
        put_line ("Command line argument expected! Please enter 'Expression'");
end main;

