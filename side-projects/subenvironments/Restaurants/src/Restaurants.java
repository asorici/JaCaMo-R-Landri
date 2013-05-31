import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

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
			signal(aid, "collectRent", currentStep);
		}
	}

	@OPERATION
	private void createSystemRestaurants() {
		AgentId aid = getOpUserId();
		System.out.println("CREATING SYSTEM RESTAURANTS " + aid);
		for (int cuisine = 0; cuisine < NUM_CUISINE; cuisine++) {
			ArtifactConfig cf = new ArtifactConfig(aid, cuisine);
			ArtifactId id = null;
			String name = "restaurant" + cuisine;
			try {
				id = makeArtifact(name, "Restaurant", cf);
			} catch (OperationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// System.out.println("Artifact id: " + id);
			ArrayList<ArtifactId> al = restaurantTable.get(cuisine);
			al.add(id);
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
	public void createRestaurant(int cuisine) {
		AgentId aid = getOpUserId();
		ArtifactConfig cf = new ArtifactConfig(aid, cuisine);
		ArtifactId id = null;
		String name = "restaurant" + aid.getAgentName();
		try {
			id = makeArtifact(name, "Restaurant", cf);
		} catch (OperationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		signal(aid, "rest", id);
		// System.out.println("Artifact id: " + id);
		ArrayList<ArtifactId> al = restaurantTable.get(cuisine);
		al.add(id);
		// System.out.println(restaurantTable);
	}

	@OPERATION
	public void getRestaurant(int cuisine, OpFeedbackParam<ArtifactId> res) {
		// System.out.println(getOpUserId() + " wants " + cuisine);
		ArrayList<ArtifactId> al = restaurantTable.get(cuisine);
		int random = (int) (Math.random() * al.size());
		ArtifactId name = al.get(random);
		res.set(name);
	}

	@OPERATION
	public void makeRestaurantsPayRent() throws OperationException {
		Set<Integer> keys = restaurantTable.keySet();
		for (Integer key : keys) {
			ArrayList<ArtifactId> restaurants = restaurantTable.get(key);
			for (ArtifactId restaurant : restaurants) {
				execLinkedOp(restaurant, "payRent",""+RENT_PRICE,""+currentStep);
			}
		}
		setPreEvaluationDone(true);
		// System.out.println("make them pay!");
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
