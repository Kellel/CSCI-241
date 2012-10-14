with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;

Procedure test_stuff is
    input : String := "1234";
    output : integer;
    last : positive;
begin
    Ada.Integer_Text_IO.Get(From=>input, Item=>output, Last=>last);
    Ada.Integer_Text_IO.put(output);
end test_stuff;
