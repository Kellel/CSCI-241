package body Generic_Queue is
    procedure Pop(Element : out Element_Type; This : in out Queue) is
        function pop (List : Ptr) return Ptr is
        begin
            if List.Next = Null then
                Element := List.Data;
                return null;
            else
                List.Next := pop(List.Next);
                return list;
            end if;
        exception
            when Constraint_Error =>
                raise Empty;
        end pop;
    begin
        This.Root := pop(This.Root);
    end Pop;
    
    procedure Push(Data : Element_Type; This : in out Queue) is
        new_node : Ptr := new Node'(Data,This.Root);
    begin
        This.Root := new_node;
        return;
    end Push;
    function Count(This : Queue) return Natural is
        function count(List : Ptr) return Natural is
        begin
            return 1 + Count(List.Next);
        exception
            when Constraint_Error =>
                return 0;
        end count;
    begin
        return count(This.Root);
    end Count;
end Generic_Queue;
        
