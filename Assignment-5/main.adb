-- Assignment 5 Extra Credit
--
-- 1. Read File
-- 2. Build association
-- 3. Print number of connected components
-- 4. Print connected component matrix

with Ada.Text_IO;
with generic_stack;
with generic_queue;
with Ada.Command_Line;

procedure main is

    -- A graph array stores a boolean matrix to represent the graph
    type Graph_Array is array (Positive range <>, Positive range <>) of Boolean;
    
    -- A type to store the slice values of each connected component
    type Con_Comp_Type is record
        x_start : positive;
        y_start : positive;
        x_end   : positive;
        y_end   : positive;
    end record;
   
    -- Component stack is a stack to put components in ?make queue?
    package Comp_Stack is new generic_queue(Con_Comp_Type);
    Components : Comp_Stack.Queue;
    
    -- raised when improper arguments are given
    Usage_Error : exception;
    
    -- will fill Component stack with slice values of each Component
    procedure Find_Components (Graph : in Graph_Array)is
        -- Positive Stack for holding element numbers during processing
        package Pos_Stack is new generic_stack(Positive);

        -- type to hold boolean list of elements
        type Element_Array is Array (1 .. Graph'Last(1)) of Boolean;
        
        -- List of unused elements
        Unused : Element_Array := (others => True);
        
        -- Process all the elements in the stack and create a Component object and push it onto the stack
        procedure Process ( Stack : in out Pos_Stack.Stack ) is
            Data : Positive;
            -- Stores which elements have been processed
            Processed : Element_Array := (others => False);
        begin
            -- Loop until the stack is empty
            loop
                -- Get the first element from the stack
                Pos_Stack.Pop(Data, Stack);
                -- iterate through all the elements to look for association
                for i in Graph'Range(1) loop
                    -- if associated and unused push it onto the stack
                    if Graph(Data,i) then
                        if Unused(i) then
                            Pos_Stack.Push(i, Stack);
                            Unused(i) := False;
                        end if;
                    end if;
                end loop;
                Processed(Data) := True;
            end loop;
        exception
            -- when empty create a component
            when Pos_Stack.Empty =>
                declare
                    Comp : Con_Comp_Type; 
                begin
                    for i in Processed'Range loop
                        if Processed(i) then
                            Comp.x_start := i;
                            Comp.y_start := i;
                            exit;
                        end if;
                    end loop;
                    for i in reverse Processed'Range loop
                        if Processed(i) then
                            Comp.x_end := i;
                            Comp.y_end := i;
                            exit;
                        end if;
                    end loop;
                    Comp_Stack.Push(Comp, Components);
                end;
        end Process;
    begin
        -- iterate through all the elements
        for i in Unused'Range loop
            if Unused(i) then
                declare 
                    -- Stack for graph traversal
                    Stack : Pos_Stack.Stack;
                begin
                    -- Put the first element into the stack
                    Pos_Stack.Push(i, Stack);
                    -- Mark used
                    Unused(i) := False;
                    -- send the element and stack off for traversal
                    Process(Stack);
                end;
            end if;
        end loop;
    end Find_Components;
   
    -- Print all conected compontents
    procedure Print_Components (Graph : in Graph_Array) is
        Data : Con_Comp_Type;
    begin
        -- Get a component
        Comp_Stack.Pop(Data, Components);
        -- print it
        for x in Data.x_start .. Data.x_end loop
            for y in Data.y_start .. Data.y_end loop
                if Graph(x,y) then
                    Ada.Text_IO.Put('1');
                else
                    Ada.Text_IO.Put('0');
                end if;
            end loop;
            Ada.Text_IO.New_line;
        end loop;
        Ada.Text_IO.new_line;
        -- recursively loop until the stack is empty
        Print_Components(Graph);
    exception
        when Comp_Stack.Empty =>
            -- when empty exit
            return;
    end Print_Components;

begin
    -- Make sure the used supplied two args
    if Ada.Command_Line.Argument_Count /= 2 then
        raise Usage_Error;
    end if;

    declare 
        InputFile       : Ada.Text_IO.File_Type;
        Line_Count      : Natural := 1;
        --Get the number of elements from the user
        Max_Elements : Natural := Natural'Value(Ada.Command_Line.Argument(2));
        -- Setup the Graph
        Graph : Graph_Array(1 .. Max_Elements, 1 .. Max_Elements);
    begin
        -- Open a File
        Ada.Text_IO.Open(InputFile, Ada.Text_IO.In_File, Ada.Command_Line.Argument(1));
        while not Ada.Text_IO.End_Of_File (InputFile) loop
            declare 
                -- get a line from a file
                Line : String := Ada.Text_IO.Get_Line(InputFile);
            begin
                -- Build matrix
                for i in Line'Range loop
                    if Line(i) = '1' then
                        Graph(Line_Count, i) := True;
                    else
                        Graph(Line_Count, i) := False;
                    end if;
                end loop;
                Line_Count := Line_Count + 1;
            end;
        end loop;
        
        -- Build component stack
        Find_Components(Graph); 

        -- Count Components
        Ada.Text_IO.Put_Line("There are" & Natural'Image(Comp_Stack.Count(Components)) & " Connected Components.");
        -- Print All the Components 
        Print_Components(Graph);
        Ada.Text_IO.Close (InputFile);
    end;
exception
    when Usage_Error =>
        Ada.Text_IO.Put_Line("Improper Usage! Please supply graph file, followed by the number of elements.");
        Ada.Text_IO.Put_Line("./main [file] [number_of_elements]");
end main;
