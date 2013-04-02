{
	include("common_s_generic.asl")
}

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!start : true
	<-	true.


@decideStrategyPlan[atomic]
+!decideStrategy
 <-    
       .random(N);
       if(N > 0.5)
		{
			action("cooperate");
		}
	   else
	   {
	    	action("defect");
	   }.
	   
 
	   

+startTurn(N)
	<-	.print("Signal received for start of Turn ",N);
		!decideStrategy.
		

+result(N,R)
    <- .print("Result in turn ",N," is ",R).		