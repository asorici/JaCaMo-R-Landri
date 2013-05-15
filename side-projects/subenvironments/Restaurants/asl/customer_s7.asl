// Agent master in iterated prisoner's dilemma
{
	include("master_s_generic.asl")
}

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!start : true
	<-	
		.random(Q);
		+biasQuality(Q/5);
		.random(S);
		+biasService(S/5);
		.print("make artifact");
		makeArtifact("ch","CustomerHelper",[],CH).
		
+startTurn(CurrentStep)
	<- .print("Period ",CurrentStep, " has started.");
	    ?biasQuality(Bias_Q);
	    ?biasService(Bias_S);
		.print("quality bias: ",Bias_Q," service bias ",Bias_S);
		decideEat(EAT);
		if(EAT)
		{
		  decideCuisine(Cuisine);
		 .print("I want to eat. I will eat ",Cuisine);
		  //getRestaurant(Cuisine,RR);
		}
		else
		{
		.print("I'm not hungry");
		}.
		
