package org.aria.rlandri;

import java.util.ArrayList;

import cartago.AgentId;
import cartago.Artifact;
import cartago.LINK;
import cartago.OPERATION;
import cartago.OpFeedbackParam;

public class Restaurant extends Artifact {

	private double price = 5;
	private double serviceQuality = 5;
	private double foodQuality = 5;

	protected double getPrice() {
		return this.price;
	}

	protected double getServiceQuality() {
		return this.serviceQuality;
	}

	protected double getFoodQuality() {
		return this.foodQuality;
	}

	protected double getPricePerUnitFoodQuality() {
		return Restaurants.PRICE_PER_UNIT_FOOD_QUALITY;
	}

	protected double getPricePerUnitServiceQuality() {
		return Restaurants.PRICE_PER_UNIT_SERVICE_QUALITY;
	}

	protected double getMaxFoodQuality() {
		return Restaurants.MAX_FOOD_QUALITY;
	}

	protected double getMaxServiceQuality() {
		return Restaurants.MAX_SERVICE_QUALITY;
	}

	protected double getMaxPrice() {
		return Restaurants.MAX_PRICE;
	}

	private AgentId owner;
	private int cuisine;

	private double balance = 1000;

	private int transactionNumber = 0;

	private int currentStep = 0;

	protected ArrayList<ArrayList<Report>> reports = new ArrayList<ArrayList<Report>>();
	{
		// first period is unused so no reports are created
		reports.add(new ArrayList<Report>());
	}

	public String getOwnerName() {
		return owner.getAgentName();
	}

	public int getCuisine() {
		return this.cuisine;
	}

	void init(AgentId owner, int cuisine) {
		System.out.println("owner: " + owner);
		// defineObsProperty("count", 0);
		this.owner = owner;
		this.cuisine = cuisine;

		this.price = Math.random() * Restaurants.MAX_PRICE;
		while (true) {
			this.serviceQuality = Math.random()
					* Restaurants.MAX_SERVICE_QUALITY;
			this.foodQuality = Math.random() * Restaurants.MAX_FOOD_QUALITY;
			double serviceCost = Restaurants.PRICE_PER_UNIT_FOOD_QUALITY
					* foodQuality + Restaurants.PRICE_PER_UNIT_SERVICE_QUALITY
					* serviceQuality;
			double profit = Math.min(Math.random() * price,
					Restaurants.MAX_PRICE - serviceCost);
			if (price >= serviceCost + profit)
				break;

		}

		System.out.println("this restaurant has cuisine " + cuisine);
	}

	@LINK
	private final void getRent(String price, String currentStep) {
		// System.out.println("------" + price + "----" + currentStep);
		double rentPrice = Double.parseDouble(price);
		this.currentStep = Integer.parseInt(currentStep);
		balance -= rentPrice;

		ArrayList<Report> newDay = new ArrayList<Report>();
		reports.add(newDay);

		// System.out.println("paying rent in step " + currentStep + " owner: "
		// + owner);
	}

	@LINK
	private final void getBalance(OpFeedbackParam<Double> balance) {
		System.out.println("Restaurant " + getId().getName()
				+ "Parameters are: " + price + "-" + serviceQuality + "-"
				+ foodQuality);
		balance.set(this.balance);
	}

	@OPERATION
	protected final boolean change(double price, double service, double quality) {
		// if the restaurant is system controlled
		if (owner == null)
			return false;

		if (!getOpUserId().getAgentName().equals(owner.getAgentName())) {
			return false;
		}
		this.price = Helper.regulate(price, 0, Restaurants.MAX_PRICE);
		this.serviceQuality = Helper.regulate(service, 0,
				Restaurants.MAX_SERVICE_QUALITY);
		this.foodQuality = Helper.regulate(quality, 0,
				Restaurants.MAX_FOOD_QUALITY);

		return true;
	}

	// this operation should be extended by user provided restaurant artifact
	// that extends this one
	@OPERATION
	protected void changeBasedOnFeedback() {

	}

	@OPERATION
	private final void askPrice(OpFeedbackParam<Double> price) {
		price.set(this.price);
	}

	@OPERATION
	private final void serve(OpFeedbackParam<Double> price,
			OpFeedbackParam<Double> service_quality,
			OpFeedbackParam<Double> food_quality,
			OpFeedbackParam<Integer> transactionId) {
		// System.out.println(getOpUserName() + "eats at restaurant owned by "
		// + owner + " has cuisine" + cuisine);

		double expense = this.serviceQuality
				* Restaurants.PRICE_PER_UNIT_SERVICE_QUALITY + this.foodQuality
				* Restaurants.PRICE_PER_UNIT_FOOD_QUALITY;
		// System.out.println("expense vs price " + expense + "--" +
		// this.price);
		balance -= expense;
		price.set(this.price);
		service_quality.set(this.serviceQuality);
		food_quality.set(this.foodQuality);

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
	private final void pay(double tip, int transactionId) {
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
	private final void giveFeedback(int rating, int transactionId) {
		Report rep = findReport(transactionId);
		// System.out.println("REPORT!!!2: " + rep+" id: "+transactionId);
		rep.setRating(rating);
		// System.out.println("completed report: " + rep.getRating() + " "
		// + rep.getTip() + " " + rep.getTransactionId() + " "
		// + rep.getAgentId());
	}

}
