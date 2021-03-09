--------------------------------------------------------
--  DDL for Procedure UPDATE_DISCOUNT_CODES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_DISCOUNT_CODES" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
UPDATE sp_discount_codes dc SET (code, amount, "TYPE")
= (SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            nested PATH '$.discount_codes[*]'
                columns(
                    code VARCHAR2(50) PATH '$.code',
    		        amount NUMBER PATH '$.amount',
                    "TYPE" VARCHAR2(50) PATH '$.type'

                )
            )
        ) as jt WHERE dc.order_id = p_id  
    );
END UPDATE_DISCOUNT_CODES;

/
