with avl_tree;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_Io;

procedure main is
    Exit_Loop : exception;
    Input_Error : exception;
    procedure Get_Action is
        Input : String (1 .. 20);
        Last : Positive;
        Operator : Character;
        Value : Integer;
    begin
        Ada.Text_IO.Put ("Please enter your request (i=insert, d=delete, p=print, e=exit): ");
        Ada.Text_IO.Get_Line (Input, Last);
        Operator := Input(Input'First);
        case Operator is
            when 'i' =>
                Ada.Integer_Text_IO.Get(From=>Input(Input'First + 1 .. Last), Item=>Value, Last=>Last);
                --avl_tree.Insert(Natural(Value), Tree);
                Put ("Inserting: ");
                Ada.Integer_Text_IO.Put(Value,4);
                new_line;
            when 'd' =>
                Ada.Integer_Text_IO.Get(From=>Input(Input'First + 1 .. Last), Item=>Value, Last=>Last);
                Put ("Deleting: ");
                Ada.Integer_Text_IO.Put(Value, 4);
                new_line;
                -- avl_tree.Delete(Natural(Value), Tree);
            when 'p' =>
                Put_Line ("Printing Tree");
                -- avl_tree.Print ( Tree );
            when 'e' =>
                raise Exit_Loop;
            when others =>
                raise Input_Error;
        end case;
    end Get_Action;
begin
    loop
        Get_Action;
    end loop;
exception
    when End_Error | Input_Error =>
        Put_Line("Only actions of the form 'o [Num]', while o is an operator i,d,p, or q are accepted");
    when Exit_Loop =>
        Put_Line("Bye!");
end main;

