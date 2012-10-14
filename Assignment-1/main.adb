-----------------------------------------
-- Expression Tree Solution
-- Kellen Fox
-- W00961302
--
-- -------------------------------------

with Tree_Expression; use Tree_Expression;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Command_Line; use Ada.Command_Line;

procedure main is
    Tree : Expression_Node_Ptr;
begin
    -- Assume the user gives a command line arg
    Tree := Construct(Argument(1));
    put_line ( "Prefix: " & Prefix_Notation (Tree));
    put_line ( "Infix: " & Infix_Notation (Tree));
    put_line ( "Postfix: " & Postfix_Notation (Tree));
    put ("Value: ");
    put (Item=>Evaluate(Tree),Aft=>2, Exp=>0);
    new_line;
exception
    when Constraint_Error => 
        -- Scold the user if they forgot the Command_Line arg
        put_line ("Command line argument expected! Please enter 'Expression'");
    when Number_Error | Expression_Error =>
        -- The user input was invalid
        put_line ("Invalid Expression");
end main;

