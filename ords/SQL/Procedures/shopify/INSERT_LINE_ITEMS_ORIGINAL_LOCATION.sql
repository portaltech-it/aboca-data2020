--------------------------------------------------------
--  DDL for Procedure INSERT_LINE_ITEMS_ORIGINAL_LOCATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MW_ECOMMERCE"."INSERT_LINE_ITEMS_ORIGINAL_LOCATION" 
(
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
INSERT INTO sp_line_items_original_location
(order_id, line_item_id, country_code, province_code, "NAME", address1, address2, city, zip) 
SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            "order_id" NUMBER PATH '$.id',
            nested PATH '$.line_items[*]'
                columns(
                    LINE_ITEM_ID              NUMBER(18)      PATH '$.id',
                    COUNTRY_CODE              VARCHAR2(50)    PATH '$.origin_location[*].country_code',
                    PROVINCE_CODE             VARCHAR2(50)    PATH '$.origin_location[*].province_code',
                    "NAME"                    VARCHAR2(50)    PATH '$.origin_location[*].name',
                    ADDRESS1                  VARCHAR2(100)   PATH '$.origin_location[*].address1',
                    ADDRESS2                  VARCHAR2(100)   PATH '$.origin_location[*].address2',
                    CITY                      VARCHAR2(50)    PATH '$.origin_location[*].city',
                    ZIP                       VARCHAR2(10)    PATH '$.origin_location[*].zip'
                )
        )
    );
END INSERT_LINE_ITEMS_ORIGINAL_LOCATION;

/
