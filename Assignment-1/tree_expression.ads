--------------------------------------------------------------------------------
-- CSCI 241, Assignment 1: Expression Tree
-- Tree_Expression.ads
--
-- Spec file for building and processing expression trees
--------------------------------------------------------------------------------

with Ada.Text_IO;--For testing... disable for production
with Ada.Integer_Text_IO;
with Gen_Tree;
with Ada.Exceptions;
with Ada.Numerics.Generic_Elementary_Functions;
PACKAGE Tree_Expression IS

   String_Size : Natural := 25;
   subtype Tree_String is String (1 .. String_Size);
   package Binary_Expression_Tree is new Gen_Tree(Tree_String);
   package GT renames Binary_Expression_Tree;
   package Float_Functions is new Ada.Numerics.Generic_Elementary_Functions
     (Float_Type => Float);
   
   subtype Expression_Node_Ptr is Binary_Expression_Tree.Node_Ptr;

   function Construct (Expression_String : String) return Expression_Node_Ptr;

   function Evaluate (Node : Expression_Node_Ptr) return Float;

   function Infix_Notation (Node : Expression_Node_Ptr) return String;
   function Prefix_Notation (Node : Expression_Node_Ptr) return String;
   function Postfix_Notation (Node : Expression_Node_Ptr) return String;

   Expression_Error : exception;
private
   Expression_Save : String(1 .. 30);
   type Char_Set is array (Character) of Boolean;
   Numbers : constant Char_Set := ('0'=>True, '1'=>True, '2'=>True, '3'=>True, '4'=>True, '5'=>true, '6'=>True, '7'=>True, '8'=>True, '9'=>True, others=>False);
   Operators : constant Char_Set := ('+'=>True, '-'=>True, '*'=>True, '/'=>True, '^'=>True, Others=>False);

end Tree_Expression;
