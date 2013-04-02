{
	include("common_s_generic.asl")
}

/* Initial beliefs and rules */
lastResult("D").
/* Initial goals */

/* Plans */

+!start : true
	<-	true.


@decideStrategyPlan[atomic]
+!decideStrategy
 <-    
       ?lastResult(R);
       .random(N);
       if(R == "C")
       {
       		if(N < 2/3)
			{
				action("cooperate");
			}
	   		else
	   		{
	    		action("defect");
	   		}
	   	}
	   	if(R == "D")
       	{
       		if(N < 1/3)
			{
				action("cooperate");
			}
	   		else
	   		{
	    		action("defect");
	   		}
	   	}
	   	if(R == "T")
       	{
       		if(N < 2/3)
			{
				action("cooperate");
			}
	   		else
	   		{
	    		action("defect");
	   		}
	   	}
	   	if(R == "S")
       	{
	    	action("defect");
	   	}.
	   
 
	   

+startTurn(N)
	<-	.print("Signal received for start of Turn ",N);
		!decideStrategy.
		

+result(N,R)
    <- .print("Result in turn ",N," is ",R);
       -+lastResult(R).