(define (domain secrets)

   (:types agent secret)

   (:predicates 
        (connected ?agent1 ?agent2 - agent  ;if agent1 can connect to agent2, not necessary that agent2 can connect with agent1)
        (knows ?agent - agent ?secret - secret   ; if agent knows the secret)
   )
   
   (:action tell
        :parameters (?teller ?receiver - agent ?secret - secret)
        :precondition (and (knows ?teller ?secret) (connected ?teller ?receiver))
        :effect (knows ?receiver ?secret)
   
   )
   

)
