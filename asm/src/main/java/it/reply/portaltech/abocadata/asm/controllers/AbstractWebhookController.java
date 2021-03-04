package it.reply.portaltech.abocadata.asm.controllers;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import it.reply.portaltech.abocadata.asm.AsmExceptions.NotVerifiedWebHookException;
import it.reply.portaltech.abocadata.asm.services.ServiceConsumer;
import it.reply.portaltech.abocadata.asm.util.HmacChecker;

public abstract class AbstractWebhookController {

	@Autowired
	private ServiceConsumer serviceConsumer;

	private static final Logger LOG = LoggerFactory.getLogger(AbstractWebhookController.class);

	public void createOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret, String shop)
			throws Exception {
		String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
		String webhook_id = request.getHeader("X-Shopify-Webhook-Id");
		String message = IOUtils.toString(request.getInputStream(), "UTF-8");
		
		boolean isBodyValid = false;
		String head = null;
		try {
			head = calculateHead(request, message, webhook_id, shop);
			isBodyValid = true;
		}
		catch(JSONException e){
			LOG.warn("Exception - WebHook " + webhook_id + " : Order Id missing");
		}
		
		HmacChecker hc = new HmacChecker(secret);
		boolean isVerified = hc.verifyWebhook(headerHmac, message);
		
		if(isBodyValid) {
			if (isVerified) {
				LOG.info(head + "Signature valid");
				serviceConsumer.sendOrderToCreate(message, url, clientID, clientSecret, head);
			} else {
				LOG.warn(head + "Signature not valid");
				throw new NotVerifiedWebHookException("Exception - WebHook " + webhook_id + ": signature not valid");
			}
		}
	}

	public void deleteOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret, String shop)
			throws Exception {
		String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
		String webhook_id = request.getHeader("X-Shopify-Webhook-Id");
		String message = IOUtils.toString(request.getInputStream(), "UTF-8");
		
		boolean isBodyValid = false;
		String head = null;
		try {
			head = calculateHead(request, message, webhook_id, shop);
			isBodyValid = true;
		}
		catch(JSONException e){
			LOG.warn("Exception - WebHook " + webhook_id + " : Order Id missing");
		}
		
		if(isBodyValid) {
			HmacChecker hc = new HmacChecker(secret);
			boolean isVerified = hc.verifyWebhook(headerHmac, message);

			if (isVerified) {
				LOG.info(head + "Signature valid");
				serviceConsumer.sendOrderToDelete(message, url, clientID, clientSecret, head);
			} else {
				LOG.warn(head + "Signature not valid");
				throw new NotVerifiedWebHookException("Exception - WebHook " + webhook_id + ": signature not valid");
			}
		}
	}

	public void updateOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret, String shop)
			throws Exception {
		String headerHmac = request.getHeader("X-Shopify-Hmac-Sha256");
		String webhook_id = request.getHeader("X-Shopify-Webhook-Id");
		String message = IOUtils.toString(request.getInputStream(), "UTF-8");
		
		boolean isBodyValid = false;
		String head = null;
		try {
			head = calculateHead(request, message, webhook_id, shop);
			isBodyValid = true;
		}
		catch(JSONException e){
			LOG.warn("Exception - WebHook " + webhook_id + " : Order Id missing");
		}
		
		if(isBodyValid) {
			HmacChecker hc = new HmacChecker(secret);
			boolean isVerified = hc.verifyWebhook(headerHmac, message);
		
			if (isVerified) {
				LOG.info(head + "Signature valid");
				serviceConsumer.sendOrderToUpdate(message, url, clientID, clientSecret, head);
			} else {
				LOG.warn(head + "Signature not valid");
				throw new NotVerifiedWebHookException("Exception - WebHook " + webhook_id + ": signature not valid");
			}
		}
	}
	
	private String calculateHead(HttpServletRequest request, String message, String webhook_id, String shop)
	{
		String webhook_type = request.getHeader("X-Shopify-Topic");
		String order_id = getOrderID(message);
		
		String shopShort = shop.substring(shop.lastIndexOf("/") + 1, shop.length());

		String head = webhook_id + "_" + webhook_type + "_" + order_id + "_" + shopShort + " : ";

		return head;
	}
	
	private String getOrderID(String message)
	{
		JSONObject jsonObject = new JSONObject(message);
		String id = null;
		Long id_long;
		
		id_long = jsonObject.getLong("id");
		id = Long.toString(id_long);
				
		return id;
	}
}
