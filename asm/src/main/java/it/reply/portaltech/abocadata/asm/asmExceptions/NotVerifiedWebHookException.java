package it.reply.portaltech.abocadata.asm.asmExceptions;

public class NotVerifiedWebHookException extends Exception {
	public NotVerifiedWebHookException(String error) {
		super(error);
	}
}
