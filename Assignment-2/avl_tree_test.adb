with avl_tree;
with Ada.Integer_Text_IO;

procedure avl_tree_test is
    function Put_Natural ( X : Natural ) return String is
        Num_String : String (1 .. 3) := (others => ' ');
    begin
        Ada.Integer_Text_IO.Put(Num_String, X);
        return Num_String;
    end Put_Natural;
    package Avl is new Avl_Tree( Natural, "<", Put_Natural );
    Tree : Avl.Search_Tree;
begin
    Avl.Insert(5, Tree );
    Avl.Print(Tree);
end avl_tree_test;
