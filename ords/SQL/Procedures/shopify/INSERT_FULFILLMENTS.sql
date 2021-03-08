--------------------------------------------------------
--  DDL for Procedure INSERT_FULFILLMENTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MW_ECOMMERCE"."INSERT_FULFILLMENTS" 
(
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
INSERT INTO sp_fulfillments (order_id)
SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            "order_id" NUMBER PATH '$.id'
            )
        );
END INSERT_FULFILLMENTS;

/
