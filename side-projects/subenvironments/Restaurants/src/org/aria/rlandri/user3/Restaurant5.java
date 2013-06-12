package org.aria.rlandri.user3;
import org.aria.rlandri.Restaurant;

import cartago.OPERATION;

public class Restaurant5 extends Restaurant {

	@OPERATION
	protected void changeBasedOnFeedback() {
		System.out.println("HELLO SUBCLASS");
	}
}
