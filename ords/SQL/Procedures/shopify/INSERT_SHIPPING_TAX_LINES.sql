--------------------------------------------------------
--  DDL for Procedure INSERT_SHIPPING_TAX_LINES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MW_ECOMMERCE"."INSERT_SHIPPING_TAX_LINES" 
(
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
INSERT INTO sp_shipping_tax_lines
(order_id, shipping_line_id, title, rate, price, price_set_shop_money_amount, price_set_shop_money_currency_code, price_set_presentment_money_amount, price_set_presentment_money_currency_code) 
SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            "order_id" NUMBER PATH '$.id',
            nested PATH '$.shipping_lines[*]'
                columns(
                    SHIPPING_LINE_ID                                            NUMBER(18)    PATH '$.id',
                    TITLE                                                       VARCHAR2(50)  PATH '$.tax_lines[*].title', 
                    RATE                                                        NUMBER(18,3)  PATH '$.tax_lines[*].rate',
                    PRICE                                                       NUMBER(18,3)  PATH '$.tax_lines[*].price', 
                    PRICE_SET_SHOP_MONEY_AMOUNT                                 NUMBER(18,3)  PATH '$.tax_lines[*].price_set.shop_money.amount',
                    PRICE_SET_SHOP_MONEY_CURRENCY_CODE                          VARCHAR2(10)  PATH '$.tax_lines[*].price_set.shop_money.currency_code',
                    PRICE_SET_PRESENTMENT_MONEY_AMOUNT                          NUMBER(18,3)  PATH '$.tax_lines[*].price_set.presentment_money.amount',
                    PRICE_SET_PRESENTMENT_MONEY_CURRENCY_CODE                   VARCHAR2(10)  PATH '$.tax_lines[*].price_set.presentment_money.currency_code'
                )
        )
    );
END INSERT_SHIPPING_TAX_LINES;

/
