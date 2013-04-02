{
	include("common_s_generic.asl")
}

/* Initial beliefs and rules */
lastResult("C").
/* Initial goals */

/* Plans */

+!start : true
	<-	true.


@decideStrategyPlan[atomic]
+!decideStrategy
 <-    
       ?lastResult(R);
       if(R == "C" | R == "T")
       {
	   		action("cooperate");
	   }
	   if(R == "D" | R == "S")
       {
       		action("defect");
	   }.
	   	
	   
 
	   

+startTurn(N)
	<-	.print("Signal received for start of Turn ",N);
		!decideStrategy.
		

+result(N,R)
    <- .print("Result in turn ",N," is ",R);
       -+lastResult(R).