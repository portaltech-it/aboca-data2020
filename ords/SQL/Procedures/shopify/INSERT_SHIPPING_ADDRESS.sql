--------------------------------------------------------
--  DDL for Procedure INSERT_SHIPPING_ADDRESS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MW_ECOMMERCE"."INSERT_SHIPPING_ADDRESS" 
(
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
INSERT INTO sp_shipping_address
(order_id, first_name, address1, phone, city, zip, province, country, last_name, address2, company, latitude, longitude, "NAME", country_code, province_code) 
SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            "order_id" NUMBER PATH '$.id',
            nested PATH '$.shipping_address[*]'
                columns(
                    first_name       VARCHAR2(50) PATH '$.first_name',
                    address1       VARCHAR2(100) PATH '$.address1',
                    phone         VARCHAR2(50) PATH '$.phone',
                    city             VARCHAR2(50) PATH '$.city',
                    zip               VARCHAR2(10) PATH '$.zip',
                    province       VARCHAR2(50) PATH '$.province',
                    country       VARCHAR2(50) PATH '$.country',
                    last_name       VARCHAR2(50) PATH '$.last_name',
                    address2       VARCHAR2(100) PATH '$.address2',
                    company       VARCHAR2(50) PATH '$.company',
                    latitude       NUMBER PATH '$.latitude',
                    longitude       NUMBER PATH '$.longitude',
                    "NAME"           VARCHAR2(100) PATH '$.name', 
                    country_code       VARCHAR2(50) PATH '$.country_code',
                    province_code       VARCHAR2(50) PATH '$.province_code'
                )
        )
    );
END INSERT_SHIPPING_ADDRESS;

/
