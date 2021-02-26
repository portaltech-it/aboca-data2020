package it.reply.portaltech.abocadata.asm.controllers;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import it.reply.portaltech.abocadata.asm.util.HmacChecker;
import it.reply.portaltech.abocadata.asm.util.RequestHandler;

@RestController
@RequestMapping("/asm/as")
public class AbocaShopController extends SuperController
{	
	@Value("${key.secret.abocashop}")
	private String secret;

	@Value("${shopify.hostname.abocashop}")
	private String hostname;

	@Value("${shopify.hostname.abocashop}")
	private String url;

	
    private Logger log = Logger.getLogger(this.hostname + ".log");

    
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
