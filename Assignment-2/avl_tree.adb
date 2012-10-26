package body avl_tree is

    Procedure Balance ( T : in out Node_Ptr ) is
        function BF ( Ptr : Node_Ptr ) return integer is
            function Height ( Ptr : Node_Ptr ) return Natural is
            begin
                if Height(Ptr.Left) < Height(Ptr.Right) then
                    return 1 + Height(Ptr.Right);
                else 
                    return 1 + Height(Ptr.Left);
                end if;
            exception
                when Constraint_Error =>
                    return 0;
            end Height;
        begin
            return Height( Ptr.Left ) - Height(Ptr.Right);
        exception
            when Constraint_Error =>
                if Ptr = null then
                    return 0;
                else
                    if Ptr.Left = null and Ptr.Right = null then
                        return 0;
                    elsif Ptr.Left = null then
                        return 0 - Height(Ptr.Right);
                    else
                        return Height(Ptr.Left);
                    end if;
                end if;
        end BF;
        function Right ( Ptr : Node_Ptr ) return Node_Ptr is
            A : Node_Ptr := T;
            B : Node_Ptr := T.Left;
            C : Node_Ptr := T.Left.Left;
        begin
            A.Left := B.Right;
            B.Right := A;
            return B;
        end Right;
        function Right_2 ( Ptr : Node_Ptr ) return Node_Ptr is
            A : Node_Ptr := T;
            B : Node_Ptr := T.Left;
            C : Node_Ptr := T.Left.Right;
        begin
            B.Right := C.Left;
            C.Left := B;
            A.Left := C;
            return Right(A);
        end Right_2;
        function Left ( Ptr : Node_Ptr ) return Node_Ptr is
            A : Node_Ptr := T;
            B : Node_Ptr := T.Right;
            C : Node_Ptr := T.Right.Right;
        begin
            A.Right := B.Left;
            B.Left := A;
            return B;
        end Left;
        function Left_2 ( Ptr : Node_Ptr ) return Node_Ptr is
            A : Node_Ptr := T;
            B : Node_Ptr := T.Right;
            C : Node_Ptr := T.Right.Left;
        begin
            B.Right := C.Right;
            C.Right := B;
            A.Right := C;
            return Left(A);
        end Left_2;
        Balence_Factor : Integer := BF(T);
        Child_Factor : Integer;
    begin
        if 1 < Balence_Factor then
            Child_Factor := BF(T.Left);
            if Child_Factor = -1 then
                T := Right_2(T);
            else
                T := Right(T);
            end if;
        elsif Balence_Factor < -1 then
            Child_Factor := BF(T.Right);
            if Child_Factor = 1 then
                -- double left rotation
                T := Left_2(T);
            else
                T := Left(T);
            end if;
        end if;
        return;
    end Balance;
    function Find ( X : Element_Type; T : Search_Tree ) return Node_Ptr is
        function find ( X : Element_Type; T : Node_Ptr ) return Node_Ptr is
        begin
            if T.Element = X then
                return T;
            elsif T.Element < X then
                return find ( X, T.Left );
            else
                return find ( X, T.Right );
            end if;
        exception
            -- Contraint_Error raised when atempting to access a null pointer, that means the element was not found
            when Constraint_Error =>
                -- The Node was not found to return the node you were on for insertion
                return T;
        end find;
    begin
        return find( X, T.Root );
    end Find;

    procedure Insert ( X : Element_Type; T : in out Search_Tree ) is
        function insert ( X : Element_Type; Ptr : Node_Ptr) return Node_Ptr is
        begin
            if Ptr.Element = X then
                raise Node_Error;
            elsif X < Ptr.Element then
                Ptr.Left := insert(X, Ptr.Left);
                Balance(Ptr.Left);
            else
                Ptr.Right := insert(X, Ptr.Right);
                Balance(Ptr.Right);
            end if;
            return Ptr;
        exception
            -- A constraint_error is thrown when a null pointer is referenced
            when Constraint_Error =>
                return new Tree_Node'(X,null,null);

        end insert;
    begin
        if T.Root /= null then
            T.Root := insert(X, T.Root);
        else
            T.Root := new Tree_Node'(X,null,null);
        end if;
        Balance (T.Root);
    end Insert;

    procedure Delete ( X : Element_Type; T : in out Search_Tree ) is
        function delete ( X: Element_Type; Ptr : Node_Ptr ) return Node_Ptr is
            function Append_Min ( Left : Node_Ptr; Ptr : Node_Ptr ) return Node_Ptr is
            begin
                Ptr.Left := Append_Min(Left, Ptr.Left);
                return Ptr;
            exception
                when Constraint_Error => 
                    return Left;
            end Append_Min;
            Left : Node_Ptr;
        begin
            if Ptr.Element = X then
                if Ptr.Left = null and Ptr.Right = null then
                    return null;
                elsif Ptr.Left = null then
                    return Ptr.Right;
                else
                    Left := Ptr.Left;
                    return Append_Min(Left, Ptr.Right);
                end if;
            elsif X < Ptr.Element then
                Ptr.Left := delete(X, Ptr.Left);
                Balance(Ptr.Left);
                return Ptr;
            else
                Ptr.Right := delete(X, Ptr.Right);
                Balance(Ptr.Right);
                return Ptr;
            end if;
        end delete;
    begin
        T.Root := delete( X , T.Root );
        Balance( T.Root );
    --exception
      --  when Constraint_Error =>
        --    raise Item_Not_Found;
    end Delete;

    -- Will Print a Given Binary Tree
    procedure Print ( T : in out Search_Tree ) is
        -- Will recursively build and return a string of a Binary Tree
        function print ( N : Node_Ptr ) return String is
        begin
            -- Assume the tree is infinite and that we can continue to add on nodes for ever
            -- This function seems backwards but it makes everything come out right
            return '(' & print(N.Left) & ',' & Put(N.Element) & ',' & print(N.Right) & ')';
        exception
            -- Constraint_Error is called when attempting to access a null pointer. If this happens then we 
            -- must have hit a leaf
            when Constraint_Error =>
                -- If an element is a leaf return it with (null, [], null) around it
                if N.Left = null and N.Right = null then
                    return "(null," & Put(N.Element) & ", null)";
                -- If there is no left child then return (null, [element], [right-subtree])
                elsif N.Right = null then
                    return '(' & print(N.Left) & ',' & Put(N.Element) & ", null)";
                -- If there is no right child then return ([left-subtree], [element], null)
                elsif N.Left = null then
                    return "(null," & Put(N.Element) & ',' & print(N.Right) & ')';
                -- If the element is null then you have an empty tree, raise an error
                else 
                    raise Node_Error;
                end if;
        end print;
    begin
        Ada.Text_IO.Put_Line(print(T.Root));
    exception
        when Constraint_Error =>
            raise Item_Not_Found;
    end Print;

    -- -- Internal Functions -- --
    
end avl_tree;

