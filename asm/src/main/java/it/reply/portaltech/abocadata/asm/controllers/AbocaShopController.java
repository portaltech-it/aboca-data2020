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
	private String secret = "640171b3de3269b45a4b07b72c258f95e5dfe44fdcb8673b6b825cc949ebe13d";

	@Value("${shopify.hostname.abocashop}")
	private String hostname;
	
    private Logger log = Logger.getLogger(this.hostname + ".log");

    
    @PostMapping("/createOrder")
    public boolean handleCreation(HttpServletRequest request) throws Exception
    {
  	    return super.handleCreation(request, this.secret);
    	
    }
    
//	@PostMapping("/asm/as/deleteOrder")
//    public void handleDeletion(HttpServletRequest request)
//    {
//    	this.verifyWebhook(request);
//    	//sendDataToDelete()
//    }
//    
//    @PostMapping("/asm/as/updateOrder")
//    public void handleUpdate(HttpServletRequest request)
//    {
//    	this.verifyWebhook(request);
//    	//sendDataToCreate()
//    }
    
    
    
}
