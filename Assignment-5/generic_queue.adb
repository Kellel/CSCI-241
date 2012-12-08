package body Generic_Queue is
    procedure Pop(Element : out Element_Type; This : in out Queue) is
    begin
        Element := This.Root.Data;
        This.Root := This.Root.Next;
        return;
    exception
        when Constraint_Error =>
            raise Empty;
    end Pop;
    procedure Push(Data : Element_Type; This : in out Queue) is
        new_node : Ptr := new Node'(Data,This.Root);
        function Append (List : Ptr) return Ptr is
        begin
            if List = Null then
                return new_node;
            else
                declare
                    linker : Ptr := List;
                begin
                    linker.Next := Append(List.Next);
                    return linker;
                end;
            end if;
        end Append;
    begin
        This.Root := Append(This.Root);
        return;
    end Push;
    function Count(This : Queue) return Natural is
        Tmp    : Queue := This;
        Number : Natural := 0;
        Output : Element_Type;
    begin
        loop
            Pop(Output, Tmp);
            Number := Number + 1;
        end loop;
        
        -- never happens
        return Number;
    exception
        when Empty =>
            return Number;
    end Count;
end Generic_Queue;
        
