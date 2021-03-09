--------------------------------------------------------
--  DDL for Procedure INSERT_TOTAL_DISCOUNT_SET
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "INSERT_TOTAL_DISCOUNT_SET" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
INSERT INTO sp_total_discounts_set
(order_id, shop_money_amount, shop_money_currency_code, presentment_money_amount, presentment_money_currency_code) 
SELECT p_id, jt.*
  FROM
    json_table(p_body_text, '$'
        columns(
            nested PATH '$.total_discounts_set[*]'
                columns(
                    shop_money_amount NUMBER PATH '$.shop_money.amount',
                    shop_money_currency_code VARCHAR2(10) PATH '$.shop_money.currency_code',
                    presentment_money_amount NUMBER PATH '$.presentment_money.amount',
                    presentment_money_currency_code VARCHAR2(10) PATH '$.presentment_money.currency_code'
                )
        )
    ) as jt;
END INSERT_TOTAL_DISCOUNT_SET;

/
