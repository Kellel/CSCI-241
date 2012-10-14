package body Tree_Expression is
    -- **Generic To_String**
    -- Takes a tree_string and and makes it into a shorter string 
    function To_String ( Input : Tree_String ) return String is
        last : Natural := 0;
    begin
        for I in Input'Range loop
            if Input(I) /= ' ' then
                last := last + 1;
            end if;
        end loop;
        if last = 1 then 
            -- the extra space adds readablity
            return Input(Input'First)& ' ';
        else 
            return Input(Input'First .. last) & ' ';
        end if;
    end To_String;

----------------------------------------------------------------------

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

--------------------------------------------------------------------
    --
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
            raise Number_Error;
        end if;
        -- If the First and Last number are the same just get the number
        if First = input'First then
            Ada.Integer_Text_IO.Get(From=>input, Item=>output, Last=>last);
            return float(output);
        -- First and last are different so get a range of numbers
        else
            Ada.Integer_Text_IO.Get(input(First .. input'Last), output, last);
            return float(output);
        end if;
    end To_Number;

--------------------------------------------------------------------------------

    -- Attempts to Construct an Expression Tree from a string...
    function Construct ( Expression_String : String ) return Expression_Node_Ptr is
        -- Returns a string when given a character (nessisary for creating a node)
        function To_String ( Input : Character ) return String is
            output : Tree_String;
        begin
            output (output'first) := Input;
            for I in output'Range loop
                if I > output'First then
                    output(I) := ' ';
                end if;
            end loop;
            return output;
        end To_String;
        -- Returns the first Operator f
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

-----------------------------------------------------------------------------
    --
    -- recursive wrapper to Evaluate an Expression tree
    function Evaluate ( Node : Expression_Node_Ptr ) return Float is
        --recursive algo
        function eval ( Node : Expression_Node_Ptr ) return Float is 
            Data : Tree_String := GT.Get_Data(Node);
            Operator : Character;
        begin
            -- Assume the char is always an operator
            Operator := To_Char(Data);
            case Operator is
                when '+' =>
                    -- Add the left and right
                    return eval(GT.Get_Left_Child(Node)) + eval(GT.Get_Right_Child(Node));
                when '-' =>
                    -- Subtract the left from the right
                    return eval(GT.Get_Left_Child(Node)) - eval(GT.Get_Right_Child(Node));
                when '*' =>
                    -- Multiply the right by the left
                    return eval(GT.Get_Left_Child(Node)) * eval(GT.Get_Right_Child(Node));
                when '/' =>
                    -- Divide the left by the right
                    return eval(GT.Get_Left_Child(Node)) / eval(GT.Get_Right_Child(Node));
                when '^' =>
                    -- return the left to the power of the right
                    return Float_Functions."**"(eval(GT.Get_Left_Child(Node)), eval(GT.Get_Left_Child(Node)));
                when others =>
                    -- shouldn't happen with valid input
                    raise Expression_Error;
            end case;
        exception
            when Operator_Error =>
                -- It's not an operator, so it must be a number
                return To_Number(Data);
        end eval;
    begin
        return eval (Node);
    end Evaluate;

-----------------------------------------------------------------------------------------
    --
    -- It would be hard to get the parens back in the right order so I just save it and return the string 0.o
    function Infix_Notation ( Node : Expression_Node_Ptr ) return String is 
    begin
        return Expression_Save;
    end Infix_Notation;

----------------------------------------------------------------------------------------
    --
    -- Return the Preorder_Traversal
    function Prefix_Notation ( Node : Expression_Node_Ptr ) return String is
    begin
        return GT.Preorder_Traversal(Node);
    end Prefix_Notation;

------------------------------------------------------------------------------------------
    --
    -- Return the Postorder_Traversal
    function Postfix_Notation ( Node : Expression_Node_Ptr ) return String is
    begin
        return GT.Postorder_Traversal(Node);
    end Postfix_Notation;

end Tree_Expression;


