--------------------------------------------------------
--  DDL for Procedure INSERT_COSTUMER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MW_ECOMMERCE"."INSERT_COSTUMER" (p_body_text IN CLOB) AS 
BEGIN
INSERT INTO sp_customer
(order_id, id, email, accepts_marketing, created_at, updated_at, first_name, last_name, orders_count, state, total_spent, last_order_id, note, verified_email, multipass_identifier, tax_exempt, phone, tags, last_order_name, currency, accepts_marketing_updated_at, marketing_opt_in_level, admin_graphql_api_id) 
SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            "order_id" NUMBER PATH '$.id',
            nested PATH '$.customer[*]'
                columns(
                    ID                              NUMBER(18) PATH       '$.id',
                    EMAIL                           VARCHAR2(50) PATH     '$.email',
                    ACCEPTS_MARKETING               VARCHAR2(50) PATH     '$.accepts_marketing',
                    CREATED_AT                      TIMESTAMP(6) WITH TIME ZONE PATH     '$.created_at',
                    UPDATED_AT                      TIMESTAMP(6) WITH TIME ZONE PATH     '$.updated_at',
                    FIRST_NAME                      VARCHAR2(50) PATH     '$.first_name',
                    LAST_NAME                       VARCHAR2(50) PATH     '$.last_name',
                    ORDERS_COUNT                    NUMBER(18) PATH       '$.orders_count',
                    STATE                           VARCHAR2(50) PATH     '$.state',
                    TOTAL_SPENT                     NUMBER(18,3) PATH     '$.total_spent',
                    LAST_ORDER_ID                   NUMBER(18) PATH       '$.last_order_id',
                    NOTE                            VARCHAR2(50) PATH     '$.note',
                    VERIFIED_EMAIL                  VARCHAR2(50) PATH     '$.verified_email',
                    MULTIPASS_IDENTIFIER            VARCHAR2(50) PATH     '$.multipass_identifier',
                    TAX_EXEMPT                      VARCHAR2(50) PATH     '$.tax_exempt',
                    PHONE                           VARCHAR2(50) PATH     '$.phone',
                    TAGS                            VARCHAR2(50) PATH     '$.tags',
                    LAST_ORDER_NAME                 VARCHAR2(50) PATH     '$.last_order_name',
                    CURRENCY                        VARCHAR2(50) PATH     '$.currency',
                    ACCEPTS_MARKETING_UPDATED_AT    TIMESTAMP(6) WITH TIME ZONE PATH     '$.accepts_marketing_updated_at',
                    MARKETING_OPT_IN_LEVEL          VARCHAR2(50) PATH     '$.marketing_opt_in_level',
                    ADMIN_GRAPHQL_API_ID            VARCHAR2(100) PATH    '$.admin_graphql_api_id'
                )
        )
    );
END INSERT_COSTUMER;

/
