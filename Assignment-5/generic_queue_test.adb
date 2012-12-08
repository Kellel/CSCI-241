with Ada.Text_IO;
with generic_queue;

procedure generic_queue_test is
    package Int_Queue is new generic_queue(Integer);
    Queue : Int_Queue.Queue;
begin
    Int_Queue.Push(1, Queue);
    Int_Queue.Push(2, Queue);
    loop
        declare
            output : Integer;
        begin
            Int_Queue.Pop(output, Queue);
            Ada.Text_IO.Put_Line(Integer'Image(output));
        exception
            when Int_Queue.Empty =>
                exit;
        end;
    end loop;
end generic_queue_test;
