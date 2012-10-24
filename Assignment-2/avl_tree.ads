-- Generic Binary Tree for use with avl_tree
-- Note The Name Avl_Tree is **NOT** acceptable Note

with Ada.Text_IO;
with Ada.Integer_Text_IO;

generic
    type Element_Type is private;
    with function "<" ( Left, Right: Element_Type ) return Boolean;
    with function Put ( Element: Element_Type ) return String;
package avl_tree is
    type Node_Ptr is private;
    type Search_Tree is limited private;
    --function  Find_Max ( T : Bin_Tree ) return Tree_Ptr;
    --function  Height   ( T : Bin_Tree ) return Natural;
    --function  Parent   ( T : Bin_Tree ) return Tree_Ptr;
    --function  Child    ( T : Bin_Tree ) return Tree_Ptr;
    function  Find     ( X : Element_Type; 
                         T : Search_Tree ) return Node_Ptr;
    procedure Insert   ( X : Element_Type; 
                         T : in out Search_Tree );
    procedure Delete   ( X : Element_Type; 
                         T : in out Search_Tree );
    procedure Print    ( T : in out Search_Tree);
    Item_Not_Found : exception; -- value to tell the user a node doesnt exist
    Node_Error : exception; -- Error raised when a node doesn't exist

private
    type Tree_Node;
    type Node_Ptr is access Tree_Node;
    type Search_Tree is
        record
            Root : Node_Ptr;
        end record;
    type Tree_Node is 
        record 
            Element : Element_Type;
            Left    : Node_Ptr;
            Right   : Node_Ptr;
        end record;
end avl_tree;
