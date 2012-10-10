-- Implementation of generic tree package

with Unchecked_Deallocation;

package body Gen_Tree_Package is 
   
    -- From Mark Weiss
    -- I don't really understand deallocation
    procedure Dispose is new Unchecked_Deallocation ( Tree_Node, Tree_Ptr );

    -- Not sure if this is needed, will try and comment out
    -- Mark Weiss had this so i will leave it till i have enough information to tell if i need it
    procedure Initialize ( Tree : in out Gen_Tree ) is
    begin
        Clean_Tree ( Tree );
    end Initialize;

    -- Called to clean up after running 
    -- Mark Weiss
    procedure Finalize ( Tree : in out Gen_Tree ) is 
    begin
        Clean_Tree( Tree );
    end Finalize;

    -- Will create a new node at the 
    function New_Left ( X : Element_Type; Ptr : Tree_Ptr ) return Tree_Ptr is
        New_Node : Gen_Tree := Tree_Node'( X, null , null );
    begin
        Ptr.Left := New_Node;
        return Ptr.Left;
    end New_Left;
    -- Clean out tree using recursion
    -- basiclly the same as Mark Weiss' "Make_Empty" routine, it works the same way
    procedure Clean_Tree ( Tree : in out Gen_Tree ) is
        procedure clean ( Ptr : in out Tree_Ptr ) is 
        begin
            if Ptr /= null then
                clean ( Ptr.Left );
                clean ( Ptr.Right );
                Dispose ( Ptr );
            end if;
        end clean;
    begin
        clean ( Tree.Root );
    end Clean_Tree;

    -- Will return the data from a given node
    function Get_Node ( Ptr : Tree_Ptr ) return Element_Type is 
    begin
        if Ptr /= null then
            return Ptr.Data;
        else 
            raise Node_Error;
        end if;
            
    end Get_Node;

    -- Traverse left down the tree
    function Go_Left ( Ptr : Tree_Ptr ) return Tree_Ptr is 
    begin
        if Ptr /= null then
            return Ptr.Left;
        else
            raise Node_Error;
        end if;
    end Go_Left;

    -- Traverse right down the tree
    function Go_Right ( Ptr : Tree_Ptr ) return Tree_Ptr is
    begin
        if Ptr /= null then
            return Ptr.Right;
        else
            raise Node_Error;
        end if;
    end Go_Right;

    -- Return to the root of the tree
    function Go_Root ( Tree : Gen_Tree ) return Tree_Ptr is 
    begin
        return Tree.Root;
    end Go_Root;


end Gen_Tree_Package;
