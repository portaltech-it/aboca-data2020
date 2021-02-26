package it.reply.portaltech.abocadata.asm.controllers;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;

import it.reply.portaltech.abocadata.asm.util.HmacChecker;
import it.reply.portaltech.abocadata.asm.util.RequestHandler;

public abstract class SuperController {
        
	public boolean postOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret) throws Exception
    {
		System.out.println(url);
  	    String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
	    String message = IOUtils.toString(request.getInputStream(), "UTF-8");
	    
    	HmacChecker hc = new HmacChecker(secret);
		System.out.println(url);

    	boolean verified = hc.verifyWebhook(headerHmac, message);
		System.out.println(url);
    	
    	if(verified)
        	RequestHandler.sendOrderToCreate(message, url, clientID, clientSecret);

    	return verified;
    }
	
	public boolean deleteOrder(HttpServletRequest request, String secret, String url) throws Exception
	{
		String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
	    String message = IOUtils.toString(request.getInputStream(), "UTF-8");
	    
    	HmacChecker hc = new HmacChecker(secret);

    	boolean verified = hc.verifyWebhook(headerHmac, message);
    	
    	if(verified)
        	RequestHandler.sendOrderToDelete(message, url);

    	
    	return verified; 
	}
	
	public boolean updateOrder(HttpServletRequest request, String secret, String url) throws Exception
	{
		String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
	    String message = IOUtils.toString(request.getInputStream(), "UTF-8");
	    
    	HmacChecker hc = new HmacChecker(secret);

    	boolean verified = hc.verifyWebhook(headerHmac, message);
    	
    	if(verified)
        	RequestHandler.sendOrderToUpdate(message, url);

    	
    	return verified; 
	}

}
