--------------------------------------------------------
--  DDL for Procedure INSERT_CLIENT_DETAILS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MW_ECOMMERCE"."INSERT_CLIENT_DETAILS" (p_body_text IN CLOB) AS 
BEGIN
INSERT INTO sp_client_details
(order_id, accept_language, browser_height, browser_ip, browser_width, session_hash, user_agent) 
SELECT *
  FROM
    json_table(p_body_text, '$'
        columns(
            "order_id" NUMBER PATH '$.id',
            nested PATH '$.client_details[*]'
                columns(
	        	    accept_language VARCHAR2(100)  PATH '$.accept_language',
    		        browser_height NUMBER PATH '$.browser_height',
	        	    browser_ip VARCHAR2(100) PATH '$.browser_ip',
    		        browser_width NUMBER PATH '$.browser_width',
                    session_hash VARCHAR2(100) PATH '$.session_hash',
    		        user_agent VARCHAR2(500) PATH '$.user_agent'
                )
        )
    );
END INSERT_CLIENT_DETAILS;

/
