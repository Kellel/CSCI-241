with Ada.Text_IO; use Ada.Text_IO;

Procedure test_stuff is
    type Test_Set is array (Character) of Boolean;
    Test : constant Test_Set := ('1'=>True, others=>False);
begin
    if Test('2') then
        put ("Win");
    else
        put("Fail");
    end if;
end test_stuff;
