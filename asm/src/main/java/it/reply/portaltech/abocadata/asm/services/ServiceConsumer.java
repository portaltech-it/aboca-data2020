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
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Service
public class ServiceConsumer {
	
	@Value("${ords.path.models}")
	private String ORDSMODELSPATH;

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

	public void sendPOST(String message, String url, String clientID, String clientSecret, String head, String order_id) {
		String accessToken = getOauth2Token(url + TOKENREQUESTPATH, clientID, clientSecret, head);

		LOG.info(head + "Sending order data to ORDS");
		
		message = updatePaymentGatewayNames(message);

		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + accessToken);
		headers.setContentType(MediaType.APPLICATION_JSON);

		HttpEntity<String> entity = new HttpEntity<String>(message, headers);
		ResponseEntity<String> response = restTemplate.postForEntity(url + ORDSMODELSPATH + "/" + order_id, entity, String.class);
		
		LOG.info(head + "Order created");
	}

	public void sendPUT(String message, String url, String clientID, String clientSecret, String head, String order_id, int deletion) {
		String accessToken = getOauth2Token(url + TOKENREQUESTPATH, clientID, clientSecret, head);

		LOG.info(head + "Sending order data to ORDS");

		message = updatePaymentGatewayNames(message);
		
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + accessToken);
		headers.setContentType(MediaType.APPLICATION_JSON);

		Map<String, Object> pathParam = new HashMap<>();
		pathParam.put("order_id", order_id);

		String urlRequest = url + ORDSMODELSPATH + "/{order_id}";
		UriComponentsBuilder builder = UriComponentsBuilder.fromUriString(urlRequest).queryParam("deletion", deletion);

		HttpEntity<String> entity = new HttpEntity<String>(message, headers);
		ResponseEntity<String> response = restTemplate.exchange(builder.buildAndExpand(pathParam).toUri(), HttpMethod.PUT, entity, String.class);

		if(deletion == 0)
			LOG.info(head + "Order updated");
		else if(deletion == 1)
			LOG.info(head + "Order deleted");
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