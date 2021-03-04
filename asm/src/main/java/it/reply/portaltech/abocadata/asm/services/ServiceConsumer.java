package it.reply.portaltech.abocadata.asm.services;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class ServiceConsumer {
	@Value("${ords.path.order.create}")
	private String CREATEPATH;

	@Value("${ords.path.order.delete}")
	private String DELETEPATH;

	@Value("${ords.path.order.update}")
	private String UPDATEPATH;

	private static final String TOKENREQUESTPATH = "/oauth/token";
	private static final Logger LOG = LoggerFactory.getLogger(ServiceConsumer.class);

	private String getOauth2Token(String tokenURL, String clientID, String clientSecret, String head) {
		String encodedB64 = Base64.encodeBase64String((clientID + ":" + clientSecret).getBytes());
		String access_token = null;

		Map<String, Object> body = new HashMap<>();
		body.put("grant_type", "client_credentials");
		body.put("client_id", clientID);
		body.put("client_secret", clientSecret);

		LOG.info(head + "Requesting access token for client = " + clientID);

		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Basic " + encodedB64);
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

		HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);
		ResponseEntity<String> response = restTemplate.postForEntity(tokenURL, entity, String.class);
		
		JSONObject jsonObject = new JSONObject(response.getBody());
		access_token = jsonObject.getString("access_token");
		
		LOG.info(head + response.getStatusCodeValue() + "_" + response.getBody());

		return access_token;
	}

	public void sendOrderToCreate(String message, String url, String clientID, String clientSecret, String head) {
		String accessToken = getOauth2Token(url + TOKENREQUESTPATH, clientID, clientSecret, head);

		LOG.info(head + "Sending order data to ORDS");
		
		message = updatePaymentGatewayNames(message);

		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + accessToken);
		headers.setContentType(MediaType.APPLICATION_JSON);

		HttpEntity<String> entity = new HttpEntity<String>(message, headers);
		ResponseEntity<String> response = restTemplate.postForEntity(url + CREATEPATH, entity, String.class);
		
		LOG.info(head + response.getStatusCodeValue() + "_" + response.getBody());
	}

	public void sendOrderToUpdate(String message, String url, String clientID, String clientSecret, String head) {
		String accessToken = getOauth2Token(url + TOKENREQUESTPATH, clientID, clientSecret, head);

		LOG.info(head + "Sending order data to ORDS");

		message = updatePaymentGatewayNames(message);
		
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + accessToken);
		headers.setContentType(MediaType.APPLICATION_JSON);

		HttpEntity<String> entity = new HttpEntity<String>(message, headers);
		ResponseEntity<String> response = restTemplate.postForEntity(url + UPDATEPATH, entity, String.class);
		
		LOG.info(head + response.getStatusCodeValue() + "_" + response.getBody());
	}

	public void sendOrderToDelete(String message, String url, String clientID, String clientSecret, String head) {
		String accessToken = getOauth2Token(url + TOKENREQUESTPATH, clientID, clientSecret, head);

		LOG.info(head + "Sending order data to ORDS");

		message = updatePaymentGatewayNames(message);

		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + accessToken);
		headers.setContentType(MediaType.APPLICATION_JSON);

		HttpEntity<String> entity = new HttpEntity<String>(message, headers);
		ResponseEntity<String> response = restTemplate.postForEntity(url + DELETEPATH, entity, String.class);
		
		LOG.info(head + response.getStatusCodeValue() + "_" + response.getBody());
	}
	
	private String updatePaymentGatewayNames(String body)
	{
		JSONObject jsonObject = new JSONObject(body);
		Object payment_gateway_names = jsonObject.get("payment_gateway_names");
		jsonObject.remove("payment_gateway_names");
		jsonObject.put("payment_gateway_names", payment_gateway_names.toString());
		return body;
	}
}
