-- Generic Binary Tree for use with avl_tree
-- Note The Name Avl_Tree is **NOT** acceptable Note
generic
    type Element_Type is private;
    with function "<" ( Left, Right: Element_Type ) return Boolean;
    with procedure Put ( Element: Element_Type );
package avl_tree is
    type Avl_Tree is limited private;
    type Avl_Ptr is access Avl_Tree;
    --function  Find_Max ( T : Bin_Tree ) return Tree_Ptr;
    --function  Height   ( T : Bin_Tree ) return Natural;
    --function  Parent   ( T : Bin_Tree ) return Tree_Ptr;
    --function  Child    ( T : Bin_Tree ) return Tree_Ptr;
    function  Find     ( X : Natural; 
                         T : Avl_Tree ) return Avl_Ptr;
    procedure Insert   ( X : Natural; 
                         T : in out Avl_Tree );
    procedure Delete   ( X : Natural; 
                         T : in out Avl_Tree );
    procedure Print    ( T : in out Avl_Tree);

    Node_Error : exception; -- Error raised when a node doesn't exist

private
    type Tree_Node;
    type Node_Ptr is access Tree_Node;
    type Avl_Tree is
        record
            Root : Node_Ptr;
        end record;
    type Tree_Node is 
        record 
            Element : Natural;
            Left    : Node_Ptr;
            Right   : Node_Ptr;
        end record;
end avl_tree;
