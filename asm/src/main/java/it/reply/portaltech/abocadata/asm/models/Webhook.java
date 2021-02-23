package it.reply.portaltech.abocadata.asm.models;

import javax.persistence.*;

@Entity
public class Webhook {
	
	@Id
	private long id;
	
	@JoinColumn(name = "X-Shopify-Hmac-SHA256")
	private String email;
	private String financial_status;
	
	public Webhook()	{	}
	
	public Webhook(long _id, String _email, String _financial_status)
	{
		this.setId(_id);
		this.email = _email;
		this.setFinancial_status(_financial_status);
	}
	
	public long getId() {
		return id;
	}

	public void setId(long _id) {
		this.id = _id;
	}

	public String getFinancial_status() {
		return financial_status;
	}

	public void setFinancial_status(String financial_status) {
		this.financial_status = financial_status;
	}

}
