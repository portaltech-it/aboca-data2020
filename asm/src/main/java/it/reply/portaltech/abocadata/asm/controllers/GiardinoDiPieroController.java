package it.reply.portaltech.abocadata.asm.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.apache.log4j.Logger;

@RestController
@RequestMapping("/asm/gdp")
public class GiardinoDiPieroController extends SuperController
{	
	@Value("${key.secret.giardinidipiero}")
	private String shopifySecret;

	@Value("${tyk.api.oauth.abocashop.clientid}")
	private String clientID;

	@Value("${tyk.api.oauth.abocashop.secret}")
	private String clientSecret;
	
	@Value("${shopify.hostname.giardinidipiero}")
	private String hostname;
		
	@Value("${tyk.api.orders}")
	private String ordsURL;
	
    private Logger log = Logger.getLogger(hostname + ".log");
    
          
    @PostMapping("/createOrder")
    public String handleCreation(HttpServletRequest request)
    {
  	    try {
			return super.postOrder(request, this.shopifySecret, this.ordsURL,  clientID, clientSecret);
		} catch (Exception e) {
			log.debug(e.getStackTrace());
		}
    	return "Error";
    }
    
	@PostMapping("/deleteOrder")
    public String handleDeletion(HttpServletRequest request)
    {
    	try {
			return super.deleteOrder(request, this.shopifySecret, this.ordsURL,  clientID, clientSecret);
		} catch (Exception e) {
			log.debug(e.getStackTrace());
		}
    	return "Error";
    }
    
    @PostMapping("/updateOrder")
    public String handleUpdate(HttpServletRequest request)
    {
    	try {
			return super.updateOrder(request, this.shopifySecret, this.ordsURL,  clientID, clientSecret);
		} catch (Exception e) {
			log.debug(e.getStackTrace());
		}
    	return "Error";
    }
}
