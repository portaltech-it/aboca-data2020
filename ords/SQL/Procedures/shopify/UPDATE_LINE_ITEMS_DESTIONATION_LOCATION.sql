--------------------------------------------------------
--  DDL for Procedure UPDATE_LINE_ITEMS_DESTIONATION_LOCATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "UPDATE_LINE_ITEMS_DESTIONATION_LOCATION" 
(
  P_ID IN NUMBER,
  P_BODY_TEXT IN CLOB 
) AS 
BEGIN
UPDATE sp_line_items_destination_location it
SET (line_item_id, country_code, province_code, "NAME", address1, address2, city, zip) 
= (SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            nested PATH '$.line_items[*]'
                columns(
                    LINE_ITEM_ID              NUMBER(18)      PATH '$.id',
                    COUNTRY_CODE              VARCHAR2(50)    PATH '$.destination_location[*].country_code',
                    PROVINCE_CODE             VARCHAR2(50)    PATH '$.destination_location[*].province_code',
                    "NAME"                    VARCHAR2(50)    PATH '$.destination_location[*].name',
                    ADDRESS1                  VARCHAR2(100)   PATH '$.destination_location[*].address1',
                    ADDRESS2                  VARCHAR2(100)   PATH '$.destination_location[*].address2',
                    CITY                      VARCHAR2(50)    PATH '$.destination_location[*].city',
                    ZIP                       VARCHAR2(10)    PATH '$.destination_location[*].zip'
                )
            )
        )  jt WHERE it.line_item_id = jt.LINE_ITEM_ID
    ) WHERE it.order_id = p_id;
END UPDATE_LINE_ITEMS_DESTIONATION_LOCATION;

/
