--------------------------------------------------------
--  DDL for Procedure UPDATE_NOTE_ATTRIBUTES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_NOTE_ATTRIBUTES" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
UPDATE sp_note_attributes na SET ("NAME", "VALUE")
= (SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            nested PATH '$.note_attributes[*]'
                columns(
	        	    "NAME" VARCHAR2(50) PATH '$.name',
                    "VALUE" VARCHAR2(100) PATH '$.value'
                )
            )
        ) jt WHERE jt."NAME" = na."NAME"
    )  WHERE na.order_id = p_id ;
END UPDATE_NOTE_ATTRIBUTES;

/
