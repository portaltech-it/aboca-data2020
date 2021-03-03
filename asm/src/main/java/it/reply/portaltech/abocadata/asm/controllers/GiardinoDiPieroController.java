package it.reply.portaltech.abocadata.asm.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import it.reply.portaltech.abocadata.asm.AsmExceptions.NotVerifiedWebHookException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
@RequestMapping("/asm/gdp")
public class GiardinoDiPieroController extends AbstractWebhookController {
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
	
	private static final Logger LOG = LoggerFactory.getLogger(GiardinoDiPieroController.class);

	@PostMapping("/createOrder")
	public void handleCreation(HttpServletRequest request) {
		try {
			createOrder(request, this.shopifySecret, this.ordsURL, clientID, clientSecret);
		} catch (NotVerifiedWebHookException e2) {
			LOG.warn("", e2);
		} catch (Exception e) {
			LOG.warn("", e);
		}
	}

	@PostMapping("/deleteOrder")
	public void handleDeletion(HttpServletRequest request) {
		try {
			deleteOrder(request, this.shopifySecret, this.ordsURL, clientID, clientSecret);
		} catch (NotVerifiedWebHookException e2) {
			LOG.warn("", e2);
		} catch (Exception e) {
			LOG.warn("", e);
		}
	}

	@PostMapping("/updateOrder")
	public void handleUpdate(HttpServletRequest request) {
		try {
			updateOrder(request, this.shopifySecret, this.ordsURL, clientID, clientSecret);
		} catch (NotVerifiedWebHookException e2) {
			LOG.warn("", e2);
		} catch (Exception e) {
			LOG.warn("", e);
		}
	}
}
