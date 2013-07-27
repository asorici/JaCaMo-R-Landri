package org.aria.rlandri.user3;

import java.util.ArrayList;

import org.aria.rlandri.Report;
import org.aria.rlandri.Restaurant;
import org.aria.rlandri.Restaurants;

import cartago.OPERATION;

public class Restaurant5 extends Restaurant {

	private int currentPeriod = 0;

	private int negativeFeedbackCount = 0;

	// private int allTime = 0;

	private void decideChange() {
		double deltaServiceQuality = Math.random() * 10;
		double newServiceQuality = getServiceQuality() + deltaServiceQuality;
		newServiceQuality = Math.min(newServiceQuality, getMaxServiceQuality());
		double deltaFoodQuality = Math.random() * 10;
		double newFoodQuality = getFoodQuality() + deltaFoodQuality;
		newFoodQuality = Math.min(newFoodQuality, getMaxFoodQuality());
		double newPrice = getPrice() + deltaServiceQuality
				* getPricePerUnitServiceQuality() + deltaFoodQuality
				* getPricePerUnitFoodQuality();
		newPrice = Math.min(newPrice, getMaxPrice());
		// double serviceCost = getPricePerUnitFoodQuality() * newFoodQuality
		// + getPricePerUnitServiceQuality() * newServiceQuality;
		// if (newPrice < serviceCost) {
		//
		// newPrice = Math
		// .min(serviceCost + Math.random() * 20, getMaxPrice());
		// }

		change(newPrice, newServiceQuality, newFoodQuality);
	}

	private double sumRating = 0;
	private int numRating = 0;
	
	@OPERATION
	protected void changeBasedOnFeedback() {
		// System.out.println("HELLO SUBCLASS");
		
		for (int i = currentPeriod; i < reports.size() - 1; i++) {
			ArrayList<Report> reps = reports.get(i);
			for (int j = 0; j < reps.size(); j++) {
				Report rep = reps.get(j);
				int rating = rep.getRating();
				if (rating > 0) {
					if (rating <= 2) {
						negativeFeedbackCount++;
					}
					//System.out.println("rating: " + rep.getRating());
					if (rating > 0)
						sumRating += rep.getRating();
					numRating += 1;
				} else {
				//	System.out.println("zero rating");
				}
			}
		}
	//	System.out.println("sum and num" + sumRating + "--" + numRating);
		//if (numRating > 0)
			System.out.println("AVERAGE all time RATING: " + sumRating / numRating);

		if (negativeFeedbackCount >= 20) {
			System.out.println("NEGATIVE FEEDBACK COUNT: "
					+ negativeFeedbackCount + " owned by" + getOwnerName());
			decideChange();
			negativeFeedbackCount = 0;
		}
		currentPeriod = reports.size() - 1;

		// System.out.println("ALL TIME: "+allTime);

	}
}
