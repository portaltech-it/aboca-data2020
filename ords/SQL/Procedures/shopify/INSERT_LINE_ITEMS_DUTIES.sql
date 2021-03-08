--------------------------------------------------------
--  DDL for Procedure INSERT_LINE_ITEMS_DUTIES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MW_ECOMMERCE"."INSERT_LINE_ITEMS_DUTIES" 
(
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
INSERT INTO sp_line_items_duties (line_item_id, order_id) 
SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            nested PATH '$.line_items[*]'
                columns(
                    line_item_id NUMBER(18) PATH '$.id'
                ),
                "order_id" NUMBER PATH '$.id'
        )
    );
END INSERT_LINE_ITEMS_DUTIES;

/
