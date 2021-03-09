--------------------------------------------------------
--  DDL for Procedure UPDATE_LINE_ITEMS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_LINE_ITEMS" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
UPDATE sp_line_items it
SET (id, variant_id, title, quantity, sku, variant_title, vendor, fulfillment_service, product_id, requires_shipping, taxable, gift_card, "NAME", variant_inventory_management, properties, product_exists, fulfillable_quantity, grams, price, total_discount, fulfillment_status, price_set_shop_money_amount, price_set_shop_money_currency_code, price_set_presentment_money_amount, price_set_presentment_money_currency_code, total_discount_set_shop_money_amount, total_discount_set_shop_money_currency_code, total_discount_set_presentment_money_amount, total_discount_set_presentment_money_currency_code, admin_graphql_api_id) 
= (SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            nested PATH '$.line_items[*]'
                columns(
                    ID                                                      NUMBER(18)      PATH '$.id',
                    VARIANT_ID                                              NUMBER(18)      PATH '$.variant_id',
                    TITLE                                                   VARCHAR2(50)    PATH '$.title',
                    QUANTITY                                                NUMBER(18)      PATH '$.quantity',
                    SKU                                                     VARCHAR2(50)    PATH '$.sku',
                    VARIANT_TITLE                                           VARCHAR2(50)    PATH '$.variant_title',
                    VENDOR                                                  VARCHAR2(50)    PATH '$.vendor',
                    FULFILLMENT_SERVICE                                     VARCHAR2(50)    PATH '$.fulfillment_service',
                    PRODUCT_ID                                              NUMBER(18)      PATH '$.product_id',
                    REQUIRES_SHIPPING                                       VARCHAR2(50)    PATH '$.requires_shipping',
                    TAXABLE                                                 VARCHAR2(50)    PATH '$.taxable',
                    GIFT_CARD                                               VARCHAR2(50)    PATH '$.gift_card',
                    "NAME"                                                  VARCHAR2(50)    PATH '$.name',
                    VARIANT_INVENTORY_MANAGEMENT                            VARCHAR2(50)    PATH '$.variant_inventory_management',
                    PROPERTIES                                              VARCHAR2(50)    PATH '$.properties',
                    PRODUCT_EXISTS                                          VARCHAR2(50)    PATH '$.product_exists',
                    FULFILLABLE_QUANTITY                                    NUMBER(18)      PATH '$.fulfillable_quantity',
                    GRAMS                                                   NUMBER(18)      PATH '$.grams',
                    PRICE                                                   NUMBER(18,3)    PATH '$.price',
                    TOTAL_DISCOUNT                                          NUMBER(18,3)    PATH '$.total_discount',
                    FULFILLMENT_STATUS                                      VARCHAR2(50)    PATH '$.fulfillment_status',
                    PRICE_SET_SHOP_MONEY_AMOUNT                             NUMBER(18,3)    PATH '$.price_set.shop_money.amount',
                    PRICE_SET_SHOP_MONEY_CURRENCY_CODE                      VARCHAR2(10)    PATH '$.price_set.shop_money.currency_code',
                    PRICE_SET_PRESENTMENT_MONEY_AMOUNT                      NUMBER(18,3)    PATH '$.price_set.presentment_money.amount',
                    PRICE_SET_PRESENTMENT_MONEY_CURRENCY_CODE               VARCHAR2(10)    PATH '$.price_set.presentment_money.currency_code',
                    TOTAL_DISCOUNT_SET_SHOP_MONEY_AMOUNT                    NUMBER(18,3)    PATH '$.total_discount_set.shop_money.amount',
                    TOTAL_DISCOUNT_SET_SHOP_MONEY_CURRENCY_CODE             VARCHAR2(10)    PATH '$.total_discount_set.shop_money.currency_code',
                    TOTAL_DISCOUNT_SET_PRESENTMENT_MONEY_AMOUNT             NUMBER(18,3)    PATH '$.total_discount_set.presentment_money.amount',
                    TOTAL_DISCOUNT_SET_PRESENTMENT_MONEY_CURRENCY_CODE      VARCHAR2(10)    PATH '$.total_discount_set.presentment_money.currency_code',
                    ADMIN_GRAPHQL_API_ID                                    VARCHAR2(50)    PATH '$.admin_graphql_api_id'
                )
            )
        ) jt WHERE it.order_id = p_ID AND it.id = jt.ID
);
END UPDATE_LINE_ITEMS;

/
