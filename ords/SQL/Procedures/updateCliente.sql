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
  SET ragione_sociale_cli   = NVL(p_ragionecliente, ragione_sociale_cli),
      indirizzo_cli         = NVL(p_indirizzocliente, indirizzo_cli),
      cap_cli               = NVL(p_capcliente, cap_cli),
      citta_cli             = NVL(p_cittacliente, citta_cli),
      provincia_cli         = NVL(p_provinciacliente, provincia_cli),
      area_cli              = NVL(p_areacliente, area_cli),
      zona_cli              = NVL(p_zonacliente, zona_cli),
      telefono_cli          = NVL(p_telefonocliente, telefono_cli),
      fax_cli               = NVL(p_faxcliente, fax_cli),
      cellulare_cli         = NVL(p_cellularecliente, cellulare_cli),
      telefono2_cli         = NVL(p_telefono2cliente, telefono2_cli),
      mail_cli              = NVL(p_mailcliente, mail_cli),
      attivo_cli            = NVL(p_attivocliente, attivo_cli),
      attivo_pdc            = NVL(p_attivopdc, attivo_pdc),
      mail2_cli             = NVL(p_mail2cliente, mail2_cli),
      cod_cli_esterno       = NVL(p_codcliesterno, cod_cli_esterno)

  WHERE societa = p_societa AND cod_cli = p_codicecliente AND cod_pdc = p_codicepdc;
  
  
EXCEPTION
  WHEN OTHERS THEN
    HTP.print(SQLERRM);
END;
