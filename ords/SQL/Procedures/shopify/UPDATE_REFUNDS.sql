--------------------------------------------------------
--  DDL for Procedure UPDATE_REFUNDS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_REFUNDS" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
  UPDATE sp_refunds SET order_id = p_id WHERE order_id = p_id;
END UPDATE_REFUNDS;

/
