-- AVL Tree main program / user interface
--
-- Kellen Fox 
-- CSCI 241
-- W00961302
--
-- ** For use with avl_tree.adb & avl_tree.ads **


with avl_tree;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_Io;

-- Main procedure
procedure main is
    
    -- Will return a string based on the type of element for avl_tree
    function To_String ( X : Natural ) return String is
        -- Change this value to create larger numbers
        -- Max number size currently = 3
        Num_String : String(1 .. 3) := (others => ' ');
    begin
        -- Will return a string from a natural
        Ada.Integer_Text_IO.Put(Num_String, X);
        return Num_String;
    end To_String;

    -- Create a instance of the generic avl_tree package
    package Avl is new Avl_Tree(Natural, "<", To_String );
    -- Create a tree to be used in this program
    Tree : Avl.Search_Tree;
    -- Exit exception
    Exit_Loop : exception;
    -- Error for bad input
    Input_Error : exception;
    -- Will handle action statements
    procedure Get_Action is
        Input : String (1 .. 20);
        Last : Positive;
        Operator : Character;
        Value : Integer;
    begin
        -- Let user know their options
        Ada.Text_IO.Put ("Please enter your request (i=insert, d=delete, p=print, e=exit): ");
        -- Get user input
        Ada.Text_IO.Get_Line (Input, Last);
        -- Operator will be first character of input
        Operator := Input(Input'First);
        case Operator is
            -- If the input is i or I insert the following number
            when 'i'|'I' =>
                -- Get number from the rest of the string
                Ada.Integer_Text_IO.Get(From=>Input(Input'First + 1 .. Last), Item=>Value, Last=>Last);
                -- Declare block to check for errors
                declare
                begin
                    -- Atempt to insert a node
                    Avl.Insert(Natural(Value), Tree);
                    -- If able to insert a node then print it
                    Put ("Inserting: ");
                    Ada.Integer_Text_IO.Put(Value,4);
                    new_line;
                exception
                    -- Tell the user that the element already exists
                    when Avl.Item_Not_Found =>
                        Ada.Text_IO.Put_Line("That item already exists!");
                end;
            -- User input is d or D so delete a node
            when 'd'|'D' =>
                -- Attempt to get a number from the rest of the string
                Ada.Integer_Text_IO.Get(From=>Input(Input'First + 1 .. Last), Item=>Value, Last=>Last);
                -- Block for error checking
                declare
                begin
                    -- Atempt to delete a node
                    Avl.Delete(Natural(Value), Tree);
                    -- The delete was sucessful tell the user
                    Put ("Deleting: ");
                    Ada.Integer_Text_IO.Put(Value, 4);
                    new_line;
                exception
                    -- Deletion failed tell the user
                    when Avl.Item_Not_Found =>
                        Ada.Text_IO.Put_Line("Element Not Found");
                end;
            -- If the user inputs p or P print the tree
            when 'p'|'P' =>
                Put_Line ("Printing Tree");
                -- block for error checking
                declare
                begin
                    -- Atempt to print the tree
                    Avl.Print ( Tree );
                exception
                    -- If there are no items print empty tree
                    when Avl.Item_Not_Found =>
                        Ada.Text_IO.Put_Line("()");
                end;
            -- If the user inputs e or E exit
            when 'e'|'E' =>
                raise Exit_Loop;
            -- Other operators are not excepted
            when others =>
                Ada.Text_IO.Put_Line("Not a valid option. Please try again!");
        end case;
    exception
        when End_Error | Data_Error =>
            Ada.Text_IO.Put_Line("You must follow your commands with numbers.");
    end Get_Action;
begin
    -- Loop until the user quits
    loop
        Get_Action;
    end loop;
exception
    -- When the user quits say goodbye
    when Exit_Loop =>
        Put_Line("Bye!");
end main;

