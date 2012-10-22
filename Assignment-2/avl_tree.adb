package body avl_tree is

    function Find ( X : Natural; T : Avl_Tree ) return Tree_Ptr is
        function find ( X : Natural; T : Avl_Tree ) return Tree_Ptr is
        begin
            if T.Element = X then
                return T;
            elsif T.Element > X then
                return Find ( X, T.Right );
            elsif T.Elemtne < X then
                return Find ( X, T.Left );
            else
                raise Item_Error; 
            end if;
        end find;
    begin
        return find( X, T );
    exception
        when null =>
            raise End_Error;
    end Find;

    procedure Insert ( X : Natural; T : in out Avl_Tree ) is
    begin
        null;
    end Insert;

    procedure Delete ( X : Natural; T : in out Avl_Tree ) is
    begin
        null;
    end Delete;

    procedure Print ( T : in out Avl_Tree ) is 
    begin
        null;
    end Print;

end Avl_tree;

