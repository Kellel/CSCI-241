-- bin_tree.ads
-- Generic Binary Tree for use with avl_tree
--

generic 
    type Element_Type is private;
    with function "<" ( Left, Right : Element_Type ) return Boolean;

package bin_tree is
    type Tree_Ptr is private;
    type Bin_Tree is private;

    function  Find_Min ( T : Bin_Tree ) return Tree_Ptr;
    function  Find_Max ( T : Bin_Tree ) return Tree_Ptr;
    function  Height   ( T : Bin_Tree ) return Natural;
    function  Parent   ( T : Bin_Tree ) return Tree_Ptr;
    function  Child    ( T : Bin_Tree ) return Tree_Ptr;
    function  Find     ( X : Element_Type; 
                         T : Bin_Tree ) return Tree_Ptr;
    procedure Insert   ( X : Element_Type; 
                         T : in out Bin_Tree );
    procedure Delete   ( X : Element_Type; 
                         T : in out Bin_Tree );

    Node_Error : exception; -- Error raised when a node doesn't exist

private
    type Tree_Node;
    type Tree_Ptr is access Tree_Node;

    type Bin_Tree is
        record
            Root : Tree_Ptr;
        end record;

    type Tree_Node is 
        record 
            Element : Element_Type;
            Left    : Tree_Ptr;
            Right   : Tree_Ptr;
        end record;
end bin_tree;
