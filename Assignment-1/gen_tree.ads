--------------------------------------------------------------------------------
-- CSCI 241, Assignment 1: Expression Tree
-- gen_tree.ads
-- Spec file for generic Binary Trees
-- Modified By: Kellen Fox W00961302
--------------------------------------------------------------------------------

generic
   type Item_Type is private;
   with Function To_String(Item : Item_Type) return String;
package Gen_Tree is
   type Node_Type is limited private;
   type Node_Ptr is access Node_Type;

   -- Create_Node allows a user to create a node 
   function Create_Node(Data : Item_Type; Left_Child, Right_Child : Node_Ptr) return Node_Ptr;
 
   -- Returns Data from Node
   function Get_Data (Node : Node_Ptr) return Item_Type;
   --Sets the data for a given node (unused)
   procedure Set_Data (Node : Node_Ptr; Item : Item_Type);

   -- Gives ability to set and get the ptr for left child
   function Get_Left_Child (Node : Node_Ptr) return Node_Ptr;
   procedure Set_Left_Child (Node : Node_Ptr; Left_Child : Node_Ptr);

   -- Gives ability to set and get the ptr for the right child
   function Get_Right_Child (Node : Node_Ptr) return Node_Ptr;
   procedure Set_Right_Child (Node : Node_Ptr; Right_Child : Node_Ptr);

   -- Handy Traversal functions
   function Preorder_Traversal (Node : Node_Ptr) return String;
   function Postorder_Traversal (Node : Node_Ptr) return String;

   -- Error for some basic traversal stuff
   Node_Error : Exception;

private
   type Node_Type is record
      Data        : Item_Type;
      Left_Child  : Node_Ptr := null;
      Right_Child : Node_Ptr := null;
   end record;
end Gen_Tree;
