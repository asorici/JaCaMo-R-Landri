// Agent master in iterated prisoner's dilemma
{
	include("master_s_generic.asl")
}

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!start : true
	<-	true.

+stopTurn(CurrentStep)
	<- .print("Turn ",CurrentStep, " has ended.").

+canEvaluate(CurrentStep)
	<-	evaluateActions.