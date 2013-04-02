{
	include("common_s_generic.asl")
}

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!start : true
	<-	true.


+startTurn(N)
	<-	.print("Signal received for start of Turn ",N);
		action("cooperate").