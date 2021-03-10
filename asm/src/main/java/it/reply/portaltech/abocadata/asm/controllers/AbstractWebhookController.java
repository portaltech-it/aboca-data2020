package it.reply.portaltech.abocadata.asm.controllers;

import java.util.Objects;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import it.reply.portaltech.abocadata.asm.asmExceptions.NoOrderIdWebHookException;
import it.reply.portaltech.abocadata.asm.asmExceptions.NotVerifiedWebHookException;
import it.reply.portaltech.abocadata.asm.services.ServiceConsumer;
import it.reply.portaltech.abocadata.asm.util.HmacChecker;

public abstract class AbstractWebhookController {

	private static final String X_SHOPIFY_ORDER_ID = "X-Shopify-Order-Id";
	public static final String X_SHOPIFY_HMAC_SHA256 = "X-Shopify-Hmac-Sha256";
	public static final String X_SHOPIFY_WEBHOOK_ID = "X-Shopify-Webhook-Id";
	public static final String X_SHOPIFY_TOPIC = "X-Shopify-Topic";
	public static final String UTF_8 = "UTF-8";
	
	private static final Logger LOG = LoggerFactory.getLogger(AbstractWebhookController.class);
	
	@Autowired
	private ServiceConsumer serviceConsumer;

	
	public void createOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret, String shop)
			throws Exception {
		String headerHmac = request.getHeader(X_SHOPIFY_HMAC_SHA256);
		String webhook_id = request.getHeader(X_SHOPIFY_WEBHOOK_ID);
		String message = IOUtils.toString(request.getInputStream(), UTF_8);
		String order_id = request.getHeader(X_SHOPIFY_ORDER_ID);

		String head = calculateHead(message, webhook_id, order_id, shop, request);
		
		HmacChecker hc = new HmacChecker(secret);
		boolean isVerified = hc.verifyWebhook(headerHmac, message);

		if (isVerified) {
			LOG.info(head + "Signature valid");
			serviceConsumer.sendOrderToCreate(message, url, clientID, clientSecret, head, order_id);
		} else {
			LOG.warn(head + "Signature not valid");
			throw new NotVerifiedWebHookException("Exception - WebHook " + webhook_id + ": signature not valid");
		}
	}

	public void deleteOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret, String shop)
			throws Exception {
		String headerHmac = request.getHeader(X_SHOPIFY_HMAC_SHA256);
		String webhook_id = request.getHeader(X_SHOPIFY_WEBHOOK_ID);
		String message = IOUtils.toString(request.getInputStream(), UTF_8);
		String order_id = request.getHeader(X_SHOPIFY_ORDER_ID);

		String head = calculateHead(message, webhook_id, order_id,shop, request);

		HmacChecker hc = new HmacChecker(secret);
		boolean isVerified = hc.verifyWebhook(headerHmac, message);

		if (isVerified) {
			LOG.info(head + "Signature valid");
			serviceConsumer.sendOrderToDelete(message, url, clientID, clientSecret, head, order_id);
		} else {
			LOG.warn(head + "Signature not valid");
			throw new NotVerifiedWebHookException("WebHook " + webhook_id + ": signature not valid");
		}
	}

	public void updateOrder(HttpServletRequest request, String secret, String url, String clientID, String clientSecret, String shop)
			throws Exception {
		String headerHmac = request.getHeader(X_SHOPIFY_HMAC_SHA256);
		String webhook_id = request.getHeader(X_SHOPIFY_WEBHOOK_ID);
		String message = IOUtils.toString(request.getInputStream(), UTF_8);
		String order_id = request.getHeader(X_SHOPIFY_ORDER_ID);

		String head = calculateHead(message, webhook_id, order_id, shop, request);
		
		HmacChecker hc = new HmacChecker(secret);
		boolean isVerified = hc.verifyWebhook(headerHmac, message);
	
		if (isVerified) {
			LOG.info(head + "Signature valid");
			serviceConsumer.sendOrderToUpdate(message, url, clientID, clientSecret, head, order_id);
		} else {
			LOG.warn(head + "Signature not valid");
			throw new NotVerifiedWebHookException("WebHook " + webhook_id + ": signature not valid");
		}
	}
	
	private String calculateHead(String message, String webhook_id, String order_id, String shop, HttpServletRequest request){
		String webhook_type = request.getHeader(X_SHOPIFY_TOPIC);		

		String shopShort = shop.substring(shop.lastIndexOf("/") + 1, shop.length());
		String head = webhook_id + "_" + webhook_type + "_" + order_id + "_" + shopShort + " : ";
		return head;
	}
	
//	private String getOrderID(String message) {
//		
//		JSONObject jsonObject = new JSONObject(message);
//		if (!Objects.nonNull(jsonObject.getLong("id"))) {
//			return StringUtils.EMPTY;
//		}
//		Long id = jsonObject.getLong("id");
//		return Long.toString(id);
//	}
}

