package it.reply.portaltech.abocadata.asm.customExceptions;

public class NotVerifiedWebHookException extends Exception 
{
    public NotVerifiedWebHookException(String error) {
        super(error);
    }
}
