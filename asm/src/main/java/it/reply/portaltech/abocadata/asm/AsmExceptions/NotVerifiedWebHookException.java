package it.reply.portaltech.abocadata.asm.AsmExceptions;

public class NotVerifiedWebHookException extends Exception {
	public NotVerifiedWebHookException(String error) {
		super(error);
	}
}
