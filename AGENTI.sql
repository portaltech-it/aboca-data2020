--------------------------------------------------------
--  File created - Tuesday-November-17-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table AGENTI
--------------------------------------------------------

  CREATE TABLE "PROVA"."AGENTI" 
   (	"Società" VARCHAR2(2 BYTE), 
	"CodiceAgente" VARCHAR2(6 BYTE), 
	"NominativoAgente" VARCHAR2(30 BYTE), 
	"CodiceCanaleAgente" VARCHAR2(1 BYTE), 
	"CodiceAreaAgente" VARCHAR2(3 BYTE), 
	"CodiceZonaAgente" VARCHAR2(3 BYTE), 
	"CodiceClienteAgente" VARCHAR2(6 BYTE), 
	"RagioneSocialeAgente" VARCHAR2(61 BYTE), 
	"IndirizzoAgente" VARCHAR2(30 BYTE), 
	"CapAgente" VARCHAR2(6 BYTE), 
	"CittàAgente" VARCHAR2(30 BYTE), 
	"ProvinciaAgente" VARCHAR2(2 BYTE), 
	"TelefonoAgente" VARCHAR2(24 BYTE), 
	"FaxAgente" VARCHAR2(18 BYTE), 
	"CellulareAgente" VARCHAR2(15 BYTE), 
	"Telefono2Agente" VARCHAR2(15 BYTE), 
	"MailAgente" VARCHAR2(100 BYTE), 
	"InizioAgente" VARCHAR2(40 BYTE), 
	"FineAgente" VARCHAR2(40 BYTE), 
	"CodiceAreaManager" VARCHAR2(4 BYTE), 
	"AttivoAgente" VARCHAR2(40 BYTE), 
	"TipologiaAgente" VARCHAR2(9 BYTE), 
	"FlgEnasarco" VARCHAR2(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
REM INSERTING into PROVA.AGENTI
SET DEFINE OFF;
Insert into PROVA.AGENTI ("Società","CodiceAgente","NominativoAgente","CodiceCanaleAgente","CodiceAreaAgente","CodiceZonaAgente","CodiceClienteAgente","RagioneSocialeAgente","IndirizzoAgente","CapAgente","CittàAgente","ProvinciaAgente","TelefonoAgente","FaxAgente","CellulareAgente","Telefono2Agente","MailAgente","InizioAgente","FineAgente","CodiceAreaManager","AttivoAgente","TipologiaAgente","FlgEnasarco") values ('S1','0001','Mario Rossi','1','a01','z01','ca1','blabla','via vai',null,null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.AGENTI ("Società","CodiceAgente","NominativoAgente","CodiceCanaleAgente","CodiceAreaAgente","CodiceZonaAgente","CodiceClienteAgente","RagioneSocialeAgente","IndirizzoAgente","CapAgente","CittàAgente","ProvinciaAgente","TelefonoAgente","FaxAgente","CellulareAgente","Telefono2Agente","MailAgente","InizioAgente","FineAgente","CodiceAreaManager","AttivoAgente","TipologiaAgente","FlgEnasarco") values ('S1','0002','Giuseppe Verdi','2','a01','z01','ca1','blabla','via vai',null,null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.AGENTI ("Società","CodiceAgente","NominativoAgente","CodiceCanaleAgente","CodiceAreaAgente","CodiceZonaAgente","CodiceClienteAgente","RagioneSocialeAgente","IndirizzoAgente","CapAgente","CittàAgente","ProvinciaAgente","TelefonoAgente","FaxAgente","CellulareAgente","Telefono2Agente","MailAgente","InizioAgente","FineAgente","CodiceAreaManager","AttivoAgente","TipologiaAgente","FlgEnasarco") values ('S2','0002','Maria Bianchi','2','a01','z01','ca2','quaqua','via di qua',null,null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.AGENTI ("Società","CodiceAgente","NominativoAgente","CodiceCanaleAgente","CodiceAreaAgente","CodiceZonaAgente","CodiceClienteAgente","RagioneSocialeAgente","IndirizzoAgente","CapAgente","CittàAgente","ProvinciaAgente","TelefonoAgente","FaxAgente","CellulareAgente","Telefono2Agente","MailAgente","InizioAgente","FineAgente","CodiceAreaManager","AttivoAgente","TipologiaAgente","FlgEnasarco") values ('S3','0004','Pinco Pallino','2','a01','z01','ca1','blabla','via vai',null,null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.AGENTI ("Società","CodiceAgente","NominativoAgente","CodiceCanaleAgente","CodiceAreaAgente","CodiceZonaAgente","CodiceClienteAgente","RagioneSocialeAgente","IndirizzoAgente","CapAgente","CittàAgente","ProvinciaAgente","TelefonoAgente","FaxAgente","CellulareAgente","Telefono2Agente","MailAgente","InizioAgente","FineAgente","CodiceAreaManager","AttivoAgente","TipologiaAgente","FlgEnasarco") values ('S3','0001','Signor Nessuno','3','a04','z02','ca2','quaqua','via di qua',null,null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.AGENTI ("Società","CodiceAgente","NominativoAgente","CodiceCanaleAgente","CodiceAreaAgente","CodiceZonaAgente","CodiceClienteAgente","RagioneSocialeAgente","IndirizzoAgente","CapAgente","CittàAgente","ProvinciaAgente","TelefonoAgente","FaxAgente","CellulareAgente","Telefono2Agente","MailAgente","InizioAgente","FineAgente","CodiceAreaManager","AttivoAgente","TipologiaAgente","FlgEnasarco") values ('S2','0001','Signora Chi','1','a02','z01','ca3','bohboh','via di qua',null,null,null,null,null,null,null,null,null,null,null,null,null,null);
--------------------------------------------------------
--  DDL for Index SYS_C007677
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROVA"."SYS_C007677" ON "PROVA"."AGENTI" ("Società", "CodiceAgente") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table AGENTI
--------------------------------------------------------

  ALTER TABLE "PROVA"."AGENTI" ADD PRIMARY KEY ("Società", "CodiceAgente")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
