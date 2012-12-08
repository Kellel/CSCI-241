with generic_stack; 
with Ada.Text_IO;

procedure generic_stack_test is
    package Int_Stack is new generic_Stack(Integer);
    Stack : Int_Stack.Stack;
begin
    Int_Stack.Push(1,Stack);
    Int_Stack.Push(2,Stack);
    Int_Stack.Push(3,Stack);
    Ada.Text_IO.Put_Line(Natural'Image(Int_Stack.Count(Stack)));
    loop
        declare
            output : Integer;
        begin
            Int_Stack.Pop(output, Stack);
            Ada.Text_IO.Put(Integer'Image(output));
        exception
            when Int_Stack.Empty =>
                exit;
        end;
    end loop;
end generic_stack_test;
