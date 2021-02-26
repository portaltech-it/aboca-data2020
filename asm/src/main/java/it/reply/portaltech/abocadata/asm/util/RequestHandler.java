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
    	System.out.println(clientID+":"+clientSecret);
    	String encodedB64 = Base64.encodeBase64String((clientID+":"+clientSecret).getBytes());
    	System.out.println("ENCODED = " + encodedB64);
    	
		Map<Object, Object> body = new HashMap<>();
		body.put("grant_type", "client_credentials");
		body.put("client_id", clientID);
		body.put("client_secret", clientSecret);

		HttpRequest request = HttpRequest.newBuilder()
		        .POST(buildFormDataFromMap(body))
		        .uri(URI.create(tokenURL))
		        .setHeader("User-Agent", "Java 11 HttpClient Bot")
		        .header("Content-Type", "application/json")
		        .header("Authentication", "Basic " + encodedB64)
		        .build();   
		
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

		JSONObject jsonObject = new JSONObject(response.body());
		String access_token = jsonObject.getString("access_token");
    	System.out.println("ACCESS TOKEN = " + access_token);

		return access_token;
    }
    
    public static void sendOrderToCreate(String message, String url, String clientID, String clientSecret) throws Exception 
    {		
    	String accessToken = getOauth2Token(url + "oauth/token", clientID, clientSecret);
    	System.out.println("ACCESS_TOKEN = " + accessToken);
    	
    	BodyPublisher bp = buildString(message);
		HttpRequest request = HttpRequest.newBuilder()
		        .POST(bp)
		        .uri(URI.create(url))
		        .setHeader("User-Agent", "Java 11 HttpClient Bot")
		        .header("Content-Type", "application/json")
		        //.header("Authentication", authorizationString)
		        .build();
		
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
    }

    public static void sendOrderToUpdate(String message, String url) throws Exception 
    {		
    	BodyPublisher bp = buildString(message);
		
		HttpRequest request = HttpRequest.newBuilder()
		        .PUT(bp)
		        .uri(URI.create(url))
		        .setHeader("User-Agent", "Java 11 HttpClient Bot")
		        .header("Content-Type", "application/json")
		        .build();
		
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
    }
    
    public static void sendOrderToDelete(String message, String url) throws IOException, InterruptedException 
    {
    	BodyPublisher bp = buildString(message);
		
		HttpRequest request = HttpRequest.newBuilder()
		        .PUT(bp)
		        .uri(URI.create(url))
		        .setHeader("User-Agent", "Java 11 HttpClient Bot")
		        .header("Content-Type", "application/json")
		        .build();
		
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
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
        System.out.println("BUILDER = " + builder.toString());
        return HttpRequest.BodyPublishers.ofString(builder.toString());
    }

    private static HttpRequest.BodyPublisher buildString(String data) 
    {
        System.out.println("BUILDER = " + data);
        return HttpRequest.BodyPublishers.ofString(data);
    }

	
}
