with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Strings.Unbounded;

package Get_Args is

    procedure init ();
    function get_arg (This : in Integer) return String;
    function get_num () return Integer;

private

    arg_num : Integer := Ada.Command_Line.Argument_Count;
    args : array (1 .. arg_num) of Ada.Strings.Unbounded.Unbounded_String;

end Get_Args; 
