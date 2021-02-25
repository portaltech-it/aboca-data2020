package it.reply.portaltech.abocadata.asm.util;

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

    public static void sendOrderToCreate(String message) throws Exception 
    {		
		JSONObject jsonObject = new JSONObject(message);
		long id = jsonObject.getLong("id");
		String email = jsonObject.getString("email");
		
		Map<Object, Object> data = new HashMap<>();
		data.put("id", id);
		data.put("email", email);
		
		HttpRequest request = HttpRequest.newBuilder()
		        .POST(buildFormDataFromMap(data))
		        .uri(URI.create("http://localhost:3030/orders"))
		        .setHeader("User-Agent", "Java 11 HttpClient Bot") // add request header
		        .header("Content-Type", "application/json")
		        .build();
		
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
		
		// print status code
		System.out.println("STATUS CODE = " + response.statusCode());
		
		// print response body
		System.out.println("RESPONSE BODY = " + response.body());
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
