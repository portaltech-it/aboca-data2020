--------------------------------------------------------
--  DDL for Procedure INSERT_REFUNDS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MW_ECOMMERCE"."INSERT_REFUNDS" 
(
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
  INSERT INTO sp_refunds (order_id)
SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            "order_id" NUMBER PATH '$.id'
            )
        );
END INSERT_REFUNDS;

/
