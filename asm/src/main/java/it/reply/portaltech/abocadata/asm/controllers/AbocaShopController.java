package it.reply.portaltech.abocadata.asm.controllers;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import it.reply.portaltech.abocadata.asm.customExceptions.NotVerifiedWebHookException;

@RestController
@RequestMapping("/asm/as")
public class AbocaShopController extends AbstractWebhookController
{	
	@Value("${key.secret.abocashop}")
	private String shopifySecret;
	
	@Value("${tyk.api.oauth.abocashop.clientid}")
	private String clientID;

	@Value("${tyk.api.oauth.abocashop.secret}")
	private String clientSecret;
	
	@Value("${shopify.hostname.abocashop}")
	private String hostname;
	
	@Value("${tyk.api.orders}")
	private String ordsURL;
	
	private static final Logger LOG = LoggerFactory.getLogger(AbocaShopController.class);

    
    @PostMapping("/createOrder")
    public void handleCreation(HttpServletRequest request)
    {
  	    try {
			super.createOrder(request, this.shopifySecret, this.ordsURL, clientID, clientSecret);
		}
    	catch (NotVerifiedWebHookException e2)
    	{
    		LOG.error("", e2);
    	}
  	    catch (Exception e) {
			LOG.error("", e);
		}
    }
    
	@PostMapping("/deleteOrder")
    public void handleDeletion(HttpServletRequest request)
    {
    	try {
			super.deleteOrder(request, this.shopifySecret, this.ordsURL, clientID, clientSecret);
		}
    	catch (NotVerifiedWebHookException e2)
    	{
    		LOG.error("", e2);
    	}
  	    catch (Exception e) {
			LOG.error("", e);
		}
    }
    
    @PostMapping("/updateOrder")
    public void handleUpdate(HttpServletRequest request)
    {
    	try {
			super.updateOrder(request, this.shopifySecret, this.ordsURL, clientID, clientSecret);
		}
    	catch (NotVerifiedWebHookException e2)
    	{
    		LOG.error("", e2);
    	}
  	    catch (Exception e) {
			LOG.error("", e);
		}
    }   
}
