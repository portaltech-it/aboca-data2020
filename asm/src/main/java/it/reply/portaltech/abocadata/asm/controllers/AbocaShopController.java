package it.reply.portaltech.abocadata.asm.controllers;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/asm/as")
public class AbocaShopController extends SuperController
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
	
    private Logger log = Logger.getLogger(this.hostname + ".log");

    
    @PostMapping("/createOrder")
    public String handleCreation(HttpServletRequest request)
    {
  	    try {
			return super.postOrder(request, this.shopifySecret, this.ordsURL, clientID, clientSecret);
		} catch (Exception e) {
			log.debug(e.getStackTrace());
		}
    	return "Error";
    }
    
	@PostMapping("/deleteOrder")
    public String handleDeletion(HttpServletRequest request)
    {
    	try {
			return super.deleteOrder(request, this.shopifySecret, this.ordsURL, clientID, clientSecret);
		} catch (Exception e) {
			log.debug(e.getStackTrace());
		}
    	return "Error";
    }
    
    @PostMapping("/updateOrder")
    public String handleUpdate(HttpServletRequest request)
    {
    	try {
			return super.updateOrder(request, this.shopifySecret, this.ordsURL, clientID, clientSecret);
		} catch (Exception e) {
			log.debug(e.getStackTrace());
		}
    	return "Error";
    }
    
    
    
}
