with avl_tree;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_Io;

procedure main is
    function To_String ( X : Natural ) return String is
        Num_String : String(1 .. 3) := (others => ' ');
    begin
        Ada.Integer_Text_IO.Put(Num_String, X);
        return Num_String;
    end To_String;
    package Avl is new Avl_Tree(Natural, "<", To_String );
    Tree : Avl.Search_Tree;
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
                Avl.Insert(Natural(Value), Tree);
                Put ("Inserting: ");
                Ada.Integer_Text_IO.Put(Value,4);
                new_line;
            when 'd' =>
                Ada.Integer_Text_IO.Get(From=>Input(Input'First + 1 .. Last), Item=>Value, Last=>Last);
                Put ("Deleting: ");
                Ada.Integer_Text_IO.Put(Value, 4);
                new_line;
                -- Block for error checking
                declare
                begin
                    Avl.Delete(Natural(Value), Tree);
                exception
                    when Avl.Item_Not_Found =>
                        Ada.Text_IO.Put_Line("Element Not Found");
                end;
            when 'p' =>
                Put_Line ("Printing Tree");
                declare
                begin
                    Avl.Print ( Tree );
                exception
                    when Avl.Item_Not_Found =>
                        Ada.Text_IO.Put("()");
                end;
            when 'e' =>
                raise Exit_Loop;
            when others =>
                Ada.Text_IO.Put_Line("Not a valid option. Please try again!");
        end case;
    end Get_Action;
begin
    loop
        declare
        begin
            Get_Action;
        exception
            when End_Error | Data_Error =>
                Ada.Text_IO.Put_Line("The format requires you enter a number after a letter.");
        end;
    end loop;
exception
    when Exit_Loop =>
        Put_Line("Bye!");
end main;

