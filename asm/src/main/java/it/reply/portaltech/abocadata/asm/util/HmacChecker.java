package it.reply.portaltech.abocadata.asm.util;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

public class HmacChecker
{
	private String SECRET;
	private String HMAC_ALGORITHM;
	private String calculated;
	
	public HmacChecker(String secret)
	{
		this.SECRET = secret;
		this.HMAC_ALGORITHM = "HmacSHA256";
	}
	 

    public Boolean verifyWebhook(String headerHmac, String message) throws Exception
    {
    	//computing hash
    	byte[] hmac_hashed = hash_hmac(this.SECRET.getBytes("UTF-8"), message.getBytes("UTF-8"));
    	
    	//encoding
        this.calculated = Base64.encodeBase64String(hmac_hashed);
        
        //comparing
        return headerHmac.equals(calculated); 	
    }
    
    private byte[] hash_hmac(byte[] secretKey, byte[] message) throws NoSuchAlgorithmException, InvalidKeyException 
    {
    	byte[] hmacSha256 = null;

    	Mac mac = Mac.getInstance(this.HMAC_ALGORITHM);
	    SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey, this.HMAC_ALGORITHM);
	    mac.init(secretKeySpec);
	    hmacSha256 = mac.doFinal(message);
        
        return hmacSha256;
    }
}
