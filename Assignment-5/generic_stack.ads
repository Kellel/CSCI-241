-- CSCI 241 
-- Kellen Fox
--

with Ada.Text_IO; use Ada.Text_IO;

generic
    type Element_Type is private;
package Generic_Stack is
    
    type Ptr is private;
    type Stack is limited private;
    
    procedure Pop(Element : out Element_Type; This : in out Stack);
    procedure Push(Data : Element_Type; This : in out Stack);
    function Count(This : Stack) return Natural;
    Empty : Exception;

private
    
    type Node;
    type Ptr is access Node;
    type Node is record
        Data : Element_Type;
        Next : Ptr;
    end record;
    type Stack is record
        Root: Ptr;
    end record;
    
end Generic_Stack;
