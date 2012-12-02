-- Assignment 5 Extra Credit
--
-- 1. Read File
-- 2. Build association
-- 3. Print number of connected components
-- 4. Print connected component matrix

with Ada.Text_IO;

procedure main is
    Max_Elements    : Positive := 6;
    type Element is record
        Value : Boolean := False;
        Found : Boolean := False;
    end record;
    type Graph_Array is array (1 .. Max_Elements, 1 .. Max_Elements) of Element;
    Graph           : Graph_Array;
    InputFile       : Ada.Text_IO.File_Type;
    Line_Count      : Natural := Graph_Array'First;
    procedure Component (Graph : Graph_Array) is
    begin
        for i in Graph'Range loop
            for j in Graph'Range loop
                if Graph(i,j).Value then
                    Ada.Text_IO.Put('1');
                else
                    Ada.Text_IO.Put('0');
                end if;
            end loop;
            Ada.Text_IO.New_Line;
        end loop;
    end Component;
begin
    Ada.Text_IO.Open(InputFile, Ada.Text_IO.In_File, "graph.txt");
    while not Ada.Text_IO.End_Of_File (InputFile) loop
        declare 
            Line : String := Ada.Text_IO.Get_Line(InputFile);
        begin
            for i in Line'Range loop
                if Line(i) = '1' then
                    Graph(Line_Count, i).Value := True;
                else
                    Graph(Line_Count, i).Value := False;
                end if;
            end loop;
            Line_Count := Line_Count + 1;
        end;
    end loop;
    Component(Graph);
    Ada.Text_IO.Close (InputFile);
end main;
