with Tree_Expression; use Tree_Expression;
with Ada.Text_IO; use Ada.Text_IO;

procedure Tree_Expression_Test is
    Tree : Expression_Node_Ptr;
begin
    Tree := Construct("(10/2)");
    put ( Postfix_Notation (null) );
end Tree_Expression_Test;

