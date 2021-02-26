package it.reply.portaltech.abocadata.asm.controllers;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.apache.log4j.Logger;  


import it.reply.portaltech.abocadata.asm.util.HmacChecker;
import it.reply.portaltech.abocadata.asm.util.RequestHandler;

@RestController
@RequestMapping("/asm/gdp")
public class GiardinoDiPieroController extends SuperController
{	
	@Value("${key.secret.giardinidipiero}")
	private String secret;

	@Value("${shopify.hostname.giardinidipiero}")
	private String hostname;
	
    private Logger log = Logger.getLogger(hostname + ".log");
    
          
    @PostMapping("/createOrder")
    public boolean handleCreation(HttpServletRequest request)
    {
  	    try {
			return super.postOrder(request, this.secret, "http://localhost:3030/orders");
		} catch (Exception e) {
			log.debug(e.getStackTrace());
		}
    	return false;
    }
    
	@PostMapping("/deleteOrder")
    public boolean handleDeletion(HttpServletRequest request)
    {
    	try {
			return super.deleteOrder(request, this.secret, "http://localhost:3030/orders");
		} catch (Exception e) {
			log.debug(e.getStackTrace());
		}
    	return false;
    }
    
    @PostMapping("/updateOrder")
    public boolean handleUpdate(HttpServletRequest request)
    {
    	try {
			return super.updateOrder(request, this.secret, "http://localhost:3030/orders");
		} catch (Exception e) {
			log.debug(e.getStackTrace());
		}
    	return false;
    }
}
