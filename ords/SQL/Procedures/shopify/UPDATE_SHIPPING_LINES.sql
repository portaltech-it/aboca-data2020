--------------------------------------------------------
--  DDL for Procedure UPDATE_SHIPPING_LINES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_SHIPPING_LINES" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
UPDATE sp_shipping_lines sl
SET (id, title, price, code, source, phone, requested_fulfillment_service_id, delivery_category, carrier_identifier, discounted_price, price_set_shop_money_amount, price_set_shop_money_currency_code, price_set_presentment_money_amount, price_set_presentment_money_currency_code, 
discounted_price_set_shop_money_amount, discounted_price_set_shop_money_currency_code, discounted_price_set_presentment_money_amount, discounted_price_set_presentment_money_currency_code) 
= (SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            nested PATH '$.shipping_lines[*]'
                columns(
                    ID                                                          NUMBER(18)    PATH '$.id',
                    TITLE                                                       VARCHAR2(50)  PATH '$.title', 
                    PRICE                                                       NUMBER(18,3)  PATH '$.price', 
                    CODE                                                        VARCHAR2(50)  PATH '$.code',
                    SOURCE                                                      VARCHAR2(50)  PATH '$.source',
                    PHONE                                                       VARCHAR2(50)  PATH '$.phone',
                    REQUESTED_FULFILLMENT_SERVICE_ID                            VARCHAR2(50)  PATH '$.request_fulfillment_service_id',
                    DELIVERY_CATEGORY                                           VARCHAR2(50)  PATH '$.delivery_category',
                    CARRIER_IDENTIFIER                                          VARCHAR2(50)  PATH '$.carrier_identifier',
                    DISCOUNTED_PRICE                                            NUMBER(18,3)  PATH '$.discounted_price',
                    PRICE_SET_SHOP_MONEY_AMOUNT                                 NUMBER(18,3)  PATH '$.price_set.shop_money.amount',
                    PRICE_SET_SHOP_MONEY_CURRENCY_CODE                          VARCHAR2(10)  PATH '$.price_set.shop_money.currency_code',
                    PRICE_SET_PRESENTMENT_MONEY_AMOUNT                          NUMBER(18,3)  PATH '$.price_set.presentment_money.amount',
                    PRICE_SET_PRESENTMENT_MONEY_CURRENCY_CODE                   VARCHAR2(10)  PATH '$.price_set.presentment_money.currency_code',
                    DISCOUNTED_PRICE_SET_SHOP_MONEY_AMOUNT                      NUMBER(18,3)  PATH '$.discounted_price_set.shop_money.amount',
                    DISCOUNTED_PRICE_SET_SHOP_MONEY_CURRENCY_CODE               VARCHAR2(10)  PATH '$.discounted_price_set.shop_money.currency_code',
                    DISCOUNTED_PRICE_SET_PRESENTMENT_MONEY_AMOUNT               NUMBER(18,3)  PATH '$.discounted_price_set.presentment_money.amount',
                    DISCOUNTED_PRICE_SET_PRESENTMENT_MONEY_CURRENCY_CODE        VARCHAR2(10)  PATH '$.discounted_price_set.presentment_money.currency_code'
                )
            )
        )  jt WHERE sl.order_id = p_ID AND sl.id = jt.id
    );
END UPDATE_SHIPPING_LINES;

/
