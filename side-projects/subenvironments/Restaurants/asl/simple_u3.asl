{
	include("common_s_generic.asl")
}

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!start : true
	<-	createRestaurant(0).

+rest(R): true
	<- 
	   focus(R);
	   change(1,100,100).
	   
	   
+startTurn(N)
	<-	.print("Signal received for start of Turn ",N).
	
	
+!registration: true
	<-	
		.print("execute this");
		registerAgent(Wsp);
		+wsp_to_join(Wsp).