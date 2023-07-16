-- Write a PL/SQL block to calculate the incentive(0.5%) of an employee whose ID is 110.

DECLARE
	incentive NUMBER(8, 2);
BEGIN
	SELECT salary * 0.5
	INTO   incentive
	FROM   employees
	WHERE  employee_id = 110;
	dbms_output.put_line('Incentive  = ' || incentive);
END;
/

-- Write a PL/SQL program to check whether a number is even or odd.

DECLARE

INPUT NUMBER;

BEGIN

INPUT := &INPUT;

IF INPUT MOD 2  = 0 THEN

DBMS_OUTPUT.PUT_LINE('The number is even.');

ELSE 

DBMS_OUTPUT.PUT_LINE('The number is odd.');

END IF;

END;
/

-- Write a PL/SQL program to check whether a given character is letter or digit.

DECLARE

INPUT CHAR(1);
ascii_number NUMBER;

BEGIN

input := '&input';

ascii_number := ASCII(INPUT);

IF ascii_number BETWEEN 65 AND 90 OR ascii_number BETWEEN 97 AND 122 THEN

DBMS_OUTPUT.PUT_LINE('The symbol is a letter.');

ELSIF ascii_number BETWEEN 48 AND 57 THEN

DBMS_OUTPUT.PUT_LINE('The symbol is a digit.');

END IF;
END;
/


-- Write a PL/SQL program to arrange the number of two variable in such a way that the small number will store
-- in num_small variable and large number will store in num_large variable.

-- A simple excercise for using if statements, loops and procedures - stored within the code block or within other procedures; 

DECLARE
	smallest_num NUMBER(13, 2) := 2147483647;
	mid_num      NUMBER(8, 2) := 0;
	biggest_num  NUMBER(8, 2) := 0;
	input_one    NUMBER(8, 2);
	input_two    NUMBER(8, 2);
	input_three  NUMBER(8, 2);
      
	PROCEDURE store_input(input        IN NUMBER
				   ,input2       IN NUMBER
				   ,input3       IN NUMBER
				   ,smallest_num IN OUT NUMBER
				   ,mid_num      IN OUT NUMBER
				   ,biggest_num  IN OUT NUMBER) IS
		PROCEDURE check_input(input        IN NUMBER
					   ,smallest_num IN OUT NUMBER
					   ,mid_num      IN OUT NUMBER
					   ,biggest_num  IN OUT NUMBER) IS
		BEGIN
			IF input < smallest_num
			THEN
				biggest_num  := mid_num;
				mid_num      := smallest_num;
				smallest_num := input;
			ELSIF input < mid_num
			THEN
				biggest_num := mid_num;
				mid_num     := input;
			ELSE
				biggest_num := input;
			END IF;
		END check_input;
	
	BEGIN
		check_input(input, smallest_num, mid_num, biggest_num);
		check_input(input2, smallest_num, mid_num, biggest_num);
		check_input(input3, smallest_num, mid_num, biggest_num);
	END store_input;

BEGIN
/*      
      PL/SQL is not an interactive language. It is SQL*Plus that is prompting you for a value and it
      needs to get all the substitution values it needs before it can send the PL/SQL block to the database
      to be executed. So, there is no way for PL/SQL to prompt the user for input in loop.
      
      FOR N_TIMES IN 1..3
      LOOP
            input := &input;
            check_input(input, smallest_num, mid_num, biggest_num);
            DBMS_OUTPUT.PUT_LINE(3)
      END LOOP;
*/      
      
	input_one   := &input1;
	input_two   := &input2;
	input_three := &input3;
	store_input(input_one, input_two, input_three, smallest_num, mid_num, biggest_num);
	dbms_output.put_line(smallest_num);
	dbms_output.put_line(mid_num);
	dbms_output.put_line(biggest_num);
END;
