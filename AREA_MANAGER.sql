--------------------------------------------------------
--  File created - Tuesday-November-17-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table AREA_MANAGER
--------------------------------------------------------

  CREATE TABLE "PROVA"."AREA_MANAGER" 
   (	"Società" VARCHAR2(2 BYTE), 
	"CodiceAreaManager" VARCHAR2(6 BYTE), 
	"NominativoAreaManager" VARCHAR2(30 BYTE), 
	"CodiceCanaleAreamanager" VARCHAR2(1 BYTE), 
	"CodiceAreaAreaManager" VARCHAR2(3 BYTE), 
	"CodiceZonaAreaManager" VARCHAR2(3 BYTE), 
	"CodiceClienteAreaManager" VARCHAR2(6 BYTE), 
	"RagioneSocialeAreaManager" VARCHAR2(61 BYTE), 
	"IndirizzoAreaManager" VARCHAR2(30 BYTE), 
	"CapAreaManager" VARCHAR2(6 BYTE), 
	"CittàAreaManager" VARCHAR2(30 BYTE), 
	"ProvinciaAreaManager" VARCHAR2(2 BYTE), 
	"TelefonoAreaManager" VARCHAR2(24 BYTE), 
	"FaxAreaManager" VARCHAR2(18 BYTE), 
	"CellulareAreaManager" VARCHAR2(15 BYTE), 
	"Telefono2AreaManager" VARCHAR2(15 BYTE), 
	"MailAreaManager" VARCHAR2(100 BYTE), 
	"InizioAreaManager" VARCHAR2(40 BYTE), 
	"FineAreaManager" VARCHAR2(40 BYTE), 
	"AttivoAreaManager" VARCHAR2(40 BYTE), 
	"TipologiaAreaManager" VARCHAR2(9 BYTE), 
	"FlgEnasarco" VARCHAR2(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
REM INSERTING into PROVA.AREA_MANAGER
SET DEFINE OFF;
Insert into PROVA.AREA_MANAGER ("Società","CodiceAreaManager","NominativoAreaManager","CodiceCanaleAreamanager","CodiceAreaAreaManager","CodiceZonaAreaManager","CodiceClienteAreaManager","RagioneSocialeAreaManager","IndirizzoAreaManager","CapAreaManager","CittàAreaManager","ProvinciaAreaManager","TelefonoAreaManager","FaxAreaManager","CellulareAreaManager","Telefono2AreaManager","MailAreaManager","InizioAreaManager","FineAreaManager","AttivoAreaManager","TipologiaAreaManager","FlgEnasarco") values ('S1','0001','Topolino','1','a03','z02','ca1','bohboh','piazza bella',null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.AREA_MANAGER ("Società","CodiceAreaManager","NominativoAreaManager","CodiceCanaleAreamanager","CodiceAreaAreaManager","CodiceZonaAreaManager","CodiceClienteAreaManager","RagioneSocialeAreaManager","IndirizzoAreaManager","CapAreaManager","CittàAreaManager","ProvinciaAreaManager","TelefonoAreaManager","FaxAreaManager","CellulareAreaManager","Telefono2AreaManager","MailAreaManager","InizioAreaManager","FineAreaManager","AttivoAreaManager","TipologiaAreaManager","FlgEnasarco") values ('S4','0002','Pluto','1','a03','z01','ca3','blabla','via di fretta',null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.AREA_MANAGER ("Società","CodiceAreaManager","NominativoAreaManager","CodiceCanaleAreamanager","CodiceAreaAreaManager","CodiceZonaAreaManager","CodiceClienteAreaManager","RagioneSocialeAreaManager","IndirizzoAreaManager","CapAreaManager","CittàAreaManager","ProvinciaAreaManager","TelefonoAreaManager","FaxAreaManager","CellulareAreaManager","Telefono2AreaManager","MailAreaManager","InizioAreaManager","FineAreaManager","AttivoAreaManager","TipologiaAreaManager","FlgEnasarco") values ('S3','0003','Paperino','2','a01','z02','ca2','boooooooh','via di qua',null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.AREA_MANAGER ("Società","CodiceAreaManager","NominativoAreaManager","CodiceCanaleAreamanager","CodiceAreaAreaManager","CodiceZonaAreaManager","CodiceClienteAreaManager","RagioneSocialeAreaManager","IndirizzoAreaManager","CapAreaManager","CittàAreaManager","ProvinciaAreaManager","TelefonoAreaManager","FaxAreaManager","CellulareAreaManager","Telefono2AreaManager","MailAreaManager","InizioAreaManager","FineAreaManager","AttivoAreaManager","TipologiaAreaManager","FlgEnasarco") values ('S3','0004','Minnie','2','a02','z01','ca1','blabla','via vai',null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.AREA_MANAGER ("Società","CodiceAreaManager","NominativoAreaManager","CodiceCanaleAreamanager","CodiceAreaAreaManager","CodiceZonaAreaManager","CodiceClienteAreaManager","RagioneSocialeAreaManager","IndirizzoAreaManager","CapAreaManager","CittàAreaManager","ProvinciaAreaManager","TelefonoAreaManager","FaxAreaManager","CellulareAreaManager","Telefono2AreaManager","MailAreaManager","InizioAreaManager","FineAreaManager","AttivoAreaManager","TipologiaAreaManager","FlgEnasarco") values ('S3','0002','Pippo','5','a04','z01','ca3','quaqua','via di qua',null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.AREA_MANAGER ("Società","CodiceAreaManager","NominativoAreaManager","CodiceCanaleAreamanager","CodiceAreaAreaManager","CodiceZonaAreaManager","CodiceClienteAreaManager","RagioneSocialeAreaManager","IndirizzoAreaManager","CapAreaManager","CittàAreaManager","ProvinciaAreaManager","TelefonoAreaManager","FaxAreaManager","CellulareAreaManager","Telefono2AreaManager","MailAreaManager","InizioAreaManager","FineAreaManager","AttivoAreaManager","TipologiaAreaManager","FlgEnasarco") values ('S2','0005','Paperone','2','a01','z02','ca2','lalalala','via di fretta',null,null,null,null,null,null,null,null,null,null,null,null,null);
--------------------------------------------------------
--  DDL for Index SYS_C007675
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROVA"."SYS_C007675" ON "PROVA"."AREA_MANAGER" ("CodiceAreaManager", "Società") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table AREA_MANAGER
--------------------------------------------------------

  ALTER TABLE "PROVA"."AREA_MANAGER" ADD PRIMARY KEY ("CodiceAreaManager", "Società")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "PROVA"."AREA_MANAGER" MODIFY ("CodiceAreaManager" NOT NULL ENABLE);
  ALTER TABLE "PROVA"."AREA_MANAGER" MODIFY ("Società" NOT NULL ENABLE);
