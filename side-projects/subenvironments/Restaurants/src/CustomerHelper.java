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

	private double qualityBias;
	private double serviceBias;

	private double satisfactionPoint;

	// between 0 and 10 %
	private double generosity;

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

		eatFrequency = 0.5 + 0.5 * Math.random();

		qualityBias = Math.random() * 0.4;
		serviceBias = Math.random() * 0.4;

		satisfactionPoint = 0.2 + 0.8 * Math.random();
		System.out.println("Satisfaction point: " + satisfactionPoint);

		generosity = ((int) (Math.random() * 15)) / 100.0;
		System.out.println("Generosity: " + generosity);
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
		int i = -1;
		while (sum < rand) {
			sum += tasteVector[++i];
		}
		res = i;
		result.set(res);
	}

	@OPERATION
	public void computeUtility(double price, double service, double quality,
			OpFeedbackParam<Double> ut) {
		double randomS = 2 * (0.5 - Math.random()) * serviceBias;
		double randomQ = 2 * (0.5 - Math.random()) * qualityBias;
		double perceivedService = Helper.regulate((1 + randomS) * service, 0,
				Restaurants.MAX_SERVICE);
		double perceivedQuality = Helper.regulate((1 + randomQ) * quality, 0,
				Restaurants.MAX_QUALITY);
		System.out.println("real vs perceived: " + service + " "
				+ perceivedService);

		double utility = (1 - price) + perceivedService + perceivedQuality;
		utility /= 3;
		ut.set(utility);
	}

	@OPERATION
	public void computeTip(double utility, double price,
			OpFeedbackParam<Double> t) {
		double tip = 0;
		if (utility > satisfactionPoint) {
			tip = price * generosity;
		}
		t.set(tip);
	}
}
