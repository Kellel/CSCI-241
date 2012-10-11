package body Tree_Expression is

    function To_String ( Input : Character ) return String is
        output : Tree_String;
    begin
        output ( 1 ) := Input;
        return output;
    end To_String;

    function Construct ( Expression_String : String ) return Expression_Node_Ptr is
        type Number_Set is array (Character) of Boolean;
        Numbers : constant Number_Set := ( '0' => True, '1'=>True, '2'=>True, '3'=>True, '4'=> True, '5'=>True, '6'=>True, '7'=>True, '8'=>True, '9'=>True, others => False);
    	-- type Number_Type is ( '0', '1', '2', '3', '4', '5', '6', '7', '8', '9');
        type Operator_Set is array (Character) of Boolean;
	    Operators : constant Operator_Set := ( '+' => True, '-' => True, '*' => True, '/' => True, others => False);
        -- subtype Expression_Type is Character ( '+', '-', '*', '/' );
        -- Recursive function to parse an Expression_String
        -- based on the assumption that you can use a range as an index
        -- if ( ) remove the parens and send the inside stuff back into recursion
        function construct ( Expression_String : String ) return Expression_Node_Ptr is
            Number_Length : Natural := 1;
            Last : Natural := Expression_String'Length;
            First : Natural := 1;
            Paren : Natural := 0;
        begin
            -- Look for Operator first 
            Ada.Text_IO.put("Testing");
            for I in Expression_String'Range loop
                if Expression_String (I) = '(' then
                    Paren := Paren + 1;
                elsif Expression_String (I) = '(' then
                    Paren := Paren + 1;
                elsif Paren = 1 and Operators(Expression_String(I))  then
                    return GT.Create_Node (To_String(Expression_String(I)), construct(Expression_String(First .. (I-1))), construct(Expression_String((I + 1) .. Last)));
                end if;
            end loop;
            Paren := 0;            
            Ada.Text_IO.put("number");
            -- There are no operators left so get the number
            declare
                First_Number : Natural := 1;
                Current_Number : Natural := 1;
                Last_Number  : Natural;
            begin
                loop
                    if Numbers(Expression_String(Current_Number)) then
                        First_Number := Current_Number;
                        exit;
                    else
                        Current_Number := Current_Number + 1;
                    end if;
                    if Current_Number = Last then
                        exit;
                    end if;
                end loop;
                -- Find the last digit
                Current_Number := First_Number;
                loop
                    if Numbers(Expression_String(Current_Number)) then
                        Current_Number := Current_Number + 1;
                    elsif Current_Number = Last then
                        exit;
                    else
                        exit;
                    end if;
                end loop;
                Last_Number := Current_Number;
                if First_Number = Last_Number then
                    return GT.Create_Node(To_String(Expression_String(First_Number)), null, null);
                else
                    return GT.Create_Node(Expression_String(First_Number .. Last_Number), null, null);
                end if;
            end;

                    

            --for I in Expression_String'Range loop
            --    if Numbers(Expression_String(I)) then
            --        -- if it is a number then collect all the digits
            --        declare
            --            --create a local variable to loop with
            --            J : Natural := 0;
            --        begin
            --            loop
            --                exit when (not Numbers(Expression_String(I + J))) or (I+J) = Last;
            --                J := J + 1;
            --            end loop;
            --            if J = 0 then
            --                return GT.Create_Node ( To_String(Expression_String(I)), null, null);
            --            else
            --                return GT.Create_Node (Expression_String(I .. (I+J)), null, null);
            --            end if;
            --        end;
            --    end if;
            --end loop;    
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
