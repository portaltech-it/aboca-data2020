--------------------------------------------------------
--  DDL for Procedure UPDATE_TAX_LINES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_TAX_LINES" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
  UPDATE sp_tax_lines SET order_id = p_id WHERE order_id = p_id;
END UPDATE_TAX_LINES;

/
