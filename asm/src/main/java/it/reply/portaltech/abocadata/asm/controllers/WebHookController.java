package it.reply.portaltech.abocadata.asm.controllers;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import it.reply.portaltech.abocadata.asm.util.HmacChecker;

@RestController
public class WebHookController
{	
    @GetMapping("/hello")
    public String printhello()
    {
    	return "hello world";
    }
    
    @PostMapping("/webhook")   
    private String verifyWebhook(HttpServletRequest request)
    {
    	//to be initialized with the proper secret
    	String secret = null;
    	
  	    String hmac = request.getHeader("X-Shopify-Hmac-Sha256");
    	HmacChecker hc = new HmacChecker(secret);
    	try {
	  	    String jsonString = IOUtils.toString(request.getInputStream(),"UTF-8");
	  	    boolean b = hc.checkHmac(jsonString, hmac);
	  	  	return  hmac + "  " + hc.calculated;  
    	}
    	catch (Exception e) {
    		e.printStackTrace();
    		return "error";
  	  	}
  	}
}
