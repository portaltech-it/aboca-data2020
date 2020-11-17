--------------------------------------------------------
--  File created - Monday-November-16-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CLIENTI
--------------------------------------------------------

  CREATE TABLE "PROVA"."CLIENTI" 
   (	"Società" VARCHAR2(2 BYTE), 
	"TipoCodiceCliente" VARCHAR2(4 BYTE), 
	"TipoCodicePdc" VARCHAR2(9 BYTE), 
	"CodiceCliente" VARCHAR2(6 BYTE), 
	"CodicePdc" VARCHAR2(6 BYTE), 
	"PartitaIvaCliente" VARCHAR2(12 BYTE), 
	"CodiceFiscaleCliente" VARCHAR2(16 BYTE), 
	"RagioneBreveCliente" VARCHAR2(30 BYTE), 
	"RagioneCliente" VARCHAR2(61 BYTE), 
	"IndirizzoCliente" VARCHAR2(30 BYTE), 
	"CAPCliente" VARCHAR2(6 BYTE), 
	"CittàCliente" VARCHAR2(30 BYTE), 
	"ProvinciaCliente" VARCHAR2(2 BYTE), 
	"AreaCliente" VARCHAR2(3 BYTE), 
	"ZonaCliente" VARCHAR2(3 BYTE), 
	"CodiceNazioneCliente" VARCHAR2(4 BYTE), 
	"TelefonoCliente" VARCHAR2(24 BYTE), 
	"FaxCliente" VARCHAR2(18 BYTE), 
	"CellulareCliente" VARCHAR2(15 BYTE), 
	"Telefono2Cliente" VARCHAR2(15 BYTE), 
	"MailCliente" VARCHAR2(80 BYTE), 
	"CodiceLinguaCliente" VARCHAR2(1 BYTE), 
	"CodicePagamentoCliente" VARCHAR2(6 BYTE), 
	"CodiceTrasportoCliente" VARCHAR2(6 BYTE), 
	"CodiceVettoreCliente" VARCHAR2(6 BYTE), 
	"CodiceCategoriaCliente" VARCHAR2(3 BYTE), 
	"DescrizioneCategoriaCliente" VARCHAR2(30 BYTE), 
	"CodiceCategoriaPdc" VARCHAR2(3 BYTE), 
	"DescrizioneCategoriaPdc" VARCHAR2(30 BYTE), 
	"CodiceGruppoCliente" VARCHAR2(6 BYTE), 
	"DescrizioneGruppoCliente" VARCHAR2(30 BYTE), 
	"ABICliente" VARCHAR2(5 BYTE), 
	"CABCliente" VARCHAR2(5 BYTE), 
	"CCCCliente" VARCHAR2(20 BYTE), 
	"ABBCliente" VARCHAR2(5 BYTE), 
	"CBBCliente" VARCHAR2(5 BYTE), 
	"CCBCliente" VARCHAR2(15 BYTE), 
	"CodiceAgenteCliente" VARCHAR2(6 BYTE), 
	"TipoAgenteCliente" VARCHAR2(1 BYTE), 
	"ProgressivoAgenteCliente" NUMBER(11,2), 
	"CodiceAgente2Cliente" VARCHAR2(6 BYTE), 
	"TipoAgente2Cliente" VARCHAR2(1 BYTE), 
	"Progressivo2AgenteCliente" NUMBER(11,2), 
	"CodiceAgente3Cliente" VARCHAR2(6 BYTE), 
	"TipoAgente3Cliente" VARCHAR2(1 BYTE), 
	"Progressivo3AgenteCliente" NUMBER(11,2), 
	"CodiceAgente4Cliente" VARCHAR2(6 BYTE), 
	"TipoAgente4Cliente" VARCHAR2(1 BYTE), 
	"Progressivo4AgenteCliente" NUMBER(11,2), 
	"CodiceAgentePdc" VARCHAR2(6 BYTE), 
	"VecchioCodiceCliente" VARCHAR2(6 BYTE), 
	"NuovoCodiceCliente" VARCHAR2(6 BYTE), 
	"UnCodCli" VARCHAR2(6 BYTE), 
	"AttivazioneCliente" VARCHAR2(9 BYTE), 
	"DisdettaCliente" VARCHAR2(9 BYTE), 
	"AreaManagerTecnico" VARCHAR2(6 BYTE), 
	"AttivoCliente" NUMBER, 
	"AttivoPdc" NUMBER, 
	"CessioneCredito" NUMBER, 
	"Mail2Cliente" VARCHAR2(80 BYTE), 
	"Microarea" VARCHAR2(4 BYTE), 
	"MicroBrick" VARCHAR2(2 BYTE), 
	"CodCliEsterno" VARCHAR2(80 BYTE), 
	"Latitudine" VARCHAR2(15 BYTE), 
	"Longitudine" VARCHAR2(15 BYTE), 
	"CodKAM" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
REM INSERTING into PROVA.CLIENTI
SET DEFINE OFF;
Insert into PROVA.CLIENTI ("Società","TipoCodiceCliente","TipoCodicePdc","CodiceCliente","CodicePdc","PartitaIvaCliente","CodiceFiscaleCliente","RagioneBreveCliente","RagioneCliente","IndirizzoCliente","CAPCliente","CittàCliente","ProvinciaCliente","AreaCliente","ZonaCliente","CodiceNazioneCliente","TelefonoCliente","FaxCliente","CellulareCliente","Telefono2Cliente","MailCliente","CodiceLinguaCliente","CodicePagamentoCliente","CodiceTrasportoCliente","CodiceVettoreCliente","CodiceCategoriaCliente","DescrizioneCategoriaCliente","CodiceCategoriaPdc","DescrizioneCategoriaPdc","CodiceGruppoCliente","DescrizioneGruppoCliente","ABICliente","CABCliente","CCCCliente","ABBCliente","CBBCliente","CCBCliente","CodiceAgenteCliente","TipoAgenteCliente","ProgressivoAgenteCliente","CodiceAgente2Cliente","TipoAgente2Cliente","Progressivo2AgenteCliente","CodiceAgente3Cliente","TipoAgente3Cliente","Progressivo3AgenteCliente","CodiceAgente4Cliente","TipoAgente4Cliente","Progressivo4AgenteCliente","CodiceAgentePdc","VecchioCodiceCliente","NuovoCodiceCliente","UnCodCli","AttivazioneCliente","DisdettaCliente","AreaManagerTecnico","AttivoCliente","AttivoPdc","CessioneCredito","Mail2Cliente","Microarea","MicroBrick","CodCliEsterno","Latitudine","Longitudine","CodKAM") values ('S1','t2','type1','0001','AAA','3g9gkd0',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.CLIENTI ("Società","TipoCodiceCliente","TipoCodicePdc","CodiceCliente","CodicePdc","PartitaIvaCliente","CodiceFiscaleCliente","RagioneBreveCliente","RagioneCliente","IndirizzoCliente","CAPCliente","CittàCliente","ProvinciaCliente","AreaCliente","ZonaCliente","CodiceNazioneCliente","TelefonoCliente","FaxCliente","CellulareCliente","Telefono2Cliente","MailCliente","CodiceLinguaCliente","CodicePagamentoCliente","CodiceTrasportoCliente","CodiceVettoreCliente","CodiceCategoriaCliente","DescrizioneCategoriaCliente","CodiceCategoriaPdc","DescrizioneCategoriaPdc","CodiceGruppoCliente","DescrizioneGruppoCliente","ABICliente","CABCliente","CCCCliente","ABBCliente","CBBCliente","CCBCliente","CodiceAgenteCliente","TipoAgenteCliente","ProgressivoAgenteCliente","CodiceAgente2Cliente","TipoAgente2Cliente","Progressivo2AgenteCliente","CodiceAgente3Cliente","TipoAgente3Cliente","Progressivo3AgenteCliente","CodiceAgente4Cliente","TipoAgente4Cliente","Progressivo4AgenteCliente","CodiceAgentePdc","VecchioCodiceCliente","NuovoCodiceCliente","UnCodCli","AttivazioneCliente","DisdettaCliente","AreaManagerTecnico","AttivoCliente","AttivoPdc","CessioneCredito","Mail2Cliente","Microarea","MicroBrick","CodCliEsterno","Latitudine","Longitudine","CodKAM") values ('S3','t2','type1','0001','AAA','57gd2u8',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.CLIENTI ("Società","TipoCodiceCliente","TipoCodicePdc","CodiceCliente","CodicePdc","PartitaIvaCliente","CodiceFiscaleCliente","RagioneBreveCliente","RagioneCliente","IndirizzoCliente","CAPCliente","CittàCliente","ProvinciaCliente","AreaCliente","ZonaCliente","CodiceNazioneCliente","TelefonoCliente","FaxCliente","CellulareCliente","Telefono2Cliente","MailCliente","CodiceLinguaCliente","CodicePagamentoCliente","CodiceTrasportoCliente","CodiceVettoreCliente","CodiceCategoriaCliente","DescrizioneCategoriaCliente","CodiceCategoriaPdc","DescrizioneCategoriaPdc","CodiceGruppoCliente","DescrizioneGruppoCliente","ABICliente","CABCliente","CCCCliente","ABBCliente","CBBCliente","CCBCliente","CodiceAgenteCliente","TipoAgenteCliente","ProgressivoAgenteCliente","CodiceAgente2Cliente","TipoAgente2Cliente","Progressivo2AgenteCliente","CodiceAgente3Cliente","TipoAgente3Cliente","Progressivo3AgenteCliente","CodiceAgente4Cliente","TipoAgente4Cliente","Progressivo4AgenteCliente","CodiceAgentePdc","VecchioCodiceCliente","NuovoCodiceCliente","UnCodCli","AttivazioneCliente","DisdettaCliente","AreaManagerTecnico","AttivoCliente","AttivoPdc","CessioneCredito","Mail2Cliente","Microarea","MicroBrick","CodCliEsterno","Latitudine","Longitudine","CodKAM") values ('S2','t3','type1','0001','BBB','njg79d35v',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.CLIENTI ("Società","TipoCodiceCliente","TipoCodicePdc","CodiceCliente","CodicePdc","PartitaIvaCliente","CodiceFiscaleCliente","RagioneBreveCliente","RagioneCliente","IndirizzoCliente","CAPCliente","CittàCliente","ProvinciaCliente","AreaCliente","ZonaCliente","CodiceNazioneCliente","TelefonoCliente","FaxCliente","CellulareCliente","Telefono2Cliente","MailCliente","CodiceLinguaCliente","CodicePagamentoCliente","CodiceTrasportoCliente","CodiceVettoreCliente","CodiceCategoriaCliente","DescrizioneCategoriaCliente","CodiceCategoriaPdc","DescrizioneCategoriaPdc","CodiceGruppoCliente","DescrizioneGruppoCliente","ABICliente","CABCliente","CCCCliente","ABBCliente","CBBCliente","CCBCliente","CodiceAgenteCliente","TipoAgenteCliente","ProgressivoAgenteCliente","CodiceAgente2Cliente","TipoAgente2Cliente","Progressivo2AgenteCliente","CodiceAgente3Cliente","TipoAgente3Cliente","Progressivo3AgenteCliente","CodiceAgente4Cliente","TipoAgente4Cliente","Progressivo4AgenteCliente","CodiceAgentePdc","VecchioCodiceCliente","NuovoCodiceCliente","UnCodCli","AttivazioneCliente","DisdettaCliente","AreaManagerTecnico","AttivoCliente","AttivoPdc","CessioneCredito","Mail2Cliente","Microarea","MicroBrick","CodCliEsterno","Latitudine","Longitudine","CodKAM") values ('S1','t5','type1','0002','BBB','8852fn',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.CLIENTI ("Società","TipoCodiceCliente","TipoCodicePdc","CodiceCliente","CodicePdc","PartitaIvaCliente","CodiceFiscaleCliente","RagioneBreveCliente","RagioneCliente","IndirizzoCliente","CAPCliente","CittàCliente","ProvinciaCliente","AreaCliente","ZonaCliente","CodiceNazioneCliente","TelefonoCliente","FaxCliente","CellulareCliente","Telefono2Cliente","MailCliente","CodiceLinguaCliente","CodicePagamentoCliente","CodiceTrasportoCliente","CodiceVettoreCliente","CodiceCategoriaCliente","DescrizioneCategoriaCliente","CodiceCategoriaPdc","DescrizioneCategoriaPdc","CodiceGruppoCliente","DescrizioneGruppoCliente","ABICliente","CABCliente","CCCCliente","ABBCliente","CBBCliente","CCBCliente","CodiceAgenteCliente","TipoAgenteCliente","ProgressivoAgenteCliente","CodiceAgente2Cliente","TipoAgente2Cliente","Progressivo2AgenteCliente","CodiceAgente3Cliente","TipoAgente3Cliente","Progressivo3AgenteCliente","CodiceAgente4Cliente","TipoAgente4Cliente","Progressivo4AgenteCliente","CodiceAgentePdc","VecchioCodiceCliente","NuovoCodiceCliente","UnCodCli","AttivazioneCliente","DisdettaCliente","AreaManagerTecnico","AttivoCliente","AttivoPdc","CessioneCredito","Mail2Cliente","Microarea","MicroBrick","CodCliEsterno","Latitudine","Longitudine","CodKAM") values ('S3','t5','type2','0002','BBB','73fh1az',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
Insert into PROVA.CLIENTI ("Società","TipoCodiceCliente","TipoCodicePdc","CodiceCliente","CodicePdc","PartitaIvaCliente","CodiceFiscaleCliente","RagioneBreveCliente","RagioneCliente","IndirizzoCliente","CAPCliente","CittàCliente","ProvinciaCliente","AreaCliente","ZonaCliente","CodiceNazioneCliente","TelefonoCliente","FaxCliente","CellulareCliente","Telefono2Cliente","MailCliente","CodiceLinguaCliente","CodicePagamentoCliente","CodiceTrasportoCliente","CodiceVettoreCliente","CodiceCategoriaCliente","DescrizioneCategoriaCliente","CodiceCategoriaPdc","DescrizioneCategoriaPdc","CodiceGruppoCliente","DescrizioneGruppoCliente","ABICliente","CABCliente","CCCCliente","ABBCliente","CBBCliente","CCBCliente","CodiceAgenteCliente","TipoAgenteCliente","ProgressivoAgenteCliente","CodiceAgente2Cliente","TipoAgente2Cliente","Progressivo2AgenteCliente","CodiceAgente3Cliente","TipoAgente3Cliente","Progressivo3AgenteCliente","CodiceAgente4Cliente","TipoAgente4Cliente","Progressivo4AgenteCliente","CodiceAgentePdc","VecchioCodiceCliente","NuovoCodiceCliente","UnCodCli","AttivazioneCliente","DisdettaCliente","AreaManagerTecnico","AttivoCliente","AttivoPdc","CessioneCredito","Mail2Cliente","Microarea","MicroBrick","CodCliEsterno","Latitudine","Longitudine","CodKAM") values ('S4','t4','type2','0001','BBB','jvr67s2',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
--------------------------------------------------------
--  DDL for Index SYS_C007678
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROVA"."SYS_C007678" ON "PROVA"."CLIENTI" ("Società", "CodiceCliente") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table CLIENTI
--------------------------------------------------------

  ALTER TABLE "PROVA"."CLIENTI" ADD PRIMARY KEY ("Società", "CodiceCliente")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
