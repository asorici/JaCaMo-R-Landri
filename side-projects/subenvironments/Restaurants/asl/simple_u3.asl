{
	include("common_s_generic.asl")
}

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!start : true
	<-	
	  createRestaurant(3,3).

+rest(R): true
	<- 
	   focus(R);
	   //change(70,100,100).
	   change(63,47,41).
	   

//skip first turn
+startTurn(1): true
   <- true.
	   
+startTurn(N)
	<-	//getReportsInPeriod(N-1,Reports);
	  .print("Signal received for start of Turn ",N);
	  changeBasedOnFeedback.
	
	
+!registration: true
	<-	
		.print("execute this");
		registerAgent(Wsp);
		+wsp_to_join(Wsp).