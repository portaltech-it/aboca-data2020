package it.reply.portaltech.abocadata.asm.controllers;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;

import it.reply.portaltech.abocadata.asm.util.HmacChecker;
import it.reply.portaltech.abocadata.asm.util.RequestHandler;

public abstract class SuperController {
        
	public String postOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret) throws Exception
    {
  	    String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
	    String message = IOUtils.toString(request.getInputStream(), "UTF-8");

    	HmacChecker hc = new HmacChecker(secret);
    	boolean verified = hc.verifyWebhook(headerHmac, message);

    	if(verified)
        	return RequestHandler.sendOrderToCreate(message, url, clientID, clientSecret);

    	return "Error";
    }
	
	public String deleteOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret) throws Exception
	{
		String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
	    String message = IOUtils.toString(request.getInputStream(), "UTF-8");
	    
    	HmacChecker hc = new HmacChecker(secret);
    	boolean verified = hc.verifyWebhook(headerHmac, message);
    	
    	if(verified)
        	return RequestHandler.sendOrderToDelete(message, url, clientID, clientSecret);

    	
    	return "Error"; 
	}
	
	public String updateOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret) throws Exception
	{
		String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
	    String message = IOUtils.toString(request.getInputStream(), "UTF-8");
	    
    	HmacChecker hc = new HmacChecker(secret);
    	boolean verified = hc.verifyWebhook(headerHmac, message);
    	
    	if(verified)
        	return RequestHandler.sendOrderToUpdate(message, url, clientID, clientSecret);

    	
    	return "Error"; 
	}

}
