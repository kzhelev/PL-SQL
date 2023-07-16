CREATE OR REPLACE FUNCTION get_rows_count_test RETURN NUMBER IS
int_test NUMBER;
BEGIN
SELECT MAX(rn)
      INTO   int_test
      FROM   (SELECT customer_no,
                     customer_name1,
                     address_line4,
                     row_number() over(ORDER BY customer_name1) AS rn
              FROM   sttm_customer
              WHERE  address_line4 = '—Œ‘»ﬂ');
              RETURN int_test;
END;
/

CREATE FUNCTION get_customer_no_test(counter NUMBER) RETURN VARCHAR2 IS
customer_no VARCHAR2(100);

BEGIN
      SELECT customer_no
      INTO   customer_no
      FROM   (SELECT customer_no,
                           customer_name1,
                           address_line4,
                           row_number() over(ORDER BY customer_name1) AS rn
                    FROM   sttm_customer
                    WHERE  address_line4 = '—Œ‘»ﬂ')
      WHERE  rn = counter;
      RETURN customer_no;
END;
/                    

CREATE FUNCTION get_customer_name1_test(counter NUMBER) RETURN VARCHAR IS
customer_name VARCHAR2 (100);

BEGIN
SELECT customer_name1
      INTO   customer_name
      FROM   (SELECT customer_no,
                           customer_name1,
                           address_line4,
                           row_number() over(ORDER BY customer_name1) AS rn
              FROM   sttm_customer
              WHERE  address_line4 = '—Œ‘»ﬂ')
     WHERE  rn = counter;
     RETURN customer_name;
END;
/           

DECLARE
      int_test      NUMBER;
      counter       INT := 1;
      customer_no   VARCHAR2(100);
      customer_name VARCHAR2(100);
BEGIN
      int_test := test_function1;
      
      WHILE (int_test > 0)
      LOOP
            customer_no := get_customer_no(counter);
            customer_name := get_customer_name1(counter);
            
            dbms_output.put_line(' ÎËÂÌÚÒÍË ÌÓÏÂ: ' || customer_no || '  ÎËÂÌÚ: ' || customer_name);
            dbms_output.new_line;
            int_test := int_test - 1;
            counter  := counter + 1; 
      END LOOP;
END;
/

DECLARE

customer_no   VARCHAR2(100);
customer_name VARCHAR2(100);

BEGIN

FOR R_NUM IN (SELECT CUSTOMER_NAME1, CUSTOMER_NO
                          FROM STTM_CUSTOMER
                          WHERE  address_line4 = '—Œ‘»ﬂ')
LOOP

CUSTOMER_NAME := R_NUM.CUSTOMER_NAME1;
CUSTOMER_NO := R_NUM.CUSTOMER_NO;
                 
DBMS_OUTPUT.PUT_LINE('CUSTOMER NO: ' || customer_no || ' CUSTOMER NAME: ' || customer_name);

END LOOP;

END;
/

DECLARE

customer_no   VARCHAR2(100);
customer_name VARCHAR2(100);

CURSOR CRS_CUSTOMER IS
SELECT CUSTOMER_NAME1, CUSTOMER_NO
                          FROM STTM_CUSTOMER
                          WHERE  address_line4 = '—Œ‘»ﬂ';

BEGIN

FOR R_NUM IN CRS_CUSTOMER
LOOP

CUSTOMER_NAME := R_NUM.CUSTOMER_NAME1;
CUSTOMER_NO := R_NUM.CUSTOMER_NO;
                 
DBMS_OUTPUT.PUT_LINE('CUSTOMER NO: ' || customer_no || ' CUSTOMER NAME: ' || customer_name);
DBMS_OUTPUT.PUT_LINE(CRS_CUSTOMER%ROWCOUNT);

EXIT WHEN CRS_CUSTOMER%ROWCOUNT = 10;

END LOOP;

END;
/

DECLARE

customer_no   VARCHAR2(100);
customer_name VARCHAR2(100);

BEGIN

SELECT CUSTOMER_NAME1 INTO CUSTOMER_NAME FROM STTM_CUSTOMER
WHERE ADDRESS_LINE4 = '—Œ‘»ﬂ'
AND ROWNUM = 1;
                 
SELECT CUSTOMER_NO INTO CUSTOMER_NO FROM STTM_CUSTOMER
WHERE ADDRESS_LINE4 = '—Œ‘»ﬂ'
AND ROWNUM = 1;
                 
DBMS_OUTPUT.PUT_LINE('CUSTOMER NO: ' || customer_no || ' CUSTOMER NAME: ' || customer_name);

END;
/

DECLARE

V_INPUT VARCHAR2(10) := '&INPUT';
E_INVALID_INPUT EXCEPTION;

BEGIN

IF LENGTH(V_INPUT) < 6 OR LENGTH(V_INPUT) > 10 THEN
RAISE E_INVALID_INPUT;
END IF;

DBMS_OUTPUT.PUT_LINE('VALID INPUT');

EXCEPTION
WHEN E_INVALID_INPUT THEN
DBMS_OUTPUT.PUT_LINE('Ivanlid input');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE(SQLCODE);
DBMS_OUTPUT.PUT_LINE(SQLERRM);

END;
/

CREATE OR REPLACE TYPE STUDENT_TYP AS OBJECT (
FIRST_NAME VARCHAR2(50),
LAST_NAME VARCHAR2(50),
AGE NUMBER(10),
MEMBER PROCEDURE display_info
);
/

CREATE OR REPLACE TYPE BODY STUDENT_TYP AS

	MEMBER PROCEDURE display_info IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(first_name);  
  END;

END;
/

DECLARE 

gosho student_typ;

BEGIN

gosho := student_typ('GOSHO', 'PESHO', 15); 
gosho.display_info;

END;
/


