// Agent master in iterated prisoner's dilemma
{
	include("master_s_generic.asl")
}

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!start : true
	<-	
		// establish if this agent will be a feedback giver
		.random(F);
		if(F<0.8)
		{
			+feedback(true);
		}
		else
		{
			+feedback(false);
		}
		?feedback(ANS);
		.print("gives feedback: ",ANS);
		
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


		decideEat(EAT);
		if(EAT)
		{
		  decideCuisine(C);
		 .print("I want to eat. I will eat ",C);
		  getRestaurant(C,Res);
		  serve(Price,Service,Quality)[artifact_id(Res)];
		  .print("Params: ",Price,Service,Quality);
		  computeUtility(Price,Service,Quality,Utility);
		  computeTip(Utility,Price,Tip);
		  .print("tip is ",Tip," for price ",Price);
		  pay(Tip)[artifact_id(Res)];
		}
		else
		{
		.print("I'm not hungry");
		}.
		
