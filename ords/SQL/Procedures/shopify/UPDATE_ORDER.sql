--------------------------------------------------------
--  DDL for Procedure UPDATE_ORDER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_ORDER" (p_id IN NUMBER, p_body_text IN CLOB, p_deletedFlag IN VARCHAR2)
AS 
BEGIN
UPDATE sp_orders ord
SET (email, closed_at, created_at, updated_at, "NUMBER", note, token, gateway, test, total_price, subtotal_price, total_weight, total_tax, taxes_included, currency, 
    financial_status, confirmed, total_discounts, total_line_items_price, cart_token, buyer_accepts_marketing, "NAME", referring_site, landing_site, cancelled_at, 
    cancel_reason, total_price_usd, checkout_token, "REFERENCE", user_id, location_id, source_identifier, source_url, processed_at, device_id, phone, customer_locale, 
    app_id, browser_ip, landing_site_ref, order_number, processing_method, checkout_id, source_name, fulfillment_status, tags, contact_email, order_status_url, 
    presentment_currency, total_tip_received, original_total_duties_set, current_total_duties_set, admin_graphql_api_id, payment_gateway_names, deleted) 
= (SELECT jt.*, p_deletedFlag
  FROM
    json_table(p_body_text, '$'
        columns(
            "email" VARCHAR2(50)    PATH    '$.email',
            "closed_at" TIMESTAMP WITH TIME ZONE         PATH    '$.closed_at',
            "created_at"    TIMESTAMP WITH TIME ZONE             PATH    '$.created_at',
            "updated_at"    VARCHAR2(50)                PATH    '$.updated_at',
            "number"    NUMBER(18)      PATH    '$.number',
            "note"  VARCHAR2(50)    PATH    '$.note',
            "token" VARCHAR2(50)    PATH    '$.token',
            "gateway"   VARCHAR2(50)        PATH    '$.gateway' ,
            "test"  VARCHAR2(50)    PATH    '$.test',
            "total_price"   NUMBER(18,3)                PATH    '$.total_price' ,
            "subtotal_price"    NUMBER(18,3)                    PATH    '$.subtotal_price',
            "total_weight"  NUMBER(18)                  PATH    '$.total_weight',
            "total_tax" NUMBER(18,3)            PATH    '$.total_tax',
            "taxes_included"    VARCHAR2(50)                    PATH    '$.taxes_included',
            "currency"  VARCHAR2(50)            PATH    '$.currency',
            "financial_status"  VARCHAR2(50)                    PATH    '$.financial_status',
            "confirmed" VARCHAR2(50)            PATH    '$.confirmed',
            "total_discounts"   NUMBER(18,3)                    PATH    '$.total_discounts' ,
            "total_line_items_price"    NUMBER(18,3)                    PATH    '$.total_line_items_price',
            "cart_token"    VARCHAR2(50)                PATH    '$.cart_token',
            "buyer_accepts_marketing" VARCHAR2(50) PATH '$.buyer_accepts_marketing',
            "name"  VARCHAR2(50)    PATH    '$.name',
            "referring_site"    VARCHAR2(50)                    PATH    '$.referring_site',
            "landing_site"  VARCHAR2(50)                PATH    '$.landing_site',
            "cancelled_at"  TIMESTAMP WITH TIME ZONE             PATH    '$.cancelled_at',
            "cancel_reason" VARCHAR2(50)                    PATH    '$.cancel_reason',
            "total_price_usd"   NUMBER(18,3)                    PATH    '$.total_price_usd' ,
            "checkout_token"    VARCHAR2(50)                    PATH    '$.checkout_token',
            "reference" VARCHAR2(50)            PATH    '$.reference' ,
            "user_id"   VARCHAR2(50)        PATH    '$.user_id' ,
            "location_id"   VARCHAR2(50)                PATH    '$.location_id' ,
            "source_identifier" VARCHAR2(50)                    PATH    '$.source_identifier',
            "source_url"    VARCHAR2(50)                PATH    '$.source_url',
            "processed_at"  TIMESTAMP WITH TIME ZONE                 PATH    '$.processed_at',
            "device_id" VARCHAR2(50)            PATH    '$.device_id',
            "phone" VARCHAR2(50)    PATH    '$.phone',
            "customer_locale"   VARCHAR2(50)                    PATH    '$.customer_locale' ,
            "app_id"    NUMBER(18)      PATH    '$.app_id',
            "browser_ip"    VARCHAR2(50)                PATH    '$.browser_ip',
            "landing_site_ref"  VARCHAR2(50)                    PATH    '$.landing_site_ref',
            "order_number"  NUMBER(18)                  PATH    '$.order_number',
            "processing_method" VARCHAR2(50)                    PATH    '$.processing_method' ,
            "checkout_id"   NUMBER(18)              PATH    '$.checkout_id' ,
            "source_name"   VARCHAR2(50)                PATH    '$.source_name',
            "fulfillment_status"    VARCHAR2(50)                    PATH    '$.fulfillment_status',
            "tags"  VARCHAR2(50)    PATH    '$.tags',
            "contact_email" VARCHAR2(50)                    PATH    '$.contact_email',
            "order_status_url"  VARCHAR2(200)                   PATH    '$.order_status_url',
            "presentment_currency"  VARCHAR2(50)                    PATH    '$.presentment_currency',
            "total_tip_received"    NUMBER(30,1)                    PATH    '$.total_tip_received',
            "original_total_duties_set" VARCHAR2(50)                    PATH    '$.original_total_duties_set',
            "current_total_duties_set"  VARCHAR2(50)                    PATH    '$.current_total_duties_set',
            "admin_graphql_api_id"  VARCHAR2(50)                    PATH    '$.admin_graphql_api_id',
            "payments_gateway_names"    VARCHAR2(128)                   PATH    '$.payment_gateway_names'
        )
    )  jt WHERE ord.id = p_id
);
COMMIT;
END UPDATE_ORDER;

/
