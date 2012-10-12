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
        function construct ( Expression : String ) return Expression_Node_Ptr is
            Number_Length : Natural := 1;
            Last : Natural := Expression'Length;
            First : Natural := 1;
            Paren : Integer := 0;
        begin
            -- Look for Operator first 
            Ada.Text_IO.put("Testing");
            Ada.Text_IO.put_line(Expression);
            for I in Expression'Range loop

                if Expression (I) = '(' then
                    Paren := Paren + 1;
                elsif Expression (I) = ')' then
                    Paren := Paren - 1;
                elsif Paren = 1 and Operators(Expression(I)) then
                    if (First + 1) = (I - 1) and (I + 1) = Last then
                        return GT.Create_Node (To_String(Expression(I)), construct(To_String(Expression(First + 1))), construct(To_String(Expression(I + 1))));
                    elsif (First + 1) = (I - 1) then
                        return GT.Create_Node(To_String(Expression(I)), construct(To_String(Expression(First +1))), construct(Expression((I + 1) .. Last)));
                    elsif (I + 1) = Last then
                        return GT.Create_Node(To_String(Expression(I)), construct(Expression((First + 1) .. (I - 1))), construct(To_String(Expression(I + 1))));
                    else
                        return GT.Create_Node(To_String(Expression(I)), construct(Expression((First + 1) .. (I - 1))), construct(Expression((I + 1) .. Last)));
                    end if;
                end if;
            end loop;
            -- 
            -- **** My embeded rant about ada ****
            --    ** Disclaimer **
            --      This really doesn't have much to do with this assignment, but I was annoyed enough when I was writing this assignment that 
            --      I fugure I might as well leave it in. Don't feel obligated to read it.
            --
            --  For the most part I have no problem with ada. I view the complexities of ada almost like a chalenge, 
            --  but for this assignment I ran into one major flaw: the attributes associated with a given array seem to
            --  be static. For example, if you have a recursive function like this one, if you send just a portion of 
            --  an array back into the function the 'First and the 'Last are never recomputed. Lets say you have
            --  an array with a range of (1 .. 20). The first time through the recursion if you viewed 'First you would get 1, 
            --  as you would expect. Now lets say your recursive call sends the last half of the string back
            --  into the function. If you viewed 'First now you would get 10... wut? Now forgive me if I'm wrong, 
            --  but that makes NO sense. OK, fine. I get it, when the function returns the smaller part it just doesn't
            --  give you a new string with the new subset of characters in it, it just cuts the thing in half and gives it back to you... 
            --  0.o  What were the people who wrote this really that lazy? 
            --  And why was this never covered in any of the beginning ada classes? 
            --  This explains why every time I have attempted to write a recursive ada function I have failed...
            --       **** End Rant ****
            --
            declare
                First_Number : Natural;
                Current : Natural := 0;
                Last_Number  : Natural := Expression'First - 1;
            begin
                for J in Expression'Range loop
                    Ada.Integer_Text_IO.put(J);
                    if Numbers(Expression(J)) then
                        First_Number := J;
                        exit;
                    end if;
                end loop;
                for I in Expression'Range loop
                    Ada.Integer_Text_IO.put(I);
                    if Numbers(Expression(I)) then
                        Last_Number := Last_Number + 1;
                    end if;
                end loop;
                if First_Number = Last_Number then
                    return GT.Create_Node(To_String(Expression(First_Number)), null, null);
                else
                    return GT.Create_Node(Expression((First_Number) .. (Last_Number)), null, null);
                end if;
            end;
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
