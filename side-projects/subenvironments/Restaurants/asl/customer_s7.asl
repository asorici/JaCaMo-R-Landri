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
		
		//create custom name for CustomerHelper artifact
		.my_name(Name);
		.concat("ch",Name,CHName);
		.print("NAME IS ",CHName);
		makeArtifact(CHName,"CustomerHelper",[],CH).


/* Skipping first turn so that the helper artifact can be built before */
+startTurn(1) : true
	<- true.
		
+startTurn(CurrentStep)
	<- .print("Period ",CurrentStep, " has started.");
	    ?biasQuality(Bias_Q);
	    ?biasService(Bias_S);
		.print("quality bias: ",Bias_Q," service bias ",Bias_S);
		decideEat(EAT);
		if(EAT)
		{
		  decideCuisine(C);
		 .print("I want to eat. I will eat ",C);
		  getRestaurant(C,Res);
		  .print("I'm eating at restaurant ",Res);
		}
		else
		{
		.print("I'm not hungry");
		}.
		
