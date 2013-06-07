import cartago.AgentId;

public class Report {

	private int transactionId;
	private AgentId agentId;
	private double tip;
	private int rating;

	public int getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(int transactionI) {
		this.transactionId = transactionI;
	}

	public AgentId getAgentId() {
		return agentId;
	}

	public void setAgentId(AgentId agentId) {
		this.agentId = agentId;
	}

	public double getTip() {
		return tip;
	}

	public void setTip(double tip) {
		this.tip = tip;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

}
