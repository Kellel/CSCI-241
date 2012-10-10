-- Simple test program for gen_tree_package

with Gen_Tree_Package;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Test_Gen_Tree is
    
    package Char_Tree is new Gen_Tree_Package ( CHARACTER );
    use Char_Tree;

    Tree : Gen_Tree;
    Char : Character;
    Ptr  : Tree_Ptr;

begin
    Ptr := Go_Root ( Tree );
    Insert_Node ( 'A' , Ptr );
    Ptr := Go_Root ( Tree );
    -- testing 
    put ( Get_Node ( Ptr ));
    Ptr := Go_Left ( Ptr );
    Insert_Node ( 'B' , Ptr );
    put ( Get_Node ( Ptr ));
    new_line;
    Ptr := Go_Root ( Tree );
    put ( "Back at root" );
    put ( Get_Node ( Ptr ));


end Test_Gen_Tree;
