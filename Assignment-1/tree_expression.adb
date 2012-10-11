package body Tree_Expression is

    function To_String ( Input : Character ) return String is
        output : Tree_String;
    begin
        output ( 1 ) := Input;
        return output;
    end To_String;

    function Construct ( Expression_String : String ) return Expression_Node_Ptr is
        type Number_Type is ( '0', '1', '2', '3', '4', '5', '6', '7', '8', '9');
        type Expression_Type is ( '+', '-', '*', '/' );
        -- Recursive function to parse an Expression_String
        -- based on the assumption that you can use a range as an index
        -- if ( ) remove the parens and send the inside stuff back into recursion
        function construct ( Expression_String : String ) return Expression_Node_Ptr is
            Number_Length : Natural := 1;
            Last : Natural := Expression_String'Length;
            First : Natural := 0;
            Paren : Natural := 0;
        begin
            -- Look for Operator first 
            for I in Expression_String'Range loop
                if Expression_String (I) = '(' then
                    Paren := Paren + 1;
                elsif Expression_String (I) = '(' then
                    Paren := Paren + 1;
                elsif Paren = 1 and (Expression_String (I) in Expression_Type) then
                    return Gen_Tree.Create_Node ( To_String (Expression_String(I)), construct ( Expression_String(First .. (I - 1))), construct ( Expression_String ((I + 1) .. Last)));
                end if;
            end loop;
            Paren := 0;            
            for I in Expression_String'Range loop
                if Expression_String (I) = '(' then
                    Paren := Paren + 1;
                elsif Expression_String (I) = ')' then
                    Paren := Paren - 1;
                elsif Paren = 1 and (Expression_String (I) in Number_Type) then
                    -- if it is a number then collect all the digits
                    declare
                        --create a local variable to loop with
                        J : Natural := 0;
                    begin
                        loop
                            exit when Expression_String (J) not in Number_Type;
                            J := J + 1;
                        end loop;
                        return Gen_Tree.Create_Node ( Expression_String((I+1) .. J), null, null);
                    end;
                else 
                    raise Expression_Error;
                end if;
            end loop;    
        end construct;
    begin
        return construct ( Expression_String );
    end Construct;

    function Evaluate ( Node : Expression_Node_Ptr ) return Float is 
    begin
        return 2.345;
    end Evaluate;

    function Infix_Notation ( Node : Expression_Node_Ptr ) return String is 
    begin
        return "Test";
    end Infix_Notation;

    function Prefix_Notation ( Node : Expression_Node_Ptr ) return String is
    begin
        return "Test";
    end Prefix_Notation;

    function Postfix_Notation ( Node : Expression_Node_Ptr ) return String is
    begin
        return "Test";
    end Postfix_Notation;

end Tree_Expression;
