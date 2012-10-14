package body Tree_Expression is
    -- Takes a character and makes it into a string 
    function To_String ( Input : Character ) return String is
        output : Tree_String;
    begin
        output ( output'First ) := Input;
        for I in output'Range loop
            if I > output'First then
                output(I) := ' ';
            end if;
        end loop;
        return output;
    end To_String;
    -- Grabs the First Operator Type and returns it 
    function To_Char ( input : String ) return Character is
    begin
        for I in input'Range loop
            if Operators(input(I)) then
                return input(I);
            end if;
        end loop;
        --Ada.Text_IO.Put_Line(''' & input & ''');
        raise Operator_Error;
    end To_Char;
    -- Grabs one whole Integer type and returns it as a float
    function To_Number ( input : String ) return Float is
        output : Integer;
        First : Integer := -1;
        Last : Positive;
    begin
        -- find the first number in the string
        for I in input'Range loop
            if Numbers(input(I)) then
                First := I;
                exit;
            end if;
        end loop;
        -- Make sure a first number was found
        if First = -1 then 
            Ada.Text_IO.Put_Line(input);
            raise Number_Error;
        end if;
        -- If the First and Last number are the same just get the number
        if First = input'First then
            Ada.Integer_Text_IO.Get(From=>input, Item=>output, Last=>last);
            --Ada.Integer_text_IO.put(output);
            return float(output);
        else
            Ada.Integer_Text_IO.Get(input(First .. input'Last), output, last);
            --Ada.Integer_Text_IO.put(output);
            return float(output);
        end if;
    end To_Number;
    function Short ( input : String ) return String is
    begin
        return input(input'First .. input'First + 2);
    end Short;

    -- Attempts to Construct an Expression Tree from a string...
    function Construct ( Expression_String : String ) return Expression_Node_Ptr is
        procedure Get_Operator ( Expression : String; Last : out Positive; Item : out Character ) is 
            Paren : Natural := 0; 
        begin
            Item := ' ';
           -- Ada.Text_IO.Put_Line(Expression);
            for i in Expression'Range loop
                case(Expression(i)) is
                    when '(' =>
                        Paren := Paren + 1;
                    when ')' =>
                        Paren := Paren - 1;
                    when '+'|'-'|'*'|'/'|'^' =>
                        if Paren = 1 then
                            Last := i;
                            Item := Expression(i);
                            exit;
                        end if;
                    when others =>
                        null;
                end case;
            end loop;
            -- Make sure an operator was found by raising an exception if there is no item or last
            if Item = ' ' then
                raise Operator_Error;
            end if;
            return;
        end Get_Operator;
        function To_Number (Expression : String) return String is
            output : Tree_String;
            last : Natural := output'First;
        begin
            --Ada.Text_IO.Put_Line(Expression);
            for i in Expression'Range loop
                if Numbers(Expression(i)) then
                    output(last) := Expression(i);
                    last := last + 1;
                end if;
            end loop;
            if last = output'First then
                raise Number_Error;
            end if;
            for i in Last .. output'Last loop
                output(i) := ' ';
            end loop;
            return output;
        end To_Number;
        -- subtype Expressionession_Type is Character ( '+', '-', '*', '/' );
        -- Recursive function to parse an Expression_String
        -- based on the assumption that you can use a range as an index
        -- if ( ) remove the parens and send the inside stuff back into recursion
        function construct_2 ( Expression : String ) return Expression_Node_Ptr is
            Operator : Character;
            Last : Positive;
        begin
            Get_Operator(Expression, Last, Operator);
            return GT.Create_Node(To_String(Operator), construct_2(Expression(Expression'First + 1 .. Last -1)), construct_2(Expression(Last + 1 .. Expression'Last - 1)));
        exception
            when Operator_Error =>
                --Ada.Text_IO.Put_Line(Expression);
                return GT.Create_Node(To_Number(Expression), null, null);
        end construct_2;
    begin
        for I in Expression_Save'Range loop
            if I in Expression_String'Range then
                Expression_Save(I) := Expression_String(I);
            else
                Expression_Save(I) := ' ';
            end if;
        end loop;
        return construct_2 ( Expression_String );
    end Construct;

    function Evaluate ( Node : Expression_Node_Ptr ) return Float is
        function eval ( Node : Expression_Node_Ptr ) return Float is 
            Data : Tree_String := GT.Get_Data(Node);
            Operator : Character := To_Char (Data);
        begin
            case Operator is
                when '+' =>
                    --Ada.Text_IO.put('+');
                    return eval(GT.Get_Left_Child(Node)) + eval(GT.Get_Right_Child(Node));
                when '-' =>
                    return eval(GT.Get_Left_Child(Node)) - eval(GT.Get_Right_Child(Node));
                when '*' =>
                    return eval(GT.Get_Left_Child(Node)) * eval(GT.Get_Right_Child(Node));
                when '/' =>
                    return eval(GT.Get_Left_Child(Node)) / eval(GT.Get_Right_Child(Node));
                when '^' =>
                    return Float_Functions."**"(eval(GT.Get_Left_Child(Node)), eval(GT.Get_Left_Child(Node)));
                when others =>
                    raise Expression_Error;
            end case;
        exception
            when Operator_Error =>
                case Operator is
                    when '+' =>
                        return To_Number(GT.Get_Data(GT.Get_Left_Child(Node))) + To_Number(GT.Get_Data(GT.Get_Right_Child(Node)));
                    when '-' =>
                        return To_Number(GT.Get_Data(GT.Get_Left_Child(Node))) + To_Number(GT.Get_Data(GT.Get_Right_Child(Node)));
                    when '*' =>
                        return To_Number(GT.Get_Data(GT.Get_Left_Child(Node))) * To_Number(GT.Get_Data(GT.Get_Right_Child(Node)));
                    when '/' =>
                        return To_Number(GT.Get_Data(GT.Get_Left_Child(Node))) / To_Number(GT.Get_Data(GT.Get_Right_Child(Node)));
                    when '^' =>
                        return Float_Functions."**"(To_Number(GT.Get_Data(GT.Get_Left_Child(Node))), To_Number(GT.Get_Data(GT.Get_Right_Child(Node))));
                    when others =>
                        raise Expression_Error;
                end case;
        end eval;
    begin
        return eval (Node);
    end Evaluate;

    function Infix_Notation ( Node : Expression_Node_Ptr ) return String is 
    begin
        return Expression_Save;
    end Infix_Notation;

    function Prefix_Notation ( Node : Expression_Node_Ptr ) return String is
    begin
        return Short(GT.Get_Data(Node))& Prefix_Notation(GT.Get_Left_Child(Node)) & Prefix_Notation(GT.Get_Right_Child(Node));
    exception
        when GT.Node_Error =>
            return Short(GT.Get_Data(Node))& Short(GT.Get_Data(GT.Get_Left_Child(Node))) & Short(GT.Get_Data(GT.Get_Right_Child(Node)));
    end Prefix_Notation;

    function Postfix_Notation ( Node : Expression_Node_Ptr ) return String is
    begin
        return Postfix_Notation(GT.Get_Left_Child(Node)) & Postfix_Notation(GT.Get_Right_Child(Node)) & Short(GT.Get_Data(Node));
    exception
        when GT.Node_Error =>
            return Short(GT.Get_Data(GT.Get_Left_Child(Node))) & Short(GT.Get_Data(GT.Get_Right_Child(Node))) & Short(GT.Get_Data(Node));
    end Postfix_Notation;

end Tree_Expression;


