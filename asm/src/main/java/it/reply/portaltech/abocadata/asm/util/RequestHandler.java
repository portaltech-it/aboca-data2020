package it.reply.portaltech.abocadata.asm.util;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

public class RequestHandler 
{
    private static final HttpClient httpClient = HttpClient.newBuilder().version(HttpClient.Version.HTTP_2).build();

    public String getOauth2Token(String tokenURL)
    {
    	String clientID;
    	String clientSecret;
    	String encoded ? null;
    	
		Map<Object, Object> body = new HashMap<>();
		body.put("grant_type", "client_credentials");
		body.put("client_id", clientID);
		body.put("client_secret", clientSecret);

		HttpRequest request = HttpRequest.newBuilder()
		        .POST(buildFormDataFromMap(body))
		        .uri(URI.create(tokenURL))
		        .setHeader("User-Agent", "Java 11 HttpClient Bot")
		        .header("Content-Type", "application/json")
		        .header("Authentication", "Basic " + encoded)
		        .build();   
		
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

		JSONObject jsonObject = new JSONObject(response.body());
		String access_token = jsonObject.getString("access_token");

		return access_token;
    }
    
    public static void sendOrderToCreate(String message, String url) throws Exception 
    {		
		Map<Object, Object> data = getDataMap(message);
		
		HttpRequest request = HttpRequest.newBuilder()
		        .POST(buildFormDataFromMap(data))
		        .uri(URI.create(url))
		        .setHeader("User-Agent", "Java 11 HttpClient Bot")
		        .header("Content-Type", "application/json")
		        //.header("Authentication", authorizationString)
		        .build();
		
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
    }

    public static void sendOrderToUpdate(String message, String url) throws Exception 
    {		
		Map<Object, Object> data = getDataMap(message);
		
		HttpRequest request = HttpRequest.newBuilder()
		        .PUT(buildFormDataFromMap(data))
		        .uri(URI.create(url))
		        .setHeader("User-Agent", "Java 11 HttpClient Bot")
		        .header("Content-Type", "application/json")
		        .build();
		
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
    }
    
    public static void sendOrderToDelete(String message, String url) throws IOException, InterruptedException 
    {
		Map<Object, Object> data = getDataMap(message);
		
		HttpRequest request = HttpRequest.newBuilder()
		        .DELETE()
		        .uri(URI.create(url + data.get("id")))
		        .setHeader("User-Agent", "Java 11 HttpClient Bot")
		        .header("Content-Type", "application/json")
		        .build();
		
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
	}

    
    
    
	private static Map<Object, Object> getDataMap(String message) 
	{
		JSONObject jsonObject = new JSONObject(message);
		long id = jsonObject.getLong("id");
		String email = jsonObject.getString("email");
		
		Map<Object, Object> data = new HashMap<>();
		data.put("id", id);
		data.put("email", email);
		return data;
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
        System.out.println(builder.toString());
        return HttpRequest.BodyPublishers.ofString(builder.toString());
    }

	
}
