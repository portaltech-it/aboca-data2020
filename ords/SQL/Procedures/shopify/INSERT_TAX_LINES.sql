--------------------------------------------------------
--  DDL for Procedure INSERT_TAX_LINES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "INSERT_TAX_LINES" 
(
  P_ID IN NUMBER ,
  P_BODY_TEXT in CLOB
) AS 
BEGIN
  INSERT INTO sp_tax_lines (order_id) VALUES(p_id);
END INSERT_TAX_LINES;

/
