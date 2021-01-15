create or replace PROCEDURE updateCliente (
  p_societa                     IN  VARCHAR2,
  p_codicecliente               IN  VARCHAR2,
  p_codicepdc                   IN  VARCHAR2,
  p_ragionecliente              IN  VARCHAR2,    
  p_indirizzocliente            IN  VARCHAR2,
  p_capcliente                  IN  VARCHAR2,
  p_cittacliente                IN  VARCHAR2,
  p_provinciacliente            IN  VARCHAR2,
  p_areacliente                 IN  VARCHAR2,
  p_zonacliente                 IN  VARCHAR2,
  p_telefonocliente             IN  VARCHAR2,
  p_faxcliente                  IN  VARCHAR2,
  p_cellularecliente            IN  VARCHAR2,
  p_telefono2cliente            IN  VARCHAR2,
  p_mailcliente                 IN  VARCHAR2,
  p_attivocliente               IN  NUMBER,
  p_attivopdc                   IN  NUMBER,
  p_mail2cliente                IN  VARCHAR2,
  p_codcliesterno               IN  VARCHAR2
)

AS
BEGIN
  UPDATE TB_CLIENTI_TMP
  SET societa               = p_societa,
      cod_cli               = p_codicecliente,
      cod_pdc               = p_codicepdc,
  	  ragione_sociale_cli   = p_ragionecliente,
      indirizzo_cli         = p_indirizzocliente,
      cap_cli               = p_capcliente,
      citta_cli             = p_cittacliente,
      provincia_cli         = p_provinciacliente,
      area_cli              = p_areacliente,
      zona_cli              = p_zonacliente,
      telefono_cli          = p_telefonocliente ,
      fax_cli               = p_faxcliente,
      cellulare_cli         = p_cellularecliente,
      telefono2_cli         = p_telefono2cliente,
      mail_cli              = p_mailcliente,
      attivo_cli            = p_attivocliente,
      attivo_pdc            = p_attivopdc,
      mail2_cli             = p_mail2cliente,
      cod_cli_esterno       = p_codcliesterno

  WHERE societa = p_societa AND cod_cli = p_codicecliente AND cod_pdc = p_codicepdc;
EXCEPTION
  WHEN OTHERS THEN
    HTP.print(SQLERRM);
END;