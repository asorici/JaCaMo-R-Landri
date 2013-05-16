import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Vector;
import java.util.concurrent.ConcurrentHashMap;

import org.aria.rlandri.generic.artifacts.SimultaneouslyExecutedCoordinator;
import org.aria.rlandri.generic.artifacts.annotation.GAME_OPERATION;
import org.aria.rlandri.generic.artifacts.annotation.MASTER_OPERATION;
import org.aria.rlandri.generic.artifacts.tools.ValidationResult;

import cartago.AgentId;
import cartago.ArtifactConfig;
import cartago.ArtifactId;
import cartago.CartagoException;
import cartago.OPERATION;
import cartago.OpFeedbackParam;
import cartago.OperationException;

public class Restaurants extends SimultaneouslyExecutedCoordinator {

	public enum cuisines {
		FRENCH, ITALIAN, CHINESE, INDIAN, THAI
	};

	public static final int NUM_CUISINE = 5;

	private final List<AgentId> order = new ArrayList<AgentId>();
	private final HashMap<Integer, ArrayList<String>> restaurantTable = new HashMap<Integer, ArrayList<String>>();
	{
		for (int i = 0; i < NUM_CUISINE; i++) {
			restaurantTable.put(i, new ArrayList<String>());
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
			System.out.println("Artifact id: " + id);
			ArrayList<String> al = restaurantTable.get(cuisine);
			al.add(name);
		}
		System.out.println(restaurantTable);
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
		System.out.println("Artifact id: " + id);
		ArrayList<String> al = restaurantTable.get(cuisine);
		al.add(name);
		System.out.println(restaurantTable);
	}

	@OPERATION
	public void getRestaurant(int cuisine, OpFeedbackParam<String> res) {
		System.out.println(getOpUserId() + " wants " + cuisine);
		ArrayList<String> al = restaurantTable.get(cuisine);
		int random = (int) (Math.random() * al.size());
		String name = al.get(random);
		res.set(name);
	}

	@OPERATION
	public void dine(String name) {
		System.out.println("Agent " + getOpUserName() + " wants to eat at "
				+ name);
	}

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
