--------------------------------------------------------
--  DDL for Procedure INSERT_SHIPPING_DISCOUNT_ALLOCATIONS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MW_ECOMMERCE"."INSERT_SHIPPING_DISCOUNT_ALLOCATIONS" 
(
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
INSERT INTO sp_shipping_discount_allocations
(order_id, shipping_line_id) 
SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            "order_id" NUMBER PATH '$.id',
            nested PATH '$.shipping_lines[*]'
                columns(
                    ID NUMBER(18)    PATH '$.id'
            )
        )
    );
END INSERT_SHIPPING_DISCOUNT_ALLOCATIONS;

/
