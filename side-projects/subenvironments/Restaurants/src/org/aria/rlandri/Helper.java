package org.aria.rlandri;
public class Helper {

	public static double regulate(double value, double min, double max) {
		if (value < min)
			return min;
		if (value > max)
			return max;
		return value;
	}

}
