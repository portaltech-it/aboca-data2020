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
  	    String order_id = request.getHeader("X-Shopify-Webhook-Id");
	    String message = IOUtils.toString(request.getInputStream(), "UTF-8");

    	HmacChecker hc = new HmacChecker(secret);
    	boolean isVerified = hc.verifyWebhook(headerHmac, message);

    	if(isVerified)
    	{
        	RequestHandler.sendOrderToCreate(message, url, clientID, clientSecret);
        	LOG.debug("Webhook " + order_id + " verificated");
    	}
    	else
    		throw new NotVerifiedWebHookException("Exception - WebHook " + order_id + " not verified");
    }
	
	public void deleteOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret) throws Exception
	{
		String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
		String order_id = request.getHeader("X-Shopify-Webhook-Id");
		String message = IOUtils.toString(request.getInputStream(), "UTF-8");    
	    
    	HmacChecker hc = new HmacChecker(secret);
    	boolean isVerified = hc.verifyWebhook(headerHmac, message);

    	if(isVerified)
    	{
        	RequestHandler.sendOrderToDelete(message, url, clientID, clientSecret);
        	LOG.debug("Webhook " + order_id + " verificated");
    	}
    	else
    		throw new NotVerifiedWebHookException("Exception - WebHook " + order_id + " not verified");
	}
	
	public void updateOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret) throws Exception
	{
		String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
		String order_id = request.getHeader("X-Shopify-Webhook-Id");
	    String message = IOUtils.toString(request.getInputStream(), "UTF-8");
	    
    	HmacChecker hc = new HmacChecker(secret);
    	boolean isVerified = hc.verifyWebhook(headerHmac, message);
    	
    	if(isVerified)
    	{
        	RequestHandler.sendOrderToUpdate(message, url, clientID, clientSecret);
        	LOG.debug("Webhook " + order_id + " verificated");
    	}
    	else
    		throw new NotVerifiedWebHookException("Exception - WebHook " + order_id + " not verified");
	}
}
