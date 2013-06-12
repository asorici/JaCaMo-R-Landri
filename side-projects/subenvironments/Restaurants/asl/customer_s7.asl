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
		
		.random(MaxPrice);
		+myMaxPrice(40+MaxPrice*80);
		
		//create custom name for CustomerHelper artifact
		.my_name(Name);
		.concat("ch",Name,CHName);
		makeArtifact(CHName,"org.aria.rlandri.CustomerHelper",[],CH).


/* Skipping first turn so that the helper artifact can be built before */
+startTurn(1) : true
	<- true.

@eatPlan[atomic]
+!eatPlan(Cuisine) : true
  <- 
	  getRestaurants(Cuisine,Restaurants);
	  decideRestaurant(Restaurants,Res,Name);
	  askPrice(Pr)[artifact_id(Res)];
	  ?myMaxPrice(MaxPrice);
	  if(Pr>MaxPrice)
	  {
	    .print("MAX PRICE ",MaxPrice);
	    //!eatPlan(Cuisine);
	  }
	  else
	  {
	  	  serve(Price,Service,Quality,TransactionId)[artifact_id(Res)];
	  	  .print("Params: ",Price,Service,Quality);
	  	  computeUtility(Price,Service,Quality,Utility);
		  .print("Utility is: ",Utility);
		  computeTip(Utility,Price,Tip);
		  .print("tip is ",Tip," for price ",Price);
		  pay(Tip,TransactionId)[artifact_id(Res)];
		  computeFeedback(Utility,Stars);
		  storeRating(Res,Stars);
		  ?feedback(FB);
		  .print("Feedback: ",FB);
		  if(FB==true)
		  {
		  	giveFeedback(Stars,TransactionId)[artifact_id(Res)];
		  	.print("I'm giving ",Stars," number of stars to ",Name);
		   };
	   }.
		

@decideEatPlan[atomic]
+!decideEatPlan
    <- 
    decideEat(EAT);
		if(EAT)
		{
		  decideCuisine(C);
		 .print("I want to eat. I will eat ",C);
		 !eatPlan(C);
		}
		else
		{
		.print("I'm not hungry");
		}.
		
@turn[atomic]		
+startTurn(CurrentStep)
	<- .print("Period ",CurrentStep, " has started.");
		!decideEatPlan.
		
