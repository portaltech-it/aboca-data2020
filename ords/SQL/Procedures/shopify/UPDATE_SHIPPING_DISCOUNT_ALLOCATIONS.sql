--------------------------------------------------------
--  DDL for Procedure UPDATE_SHIPPING_DISCOUNT_ALLOCATIONS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_SHIPPING_DISCOUNT_ALLOCATIONS" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
UPDATE sp_shipping_discount_allocations sda
SET (shipping_line_id) 
= (SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            nested PATH '$.shipping_lines[*]'
                columns(
                    ID NUMBER(18)    PATH '$.id'
            )
        )
    ) jt WHERE shipping_line_id = jt.id
) WHERE sda.order_id = p_id ;
END UPDATE_SHIPPING_DISCOUNT_ALLOCATIONS;

/
