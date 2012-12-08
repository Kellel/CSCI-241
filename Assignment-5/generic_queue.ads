-- CSCI 241 
-- Kellen Fox
--

generic
    type Element_Type is private;
package Generic_Queue is
    
    type Ptr is private;
    type Queue is limited private;
    
    procedure Pop(Element : out Element_Type; This : in out Queue);
    procedure Push(Data : Element_Type; This : in out Queue);
    function Count(This : Queue) return Natural;
    Empty : Exception;

private
    
    type Node;
    type Ptr is access Node;
    type Node is record
        Data : Element_Type;
        Next : Ptr;
    end record;
    type Queue is record
        Root: Ptr;
    end record;
    
end Generic_Queue;
