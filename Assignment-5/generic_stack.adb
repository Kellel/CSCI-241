package body Generic_Stack is
    procedure Pop(Element : out Element_Type; This : in out Stack) is
    begin
        Element := This.Root.Data;
        This.Root := This.Root.Next;
        return;
    exception
        when Constraint_Error =>
            raise Empty;
    end Pop;
    procedure Push(Data : Element_Type; This : in out Stack) is
        new_node : Ptr := new Node'(Data,This.Root);
    begin
        This.Root := new_node;
        return;
    end Push;
    function Count(This : Stack) return Natural is
        Tmp    : Stack := This;
        Number : Natural := 0;
        Output : Element_Type;
    begin
        loop
            Pop(Output, Tmp);
            Number := Number + 1;
        end loop;
        
        -- never happens
        return 0;
    exception
        when Empty =>
            return Number;
    end Count;
end Generic_Stack;
        
