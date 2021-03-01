package it.reply.portaltech.abocadata.asm.util;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpRequest.BodyPublisher;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.json.JSONObject;

public class RequestHandler 
{
    private static final HttpClient httpClient = HttpClient.newBuilder().version(HttpClient.Version.HTTP_2).build();

    private static String getOauth2Token(String tokenURL, String clientID, String clientSecret) throws IOException, InterruptedException
    {
    	String encodedB64 = Base64.encodeBase64String((clientID+":"+clientSecret).getBytes());
    	
		Map<Object, Object> body = new HashMap<>();
		body.put("grant_type", "client_credentials");
		body.put("client_id", clientID);
		body.put("client_secret", clientSecret);

;
		HttpRequest request = HttpRequest.newBuilder()
		        .POST(buildFormDataFromMap(body))
		        .uri(URI.create(tokenURL))
		        .setHeader("User-Agent", "Java 11 HttpClient Bot")
		        .header("Content-Type", "application/json")
		        .header("Authorization", "Basic " + encodedB64)
		        .build();   
		
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

		JSONObject jsonObject = new JSONObject(response.body());
		String access_token = jsonObject.getString("access_token");

		return access_token;
    }
    
    public static String sendOrderToCreate(String message, String url, String clientID, String clientSecret) throws Exception 
    {		
    	String accessToken = getOauth2Token(url + "oauth/token", clientID, clientSecret);
    	System.out.println("TOKEN = " + accessToken);
    	BodyPublisher bp = buildString(message);
		HttpRequest request = HttpRequest.newBuilder()
		        .POST(bp)
		        .uri(URI.create(url))
		        .setHeader("User-Agent", "Java 11 HttpClient Bot")
		        .header("Content-Type", "application/json")
		        .header("Authorization", "Bearer " + accessToken)
		        .build();
				
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
		
		return response.body();
    }

    public static String sendOrderToUpdate(String message, String url, String clientID, String clientSecret) throws Exception 
    {		
    	String accessToken = getOauth2Token(url + "oauth/token", clientID, clientSecret);

    	BodyPublisher bp = buildString(message);
		HttpRequest request = HttpRequest.newBuilder()
		        .PUT(bp)
		        .uri(URI.create(url))
		        .setHeader("User-Agent", "Java 11 HttpClient Bot")
		        .header("Content-Type", "application/json")
		        .header("Authorization", "Bearer " + accessToken)
		        .build();

		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
		
		return response.body();
    }
    
    public static String sendOrderToDelete(String message, String url, String clientID, String clientSecret) throws IOException, InterruptedException 
    {
    	String accessToken = getOauth2Token(url + "oauth/token", clientID, clientSecret);
    	
    	BodyPublisher bp = buildString(message);
		HttpRequest request = HttpRequest.newBuilder()
		        .PUT(bp)
		        .uri(URI.create(url))
		        .setHeader("User-Agent", "Java 11 HttpClient Bot")
		        .header("Content-Type", "application/json")
		        .header("Authorization", "Bearer " + accessToken)
		        .build();
		
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
		
		return response.body();
	}

    
    

    private static HttpRequest.BodyPublisher buildFormDataFromMap(Map<Object, Object> data) 
    {
        var builder = new StringBuilder();
        builder.append("{");
        for (Map.Entry<Object, Object> entry : data.entrySet()) 
        {
            if (builder.length() > 1) {
                builder.append(", ");
            }
            builder.append("\"" + URLEncoder.encode(entry.getKey().toString(), StandardCharsets.UTF_8) + "\"");
            builder.append(" : ");
            builder.append("\"" + entry.getValue().toString() + "\"");
        }
        builder.append("}");
        return HttpRequest.BodyPublishers.ofString(builder.toString());
    }

    private static HttpRequest.BodyPublisher buildString(String data) 
    {
        return HttpRequest.BodyPublishers.ofString(data);
    }

	
}
