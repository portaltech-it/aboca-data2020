--------------------------------------------------------
--  DDL for Procedure INSERT_REFUNDS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "INSERT_REFUNDS" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB
) AS 
BEGIN
  INSERT INTO sp_refunds (order_id) VALUES (p_id);
END INSERT_REFUNDS;

/
