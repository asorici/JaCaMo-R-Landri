import cartago.Artifact;
import cartago.OPERATION;
import cartago.OpFeedbackParam;

/*
 * 
 * This is a helper artifact used by a customer agent
 */
public class CustomerHelper extends Artifact {

	// each element indicates how much an agent likes the corresponding cuisine
	private double tasteVector[];
	private double eatFrequency;

	void init() {
		// assigns random values to taste vector
		tasteVector = new double[Restaurants.NUM_CUISINE];
		for (int i = 0; i < Restaurants.NUM_CUISINE; i++) {
			tasteVector[i] = Math.random();
		}
		// normalize taste vector
		double sum = 0;
		for (int i = 0; i < Restaurants.NUM_CUISINE; i++) {
			sum += tasteVector[i];
		}
		for (int i = 0; i < Restaurants.NUM_CUISINE; i++) {
			tasteVector[i] /= sum;
		}

		for (int i = 0; i < Restaurants.NUM_CUISINE; i++) {
			System.out.print(tasteVector[i] + " ");
		}
		System.out.println("ARTIFACT MADE");

		eatFrequency = 0.5 + 0.5 * Math.random();
	}

	@OPERATION
	public void decideEat(OpFeedbackParam<Boolean> b) {
		double r = Math.random();
		if (r < eatFrequency)
			b.set(true);
		else
			b.set(false);
	}

	@OPERATION
	public void decideCuisine(OpFeedbackParam<Integer> result) {
		int res = -1;
		double rand = Math.random();
		double sum = 0;
		int i = 0;
		while (sum < rand) {
			sum += tasteVector[i++];
		}
		res = i;
		result.set(res);
	}

}
