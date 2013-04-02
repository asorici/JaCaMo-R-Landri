import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.aria.rlandri.generic.artifacts.SimultaneouslyExecutedCoordinator;
import org.aria.rlandri.generic.artifacts.annotation.GAME_OPERATION;
import org.aria.rlandri.generic.artifacts.annotation.MASTER_OPERATION;
import org.aria.rlandri.generic.artifacts.tools.ValidationResult;

import cartago.AgentId;
import cartago.OPERATION;
import cartago.OpFeedbackParam;

public class IteratedPrisonerDilemma extends SimultaneouslyExecutedCoordinator {

	public static final String DEFECT = "defect";
	public static final String COOPERATE = "cooperate";

	public static final int A = 3; // outcome if both players cooperate
	public static final int B = 0; // outcome for the defecting player if the
									// other cooperates
	public static final int C = 5; // outcome for the cooperating player if the
									// other defects
	public static final int D = 1; // outcome if both players defect

	private final Map<AgentId, Integer> standings = new HashMap<AgentId, Integer>();
	String actions[] = new String[2]; // 2 = number of agents
	private final List<AgentId> order = new ArrayList<AgentId>();

	@GAME_OPERATION(validator = "validateAction")
	void action(String action) {
		AgentId aid = getOpUserId();
		System.out.println(aid + action + "s");
		int ord = order.indexOf(aid);
		actions[ord] = action;
	}

	ValidationResult validateAction(String action) {
		AgentId aid = getOpUserId();
		ValidationResult vr = new ValidationResult(aid.getAgentName());

		if (!action.equals(DEFECT) && !action.equals(COOPERATE))
			vr.addReason("unknown_action");

		return vr;

	}

	private void updateStandings(AgentId aid, int value) {
		if (standings.containsKey(aid)) {
			int oldValue = standings.get(aid);
			standings.put(aid, oldValue + value);
		} else {
			standings.put(aid, value);
		}
	}

	@OPERATION
	protected void registerAgent(OpFeedbackParam<String> wsp) {
		super.registerAgent(wsp);
		standings.put(getOpUserId(), 0);
		order.add(getOpUserId());
		wsp.set("NA");
	}

	@Override
	protected void doPostEvaluation() {
		for (AgentId aid : masterAgents.getAgentIds()) {
			signal(aid, "canEvaluate", currentStep);
		}
	}

	@MASTER_OPERATION(validator = "validateEvaluateActions")
	void evaluateActions() {

		String firstAgentResult = "";
		String secondAgentResult = "";

		AgentId firstAid = order.get(0);
		AgentId secondAid = order.get(1);
		String first = actions[0];
		String second = actions[1];
		if (first.equals(second)) {
			if (first.equals(DEFECT)) {
				updateStandings(firstAid, D);
				updateStandings(secondAid, D);
				firstAgentResult = secondAgentResult = "D";
			} else {
				updateStandings(firstAid, A);
				updateStandings(secondAid, A);
				firstAgentResult = secondAgentResult = "C";
			}
		} else {
			if (first.equals(DEFECT)) {
				updateStandings(firstAid, C);
				updateStandings(secondAid, B);
				firstAgentResult = "T";
				secondAgentResult = "S";
			} else {
				updateStandings(firstAid, B);
				updateStandings(secondAid, C);
				firstAgentResult = "S";
				secondAgentResult = "T";
			}
		}
		signal(firstAid, "result", currentStep, firstAgentResult);
		signal(secondAid, "result", currentStep, secondAgentResult);
		System.out
				.println(firstAid + " score after " + currentStep
						+ " turns is " + (double) standings.get(firstAid)
						/ currentStep);
		System.out.println(secondAid + " score after " + currentStep
				+ " turns is " + (double) standings.get(secondAid)
				/ currentStep);
		setPostEvaluationDone(true);
	}

	void validateEvaluateActions() {

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
