-- Package creates a generic tree
-- Template for generic functions and finalization from Mark Allen Weiss @ http://users.cis.fiu.edu/~weiss/ada/search_tree_package.ad(b|s)
with Ada.Finalization;
with Text_IO; use Text_IO;

generic 
    type Element_Type is private;

package Gen_Tree_Package is 
    
    type Tree_Ptr is private;

    -- If i use finalization the constructors and deconstructors are controllable, and that is pretty cool.
    type Gen_Tree is new  Ada.Finalization.Limited_Controlled with private;

    procedure Initialize ( Tree : in out Gen_Tree );
    procedure Finalize ( Tree : in out Gen_Tree );

    function Insert_Node ( Data : Element_Type; Ptr : Tree_Ptr ) return Tree_Ptr;
    procedure Clean_Tree ( Tree : in out Gen_Tree );
    function Get_Node ( Ptr : Tree_Ptr ) return Element_Type;
    
    -- 'Go' functions decend into the tree 
    function Go_Left ( Ptr : Tree_Ptr ) return Tree_Ptr;
    function Go_Right ( Ptr : Tree_Ptr ) return Tree_Ptr;
    function Go_Root ( Tree : Gen_Tree ) return Tree_Ptr;
    -- Raised when a inserting a node where a node already exists
    Node_Error : exception;

private
    
    type Tree_Node;
    type Tree_Ptr is Access Tree_Node;

    type Gen_Tree is new Ada.Finalization.Limited_Controlled with
        record
            Root: Tree_Ptr;
        end record;

    type Tree_Node is
        record
            Data  : Element_Type;
            Left  : Tree_Ptr;
            Right : Tree_Ptr;
        end record;

end Gen_Tree_Package;   
