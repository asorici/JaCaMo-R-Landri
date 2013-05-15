import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import org.aria.rlandri.generic.artifacts.SimultaneouslyExecutedCoordinator;
import org.aria.rlandri.generic.artifacts.annotation.GAME_OPERATION;
import org.aria.rlandri.generic.artifacts.annotation.MASTER_OPERATION;
import org.aria.rlandri.generic.artifacts.tools.ValidationResult;

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

	private final List<AgentId> order = new ArrayList<AgentId>();
	private final Vector<ArrayList<ArtifactId>> restaurantTable = new Vector<ArrayList<ArtifactId>>();
	{
		for (int i = 0; i < NUM_CUISINE; i++) {
			restaurantTable.add(new ArrayList<ArtifactId>());
		}
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
		ArrayList<ArtifactId> al = restaurantTable.get(cuisine);
		al.add(id);
	}

	@OPERATION
	public void getRestaurant(int cuisine, OpFeedbackParam<Object[]> res) {
		System.out.println(getOpUserId() + " wants " + cuisine);
		ArrayList<ArtifactId> al = restaurantTable.get(cuisine);
		res.set(al.toArray());
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
