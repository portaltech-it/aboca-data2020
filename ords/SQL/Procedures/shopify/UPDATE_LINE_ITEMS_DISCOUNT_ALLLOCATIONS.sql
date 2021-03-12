--------------------------------------------------------
--  DDL for Procedure UPDATE_LINE_ITEMS_DISCOUNT_ALLLOCATIONS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_LINE_ITEMS_DISCOUNT_ALLLOCATIONS" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
UPDATE sp_line_items_discount_allocations it
SET (line_item_id, amount, discount_application_index, amount_set_shop_money_amount, amount_set_shop_money_currency_code, amount_set_presentment_money_amount, amount_set_presentment_money_currency_code) 
= (SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            nested PATH '$.line_items[*]'
                columns(
                    LINE_ITEM_ID                                      NUMBER(18)      PATH '$.id',
                    AMOUNT                                            VARCHAR2(50)    PATH '$.discount_allocations[*].amount',
                    DISCOUNT_APPLICATION_INDEX                        VARCHAR2(50)    PATH '$.discount_allocations[*].discount_application_index',
                    AMOUNT_SET_SHOP_MONEY_AMOUNT                      VARCHAR2(50)    PATH '$.discount_allocations[*].amount_set.shop_money.amount',
                    AMOUNT_SET_SHOP_CURRENCY_CODE                     VARCHAR2(100)   PATH '$.discount_allocations[*].amount_set.shop_money.currency_code',
                    AMOUNT_SET_PRESENTMENT_MONEY_AMOUNT               VARCHAR2(100)   PATH '$.discount_allocations[*].amount_set.presentment_money.amount',
                    AMOUNT_SET_PRESENTMENT_MONEY_CURRENCY_CODE        VARCHAR2(50)    PATH '$.discount_allocations[*].amount_set.presentment_money.currency_code'
                )
            )
        )  jt WHERE it.line_item_id = jt.LINE_ITEM_ID
    ) WHERE it.order_id = p_id;
END UPDATE_LINE_ITEMS_DISCOUNT_ALLLOCATIONS;

/
