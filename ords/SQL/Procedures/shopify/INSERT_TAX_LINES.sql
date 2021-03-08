--------------------------------------------------------
--  DDL for Procedure INSERT_TAX_LINES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MW_ECOMMERCE"."INSERT_TAX_LINES" 
(
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
  INSERT INTO sp_tax_lines (order_id)
SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            "order_id" NUMBER PATH '$.id'
            )
        );
END INSERT_TAX_LINES;

/
