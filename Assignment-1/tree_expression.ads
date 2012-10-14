--------------------------------------------------------------------------------
-- CSCI 241, Assignment 1: Expression Tree
-- Tree_Expression.ads
--
-- Spec file for building and processing expression trees
-- Modified By: Kellen Fox W00961302
--------------------------------------------------------------------------------

with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
with Gen_Tree;
with Ada.Numerics.Generic_Elementary_Functions;
PACKAGE Tree_Expression IS

   String_Size : Natural := 25;
   subtype Tree_String is String (1 .. String_Size);
   function To_String (Input : Tree_String) return String;
   package Binary_Expression_Tree is new Gen_Tree(Tree_String, To_String);
   package GT renames Binary_Expression_Tree;
   package Float_Functions is new Ada.Numerics.Generic_Elementary_Functions
     (Float_Type => Float);
   
   subtype Expression_Node_Ptr is Binary_Expression_Tree.Node_Ptr;

   -- Will construct and Expression tree from a string input
   function Construct (Expression_String : String) return Expression_Node_Ptr;

   -- will evaluate a expression tree
   function Evaluate (Node : Expression_Node_Ptr) return Float;

   -- Provide Notations and stuff
   function Infix_Notation (Node : Expression_Node_Ptr) return String;
   function Prefix_Notation (Node : Expression_Node_Ptr) return String;
   function Postfix_Notation (Node : Expression_Node_Ptr) return String;

   -- Raised if an invalid expression is entered
   Expression_Error : exception;
   Number_Error : exception;
private
    function To_Char (input : String) return Character;
    function To_Number (input : String) return Float;
    Expression_Save : String(1 .. 30);
    Operator_Error : exception;
    
    -- The next three lines allow me to check a character for operators or numbers ex. Numbers('1') = True, Operators('1')=False
    type Char_Set is array (Character) of Boolean;
    Numbers : constant Char_Set := ('0'=>True, '1'=>True, '2'=>True, '3'=>True, '4'=>True, '5'=>true, '6'=>True, '7'=>True, '8'=>True, '9'=>True, others=>False);
    Operators : constant Char_Set := ('+'=>True, '-'=>True, '*'=>True, '/'=>True, '^'=>True, Others=>False);

end Tree_Expression;
