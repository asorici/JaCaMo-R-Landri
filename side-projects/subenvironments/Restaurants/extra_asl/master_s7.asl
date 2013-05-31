// Agent master in iterated prisoner's dilemma
{
	include("master_s_generic.asl")
}

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!start : true
	<-	createSystemRestaurants.


/* Skipping first turn so that the helper artifact can be built before */
+startTurn(1) : true
	<- true.

+collectRent(CurrentStep)
	<- makeRestaurantsPayRent.
		
