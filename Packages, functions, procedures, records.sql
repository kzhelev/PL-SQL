CREATE TABLE TEST_KRIS (
CUSTOMER_NO VARCHAR2(9),
CUSTOMER_TYPE CHAR(1),
CUSTOMER_NAME1 VARCHAR2(105),
ADDRESS_LINE1 VARCHAR2(105),
ADDRESS_LINE4 VARCHAR2(105),
COUNTRY VARCHAR2(3)
);

DECLARE

CURSOR select_from_sttm_customer IS
SELECT CUSTOMER_NO, CUSTOMER_TYPE, CUSTOMER_NAME1, ADDRESS_LINE1, ADDRESS_LINE4, COUNTRY
FROM STTM_CUSTOMER
WHERE ADDRESS_LINE4 = '—Œ‘»ﬂ';

BEGIN

FOR ROW_NUM IN select_from_sttm_customer
LOOP
INSERT INTO TEST_KRIS (CUSTOMER_NO, CUSTOMER_TYPE, CUSTOMER_NAME1, ADDRESS_LINE1, ADDRESS_LINE4, COUNTRY)
VALUES(ROW_NUM.CUSTOMER_NO, ROW_NUM.CUSTOMER_TYPE, ROW_NUM.CUSTOMER_NAME1, ROW_NUM.ADDRESS_LINE1, ROW_NUM.ADDRESS_LINE4, ROW_NUM.COUNTRY);

DBMS_OUTPUT.put_line(select_from_sttm_customer%ROWCOUNT);

EXIT WHEN select_from_sttm_customer%ROWCOUNT = 40;
END LOOP;

COMMIT;
END;



CREATE OR REPLACE PACKAGE test_pack_kris IS

	TYPE ROWDIT IS RECORD(
		customer_no    VARCHAR2(9),
		customer_type  CHAR(1),
		customer_name1 VARCHAR2(105),
		address_line1  VARCHAR2(105),
		address_line4  VARCHAR2(105),
		country        VARCHAR2(3));

	FUNCTION get_nth_row RETURN ROWDIT;
      
      PROCEDURE ADD_ONE_TO_R_NUM;

END test_pack_kris;
/

CREATE OR REPLACE PACKAGE BODY test_pack_kris IS

FUNCTION get_nth_row RETURN ROWDIT IS

row_info ROWDIT;

CURSOR table_info IS
SELECT * FROM test_kris;

input NUMBER := &input;

BEGIN

FOR row_num IN table_info LOOP

IF table_info%ROWCOUNT = input THEN

row_info.customer_no := row_num.customer_no;
row_info.customer_type := row_num.customer_type;
row_info.customer_name1 := row_num.customer_name1;
row_info.address_line1 := row_num.address_line1;
row_info.address_line4 := row_num.address_line4;
row_info.country := row_num.country;

END IF;

EXIT WHEN table_info%ROWCOUNT = input;

END LOOP;

RETURN row_info;

END get_nth_row;

PROCEDURE ADD_ONE_TO_R_NUM IS

CURSOR CRS_R_NUM IS
SELECT R_NUM FROM test_kris;

BEGIN

FOR ROW_NUM IN CRS_R_NUM LOOP

UPDATE test_kris
SET R_NUM = R_NUM + 1;

END LOOP;

END ADD_ONE_TO_R_NUM;

END test_pack_kris;
/

DECLARE

v_test test_pack_kris.ROWDIT;

BEGIN

v_test := test_pack_kris.get_nth_row;

dbms_output.put_line(v_test.customer_no);
dbms_output.put_line(v_test.customer_type);
dbms_output.put_line(v_test.customer_name1);
dbms_output.put_line(v_test.address_line1);
dbms_output.put_line(v_test.address_line4);
dbms_output.put_line(v_test.country);

test_pack_kris.ADD_ONE_TO_R_NUM;

END;
