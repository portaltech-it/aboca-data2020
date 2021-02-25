package it.reply.portaltech.abocadata.asm.controllers;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;

import it.reply.portaltech.abocadata.asm.util.HmacChecker;
import it.reply.portaltech.abocadata.asm.util.RequestHandler;

public abstract class SuperController {
        
    public boolean handleCreation(HttpServletRequest request, String secret) throws Exception
    {
  	    String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
	    String message = IOUtils.toString(request.getInputStream(), "UTF-8");
	    
    	HmacChecker hc = new HmacChecker(secret);

    	boolean verified = hc.verifyWebhook(headerHmac, message);
    	
    	if(verified)
        	RequestHandler.sendOrderToCreate(message);

    	
    	return verified;
    	
    }

}
