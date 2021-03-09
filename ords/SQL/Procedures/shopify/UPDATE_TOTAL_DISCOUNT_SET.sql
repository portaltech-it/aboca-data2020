--------------------------------------------------------
--  DDL for Procedure UPDATE_TOTAL_DISCOUNT_SET
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_TOTAL_DISCOUNT_SET" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
UPDATE sp_total_discounts_set ds
SET (shop_money_amount, shop_money_currency_code, presentment_money_amount, presentment_money_currency_code) 
= (SELECT *
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
        ) jt WHERE ds.order_id = p_id
    );
END UPDATE_TOTAL_DISCOUNT_SET;

/
