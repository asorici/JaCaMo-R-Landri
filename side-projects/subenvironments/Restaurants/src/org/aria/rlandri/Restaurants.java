package org.aria.rlandri;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.aria.rlandri.generic.artifacts.SimultaneouslyExecutedCoordinator;

import cartago.AgentId;
import cartago.ArtifactConfig;
import cartago.ArtifactId;
import cartago.OPERATION;
import cartago.OpFeedbackParam;
import cartago.OperationException;

public class Restaurants extends SimultaneouslyExecutedCoordinator {

	public enum cuisines {
		FRENCH, ITALIAN, CHINESE, INDIAN, THAI
	};

	public static final int NUM_CUISINE = 5;

	public static final double PRICE_PER_UNIT_SERVICE = 0.2;
	public static final double PRICE_PER_UNIT_QUALITY = 0.2;
	public static final double RENT_PRICE = 100;
	public static final double MAX_PRICE = 100;
	public static final double MAX_SERVICE = 100;
	public static final double MAX_QUALITY = 100;

	private final List<AgentId> order = new ArrayList<AgentId>();
	private final HashMap<Integer, ArrayList<ArtifactId>> restaurantTable = new HashMap<Integer, ArrayList<ArtifactId>>();
	{
		for (int i = 0; i < NUM_CUISINE; i++) {
			restaurantTable.put(i, new ArrayList<ArtifactId>());
		}
	}

	@Override
	protected void doPreEvaluation() {
		for (AgentId aid : masterAgents.getAgentIds()) {
			signal(aid, "beforePeriod", currentStep);
		}
	}

	@Override
	protected void doPostEvaluation() {
		for (AgentId aid : masterAgents.getAgentIds()) {
			signal(aid, "afterPeriod", currentStep);
		}
	}

	@OPERATION
	private void createSystemRestaurants() {
		AgentId aid = getOpUserId();
		System.out.println("CREATING SYSTEM RESTAURANTS " + aid);
		for (int cuisine = 0; cuisine < NUM_CUISINE; cuisine++) {
			for (int index = 0; index < 2; index++) {
				// if(cuisine==3) continue;
				ArtifactConfig cf = new ArtifactConfig(aid, cuisine);
				ArtifactId id = null;
				String name = "restaurant" + cuisine + "-" + index;
				try {
					id = makeArtifact(name, "org.aria.rlandri.Restaurant",
							cf);
				} catch (OperationException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				// System.out.println("Artifact id: " + id);
				ArrayList<ArtifactId> al = restaurantTable.get(cuisine);
				al.add(id);
			}
		}
		// System.out.println(restaurantTable);
	}

	@OPERATION
	protected void registerAgent(OpFeedbackParam<String> wsp) {
		AgentId aid = getOpUserId();
		System.out.println("registering agent " + aid);
		super.registerAgent(wsp);
		order.add(aid);
		wsp.set("NA");
	}

	@OPERATION
	public void createRestaurant(int userID, int cuisine) {
		
		System.out.println("HERE!");
		
		AgentId aid = getOpUserId();
		ArtifactConfig cf = new ArtifactConfig(aid, cuisine);
		ArtifactId id = null;
		String name = "restaurant" + aid.getAgentName();
		// String[] s = aid.getAgentName().split("[agent|_]");

		Pattern p = Pattern.compile("[0-9]*");
		Matcher m = p.matcher(aid.getAgentName());
		String agNr = "";
		while (m.find()) {
			agNr = m.group();
			if (!agNr.isEmpty())
				break;
		}
		// get
		String className = "org.aria.rlandri.user" + userID + ".Restaurant"
				+ agNr;
		// System.out.println("~~~~~~~~~"+className);
		try {
			id = makeArtifact(name, className, cf);
		} catch (OperationException e) {
			System.out.println("EPIC FAIL");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		signal(aid, "rest", id);
		// System.out.println("Artifact id: " + id);
		ArrayList<ArtifactId> al = restaurantTable.get(cuisine);
		al.add(id);
		// System.out.println(restaurantTable);
	}

	/*
	 * @OPERATION public void getRestaurant(int cuisine,
	 * OpFeedbackParam<ArtifactId> res) { // System.out.println(getOpUserId() +
	 * " wants " + cuisine); ArrayList<ArtifactId> al =
	 * restaurantTable.get(cuisine); int random = (int) (Math.random() *
	 * al.size()); ArtifactId name = al.get(random); res.set(name); }
	 */

	@OPERATION
	public void getRestaurants(int cuisine,
			OpFeedbackParam<ArrayList<ArtifactId>> list) {
		ArrayList<ArtifactId> al = restaurantTable.get(cuisine);
		list.set(al);
	}

	@OPERATION
	public void makeRestaurantsPayRent() throws OperationException {
		Set<Integer> keys = restaurantTable.keySet();
		for (Integer key : keys) {
			ArrayList<ArtifactId> restaurants = restaurantTable.get(key);
			for (ArtifactId restaurant : restaurants) {
				execLinkedOp(restaurant, "payRent", "" + RENT_PRICE, ""
						+ currentStep);
			}
		}
		setPreEvaluationDone(true);
		// System.out.println("make them pay!");
	}

	@OPERATION
	public void getBalanceFromRestaurants() throws OperationException {
		Set<Integer> keys = restaurantTable.keySet();
		for (Integer key : keys) {
			ArrayList<ArtifactId> restaurants = restaurantTable.get(key);
			for (ArtifactId restaurant : restaurants) {
				// Double d = new Double(0);
				OpFeedbackParam<Double> d = new OpFeedbackParam<Double>();
				execLinkedOp(restaurant, "getBalance", d);
				double val = d.get();
				System.out.println("Balance for restaurant "
						+ restaurant.getName() + " is: " + val);
				// System.out.println("Value: "+d);
			}
		}
		setPostEvaluationDone(true);
	}

	/*
	 * @OPERATION public void dine(String name) { System.out.println("Agent " +
	 * getOpUserName() + " wants to eat at " + name); }
	 */

	@Override
	protected void saveState() {

		// TODO Auto-generated method stub

	}

	@Override
	protected void updateCurrency() {
		// TODO Auto-generated method stub

	}

	@Override
	protected void updateRank() {
		// TODO Auto-generated method stub

	}

}
