--------------------------------------------------------
--  DDL for Procedure INSERT_NOTE_ATTRIBUTES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MW_ECOMMERCE"."INSERT_NOTE_ATTRIBUTES" 
(
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
INSERT INTO sp_note_attributes (order_id, "NAME", "VALUE")
SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            "order_id" NUMBER PATH '$.id',
            nested PATH '$.note_attributes[*]'
                columns(
	        	    "NAME" VARCHAR2(50) PATH '$.name',
                    "VALUE" VARCHAR2(50) PATH '$.value'
                )
        )
    );
END INSERT_NOTE_ATTRIBUTES;

/
