--------------------------------------------------------
--  DDL for Procedure UPDATE_DISCOUNT_APPLICATIONS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_DISCOUNT_APPLICATIONS" (p_id IN NUMBER, p_body_text IN CLOB) AS 
BEGIN
UPDATE sp_discount_applications da
SET ("TYPE", "VALUE", value_type, allocation_method, target_selection, target_type, code)
= (SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            nested PATH '$.discount_applications[*]'
                columns(
	        	    "TYPE" VARCHAR2(50) PATH '$.type',
    		        "VALUE" NUMBER PATH '$.value',
	        	    value_type VARCHAR2(50) PATH '$.value_type',
    		        allocation_method VARCHAR2(50) PATH '$.allocation_method',
                    target_selection VARCHAR2(50) PATH '$.target_selection',
    		        target_type VARCHAR2(50) PATH '$.target_type',
                    code VARCHAR2(50) PATH '$.code'
                )
            )
        ) as jt
    )  WHERE da.order_id = p_id;
END UPDATE_DISCOUNT_APPLICATIONS;

/
