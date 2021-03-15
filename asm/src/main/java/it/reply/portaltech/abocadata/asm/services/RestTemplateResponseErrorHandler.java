package it.reply.portaltech.abocadata.asm.services;

import java.io.IOException;
import java.nio.charset.Charset;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.ResponseErrorHandler;
import org.springframework.web.client.UnknownHttpStatusCodeException;

import it.reply.portaltech.abocadata.asm.controllers.GiardinoDiPieroController;

@Component
public class RestTemplateResponseErrorHandler implements ResponseErrorHandler {

	@Override
	public boolean hasError(ClientHttpResponse httpResponse) throws IOException {

		try {
			return (httpResponse.getStatusCode().series() == HttpStatus.Series.SERVER_ERROR
					|| httpResponse.getStatusCode().series() == HttpStatus.Series.CLIENT_ERROR);
		} catch (IllegalArgumentException e) {
			//not standard HTTP Status code 
			return true;
		}
	}

	@Override
	public void handleError(ClientHttpResponse httpResponse) throws IOException, RuntimeException {

		try {
			if (httpResponse.getStatusCode().series() == HttpStatus.Series.CLIENT_ERROR) {
				throw new HttpClientErrorException(httpResponse.getStatusCode());
				
			} else if (httpResponse.getStatusCode().series() == HttpStatus.Series.SERVER_ERROR) {
				throw new HttpServerErrorException(httpResponse.getStatusCode());
			}
			
		} catch (IllegalArgumentException e) {
			throw new UnknownHttpStatusCodeException(httpResponse.getRawStatusCode(), httpResponse.getStatusText(),
					httpResponse.getHeaders(),
					httpResponse.getBody() != null ? httpResponse.getBody().toString().getBytes() : null, null);
		}
	}
}