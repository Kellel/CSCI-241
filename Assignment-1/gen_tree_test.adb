-- Simple test program for gen_tree_package

with Gen_Tree;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Gen_Tree_Test is
    
    package Char_Tree is new Gen_Tree ( CHARACTER );
    use Char_Tree;
    type Tree is record
        Root : Node_Ptr := null;
    end record;
    Test_Tree : Tree;
    Ptr : Node_Ptr;
begin
    Test_Tree.Root := Create_Node ( 'A', null, null);
    put ( Get_Data ( Test_Tree.Root ) );
    Ptr := Test_Tree.Root;
    Set_Left_Child ( Ptr, Create_Node ( 'B', null, Create_Node ( 'C', null, null)));
    Ptr := Get_Left_Child ( Test_Tree.Root);
    put ( Get_Data ( Ptr ));
    Ptr := Get_Right_Child ( Ptr );
    put ( Get_Data ( Ptr ));

end Gen_Tree_Test;
