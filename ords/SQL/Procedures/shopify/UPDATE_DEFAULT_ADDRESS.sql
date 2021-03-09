--------------------------------------------------------
--  DDL for Procedure UPDATE_DEFAULT_ADDRESS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_DEFAULT_ADDRESS" (p_body_text IN CLOB) AS 
BEGIN
UPDATE sp_default_address da
SET (id, customer_id, first_name, last_name, company, address1, address2, city, province, country, zip, phone, "NAME", province_code, country_code, country_name, "DEFAULT") 
= (SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            nested PATH '$.customer.default_address[*]'
                columns(
                    ID                 NUMBER(18)       PATH '$.id',
                    CUSTOMER_ID       NUMBER(18)        PATH '$.customer_id',
                    FIRST_NAME       VARCHAR2(128)      PATH '$.first_name',
                    LAST_NAME       VARCHAR2(128)       PATH '$.last_name',
                    COMPANY       VARCHAR2(128)         PATH '$.company',
                    ADDRESS1       VARCHAR2(128)        PATH '$.address1',
                    ADDRESS2       VARCHAR2(128)        PATH '$.address2',
                    CITY             VARCHAR2(128)      PATH '$.city',
                    PROVINCE       VARCHAR2(128)        PATH '$.province',
                    COUNTRY       VARCHAR2(128)         PATH '$.country',
                    ZIP               VARCHAR2(50)      PATH '$.zip',
                    PHONE         VARCHAR2(150)         PATH '$.phone',
                    "NAME"           VARCHAR2(128)        PATH '$.name',
                    PROVINCE_CODE       VARCHAR2(10)    PATH '$.province',
                    COUNTRY_CODE       VARCHAR2(10)     PATH '$.country_code',
                    COUNTRY_NAME       VARCHAR2(50)     PATH '$.country_name',
                    "DEFAULT"       VARCHAR2(20)          PATH '$.default'
                )
            )
        ) as jt WHERE da.id = jt.id
    );
END UPDATE_DEFAULT_ADDRESS;

/
