package it.reply.portaltech.abocadata.asm.util;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

public class HmacChecker
{
	public String secret;
	public String HMAC_ALGORITHM;
	public String calculated;
	
	public HmacChecker(String _secret)
	{
		this.secret = _secret;
		this.HMAC_ALGORITHM = "HmacSHA256";
	}
	
	public String calculateHmac(String message) throws NoSuchAlgorithmException, InvalidKeyException {
        Mac hmac = Mac.getInstance(this.HMAC_ALGORITHM);
        SecretKeySpec key = new SecretKeySpec(this.secret.getBytes(), this.HMAC_ALGORITHM);
        hmac.init(key);
         
        this.calculated = Base64.encodeBase64String(hmac.doFinal(message.getBytes()));
        return this.calculated;
    }


    public boolean checkHmac(String message, String hmac) throws InvalidKeyException, NoSuchAlgorithmException {
        return hmac.equals(calculateHmac(message));
        
    }
    
    

}
