--------------------------------------------------------
--  DDL for Procedure INSERT_DISCOUNT_CODES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MW_ECOMMERCE"."INSERT_DISCOUNT_CODES" 
(
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
INSERT INTO sp_discount_codes (order_id, code, amount, "TYPE")
SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            "order_id" NUMBER PATH '$.id',
            nested PATH '$.discount_codes[*]'
                columns(
	        	    "TYPE" VARCHAR2(50) PATH '$.type',
    		        amount NUMBER PATH '$.amount',
                    code VARCHAR2(50) PATH '$.code'
                )
        )
    );
END INSERT_DISCOUNT_CODES;

/
