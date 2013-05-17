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

	private double balance = 1000;

	void init(AgentId owner, int cuisine) {
		System.out.println("owner: " + owner);
		// defineObsProperty("count", 0);
		this.owner = owner;
		this.cuisine = cuisine;

		this.price = Math.random() * Restaurants.MAX_PRICE;
		this.service = Math.random() * Restaurants.MAX_SERVICE;
		this.quality = Math.random() * Restaurants.MAX_QUALITY;

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
	public void askPrice(OpFeedbackParam<Double> price) {
		price.set(this.price);
	}

	@OPERATION
	public void serve(OpFeedbackParam<Double> price,
			OpFeedbackParam<Double> service, OpFeedbackParam<Double> quality) {
		System.out.println(getOpUserName() + "eats at restaurant owned by "
				+ owner + " has cuisine" + cuisine);

		double expense = this.service * Restaurants.PRICE_PER_UNIT_SERVICE
				+ this.quality * Restaurants.PRICE_PER_UNIT_QUALITY;
		System.out.println("expense vs price " + expense + "--" + this.price);
		balance -= expense;
		price.set(this.price);
		service.set(this.service);
		quality.set(this.quality);

	}

	@OPERATION
	public void pay(double tip) {
		balance += price;
		balance += tip;
		System.out.println("New balance " + balance);
	}

}
