--------------------------------------------------------
--  DDL for Procedure UPDATE_FULFILLMENTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_FULFILLMENTS" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
UPDATE sp_fulfillments SET order_id = p_id WHERE order_id = p_id;
END UPDATE_FULFILLMENTS;

/
