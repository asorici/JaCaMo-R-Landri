package org.aria.rlandri;
public class RestaurantInfo {

	private double averageRating;
	private int numRatings;
	
	public double getAverageRating() {
		return averageRating;
	}
	public int getNumRatings() {
		return numRatings;
	}
	
	public void addRating(int rating){
		if(rating<0 || rating>5)
			return;
		averageRating=(averageRating*numRatings+rating)/(numRatings+1);
		numRatings++;
	}
	
	
}
