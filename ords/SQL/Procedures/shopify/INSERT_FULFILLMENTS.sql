--------------------------------------------------------
--  DDL for Procedure INSERT_FULFILLMENTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "INSERT_FULFILLMENTS" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB
) AS 
BEGIN
INSERT INTO sp_fulfillments (order_id) VALUES (p_id);
END INSERT_FULFILLMENTS;

/
