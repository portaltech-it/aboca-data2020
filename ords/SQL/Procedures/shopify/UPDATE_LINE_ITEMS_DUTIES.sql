--------------------------------------------------------
--  DDL for Procedure UPDATE_LINE_ITEMS_DUTIES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_LINE_ITEMS_DUTIES" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
UPDATE sp_line_items_duties it 
SET (line_item_id) 
= (SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            nested PATH '$.line_items[*]'
                columns(
                    line_item_id NUMBER(18) PATH '$.id'
                )
            )
        )  jt WHERE it.line_item_id = jt.line_item_id
    ) WHERE it.order_id = p_id;
END UPDATE_LINE_ITEMS_DUTIES;

/
