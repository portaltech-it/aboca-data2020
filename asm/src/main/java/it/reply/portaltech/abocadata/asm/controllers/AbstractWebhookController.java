package it.reply.portaltech.abocadata.asm.controllers;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.reply.portaltech.abocadata.asm.customExceptions.NotVerifiedWebHookException;
import it.reply.portaltech.abocadata.asm.util.HmacChecker;
import it.reply.portaltech.abocadata.asm.util.RequestHandler;

public abstract class AbstractWebhookController {
	
	private static final Logger LOG = LoggerFactory.getLogger(AbstractWebhookController.class);

        
	public void createOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret) throws Exception
    {
  	    String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
	    String message = IOUtils.toString(request.getInputStream(), "UTF-8");

    	HmacChecker hc = new HmacChecker(secret);
    	boolean verified = hc.verifyWebhook(headerHmac, message);

    	if(verified)
    	{
        	RequestHandler.sendOrderToCreate(message, url, clientID, clientSecret);
        	LOG.debug("Webhook verificated");
    	}
    	else
    		throw new NotVerifiedWebHookException("Exception - WebHook not verified");
    }
	
	public void deleteOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret) throws Exception
	{
		String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
	    String message = IOUtils.toString(request.getInputStream(), "UTF-8");
	    
    	HmacChecker hc = new HmacChecker(secret);
    	boolean verified = hc.verifyWebhook(headerHmac, message);

    	if(verified)
        	RequestHandler.sendOrderToDelete(message, url, clientID, clientSecret);
    	else
    	{
    		throw new NotVerifiedWebHookException("Exception - WebHook not verified");	
    	}
	}
	
	public void updateOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret) throws Exception
	{
		String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
	    String message = IOUtils.toString(request.getInputStream(), "UTF-8");
	    
    	HmacChecker hc = new HmacChecker(secret);
    	boolean verified = hc.verifyWebhook(headerHmac, message);
    	
    	if(verified)
    	{
        	RequestHandler.sendOrderToUpdate(message, url, clientID, clientSecret);
        	LOG.debug("Webhook verificated");
    	}
    	else
    		throw new NotVerifiedWebHookException("Exception - WebHook not verified");
	}
}
