package body Gen_Tree is

    -- Create_Node creates a node and returns the ptr
    function Create_Node ( Data : Item_Type; Left_Child, Right_Child : Node_Ptr) return Node_Ptr is
        New_Node : Node_Ptr;
    begin
        New_Node := new Node_Type'( Data, Left_Child, Right_Child );
        return New_Node;
    end Create_Node;

    -- Get data returns Item_Type from the ptr 
    -- if the node isnt defined raise Node_Error
    function Get_Data ( Node : Node_Ptr ) return Item_Type is
    begin
        if Node /= null then
            return Node.Data;
        else
            raise Node_Error;
        end if;
    end Get_Data;

    -- Allows you to set the data for a specified node
    procedure Set_Data ( Node : Node_Ptr; Item : Item_Type ) is
    begin
        if Node /= null then
            Node.Data := Item;
        else
            raise Node_Error;
        end if;
    end Set_Data;

    -- will return the node that is the left child of the current node
    function Get_Left_Child ( Node : Node_Ptr ) return Node_Ptr is
    begin
        if Node.Left_Child /= null then
            return Node.Left_Child;
        else
            raise Node_Error;
        end if;
    end Get_Left_Child;

    -- will set the left child node on the current pointer to be the specified Left_Child
    procedure Set_Left_Child ( Node : Node_Ptr; Left_Child : Node_Ptr ) is
    begin
        if Node /= null and Left_Child /= null then
            Node.Left_Child := Left_Child;
        else
            raise Node_Error;
        end if;
    end Set_Left_Child;

    -- Will return the node that is the right child of the current node
    function Get_Right_Child ( Node : Node_Ptr ) return Node_Ptr is
    begin
        if Node.Right_Child /= null then
            return Node.Right_Child;
        else
            raise Node_Error;
        end if;
    end Get_Right_Child;

    -- Will set the Right_Child of the current node to be the specified Right_Child
    procedure Set_Right_Child ( Node, Right_Child : Node_Ptr ) is
    begin
        if Node /= null and Right_Child /= null then
            Node.Right_Child := Right_Child;
        else
            raise Node_Error;
        end if;
    end Set_Right_Child;

    function Inorder_Traversal ( Node : Node_Ptr) return String is
    begin
        return "Test";
    end Inorder_Traversal;

    function Preorder_Traversal ( Node : Node_Ptr ) return String is
    begin
        return "Test";
    end Preorder_Traversal;

    function Postorder_Traversal ( Node : Node_Ptr ) return String is 
    begin
        return "test";
    end Postorder_Traversal;

end Gen_Tree;

