package body avl_tree is

    function Find ( X : Element_Type; T : Search_Tree ) return Node_Ptr is
        function find ( X : Element_Type; T : Node_Ptr ) return Node_Ptr is
        begin
            if T.Element = X then
                return T;
            elsif T.Element < X then
                return Find ( X, T.Left );
            else
                return Find ( X, T.Right );
            end if;
        exception
            when Constraint_Error =>
                raise Node_Error;
        end find;
    begin
        return find( X, T.Root );
    end Find;

    procedure Insert ( X : Element_Type; T : in out Search_Tree ) is
        New_Node : Node_Ptr;
    begin
        T.Root := Find ( X, T );
    exception
        when Node_Error =>
            -- There are no nodes so create one
            T.Root := new Tree_Node'(X, null, null);
    
    end Insert;

    procedure Delete ( X : Element_Type; T : in out Search_Tree ) is
    begin
        null;
    end Delete;

    -- Will Print a Given Binary Tree
    procedure Print ( T : in out Search_Tree ) is
        -- Will recursively build and return a string of a Binary Tree
        function print ( N : Node_Ptr ) return String is
        begin
            -- Assume the tree is infinite and that we can continue to add on nodes for ever
            return '(' & print(N.Left) & Put(N.Element) & print(N.Right) & ')';
        exception
            -- Constraint_Error is called when attempting to access a null pointer. If this happens then we 
            -- must have hit a leaf
            when Constraint_Error =>
                -- If an element is a leaf return it with (null, [], null) around it
                if N.Left = null and N.Right = null then
                    return "(null," & Put(N.Element) & ", null)";
                -- If there is no left child then return (null, [element], [right-subtree])
                elsif N.Left = null then
                    return "(null," & Put(N.Element) & ',' & print(N.Right) & ')';
                -- If there is no right child then return ([left-subtree], [element], null)
                elsif N.Right = null then
                    return '(' & print(N.Left) & ',' & Put(N.Element) & ", null)";
                -- If the element is null then you have an empty tree, raise an error
                else 
                    raise Node_Error;
                end if;
        end print;
    begin
        Ada.Text_IO.Put_Line(print(T.Root));
    end Print;

-- -- Internal Functions -- --
    procedure Rotate_Left ( N : Node_Ptr ) is
    begin
        null;
    end Rotate_Left;

end avl_tree;

