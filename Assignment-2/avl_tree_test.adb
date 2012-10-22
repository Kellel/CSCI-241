with avl_tree;
with Ada.Integer_Text_IO;

procedure avl_tree_test is
    procedure Put_Natural ( X : Natural ) is
    begin
        Ada.Integer_Text_IO.Put(X);
    end Put_Natural;
    package Avl is new Avl_Tree( Natural, "<", Put_Natural );
    Tree : Avl.Avl_Tree;
begin
    Avl.Insert(5, Tree );
end avl_tree_test;
