import cartago.AgentId;
import cartago.Artifact;
import cartago.OPERATION;
import cartago.OpFeedbackParam;

public class Restaurant extends Artifact {

	private double price = 0.5;
	private double service = 0.5;
	private double quality = 0.5;

	private AgentId owner;
	private int cuisine;

	void init(AgentId owner, int cuisine) {
		System.out.println("owner: " + owner);
		// defineObsProperty("count", 0);
		this.owner = owner;
		this.cuisine = cuisine;
		System.out.println("this restaurant has cuisine " + cuisine);
	}

	@OPERATION
	public boolean change(double price, double service, double quality) {
		// if the restaurant is system controlled
		if (owner == null)
			return false;

		if (!getOpUserId().getAgentName().equals(owner.getAgentName())) {
			return false;
		}
		this.price = price;
		this.service = service;
		this.quality = quality;

		// System.out.println("Changed! "+price+" "+service+" "+quality);
		return true;
	}

	@OPERATION
	public void serve() {
		// System.out.println("Serving food at restaurant owned by " + owner
		// + " has cuisine" + cuisine + " client is " + getOpUserName());
	}
}
