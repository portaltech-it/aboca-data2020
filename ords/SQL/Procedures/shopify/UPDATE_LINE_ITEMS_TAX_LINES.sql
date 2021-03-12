--------------------------------------------------------
--  DDL for Procedure UPDATE_LINE_ITEMS_TAX_LINES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_LINE_ITEMS_TAX_LINES" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
UPDATE sp_line_items_tax_lines it
SET (line_item_id, title, rate, price, price_set_shop_money_amount, price_set_shop_money_currency_code, price_set_presentment_money_amount, price_set_presentment_money_currency_code) 
= (SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            nested PATH '$.line_items[*]'
                columns(
                    LINE_ITEM_ID                                            NUMBER(18)    PATH '$.id',
                    TITLE                                                       VARCHAR2(50)  PATH '$.tax_lines.title', 
                    RATE                                                        NUMBER(18,3)  PATH '$.tax_lines.rate',
                    PRICE                                                       NUMBER(18,3)  PATH '$.tax_lines.price', 
                    PRICE_SET_SHOP_MONEY_AMOUNT                                 NUMBER(18,3)  PATH '$.tax_lines.price_set.shop_money.amount',
                    PRICE_SET_SHOP_MONEY_CURRENCY_CODE                          VARCHAR2(10)  PATH '$.tax_lines.price_set.shop_money.currency_code',
                    PRICE_SET_PRESENTMENT_MONEY_AMOUNT                          NUMBER(18,3)  PATH '$.tax_lines.price_set.presentment_money.amount',
                    PRICE_SET_PRESENTMENT_MONEY_CURRENCY_CODE                   VARCHAR2(10)  PATH '$.tax_lines.price_set.presentment_money.currency_code'                
                )
            )
        )  jt WHERE it.line_item_id = jt.LINE_ITEM_ID
    ) WHERE it.order_id = p_id;
END UPDATE_LINE_ITEMS_TAX_LINES;

/
