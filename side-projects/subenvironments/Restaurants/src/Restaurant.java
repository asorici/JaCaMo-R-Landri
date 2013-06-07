import cartago.AgentId;
import cartago.Artifact;
import cartago.LINK;
import cartago.OPERATION;
import cartago.OpFeedbackParam;
import java.util.ArrayList;
import java.util.HashMap;

public class Restaurant extends Artifact {

	private double price = 0.5;
	private double service = 0.5;
	private double quality = 0.5;

	private AgentId owner;
	private int cuisine;

	private double balance = 1000;

	private int transactionNumber = 0;

	private int currentStep = 0;

	private ArrayList<ArrayList<Report>> reports = new ArrayList<ArrayList<Report>>();
	{
		// first one will be unused
		reports.add(new ArrayList<Report>());
	}

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

	@LINK
	void payRent(String price, String currentStep) {
		System.out.println("------" + price + "----" + currentStep);
		double rentPrice = Double.parseDouble(price);
		this.currentStep = Integer.parseInt(currentStep);
		balance -= rentPrice;

		ArrayList<Report> newDay = new ArrayList<Report>();
		reports.add(newDay);

		System.out.println("paying rent in step " + currentStep + " owner: "
				+ owner);
	}

	@LINK
	void getBalance(OpFeedbackParam<Double> balance) {
		System.out.println("Restaurant " + getId().getName()
				+ "Parameters are: " + price + "-" + service + "-" + quality);
		balance.set(this.balance);
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

		return true;
	}

	@OPERATION
	public void askPrice(OpFeedbackParam<Double> price) {
		price.set(this.price);
	}

	@OPERATION
	public void serve(OpFeedbackParam<Double> price,
			OpFeedbackParam<Double> service, OpFeedbackParam<Double> quality,
			OpFeedbackParam<Integer> transactionId) {
		System.out.println(getOpUserName() + "eats at restaurant owned by "
				+ owner + " has cuisine" + cuisine);

		double expense = this.service * Restaurants.PRICE_PER_UNIT_SERVICE
				+ this.quality * Restaurants.PRICE_PER_UNIT_QUALITY;
		System.out.println("expense vs price " + expense + "--" + this.price);
		balance -= expense;
		price.set(this.price);
		service.set(this.service);
		quality.set(this.quality);

		AgentId id = getOpUserId();
		Report newReport = new Report();
		newReport.setTransactionId(transactionNumber);
		newReport.setAgentId(id);
		reports.get(currentStep).add(newReport);

		transactionId.set(transactionNumber++);

	}

	private Report findReport(int id) {
		Report rep = null;
		// ArrayList<Report> reps = reports.get(step);
		for (ArrayList<Report> reps : reports)
			for (Report r : reps) {
				// System.out.println(r.getTransactionId() + " vs " + id);
				if (r.getTransactionId() == id) {
					rep = r;
					break;
				}
			}
		return rep;
	}

	@OPERATION
	public void pay(double tip, int transactionId) {
		balance += price;
		balance += tip;
		// System.out.println("New balance " + balance);
		Report rep = findReport(transactionId);
		// System.out.println(reports);
		// System.out.println("tip and id" + tip + " + " + transactionId);
		// System.out.println("REPORT!!!1: " + rep+" id:"+transactionId);
		rep.setTip(tip);
	}

	@OPERATION
	public void giveFeedback(int rating, int transactionId) {
		Report rep = findReport(transactionId);
		// System.out.println("REPORT!!!2: " + rep+" id: "+transactionId);
		rep.setRating(rating);
		System.out.println("completed report: " + rep.getRating() + " "
				+ rep.getTip() + " " + rep.getTransactionId() + " "
				+ rep.getAgentId());
	}

}
