(define (domain secrets)

   (:types agent secret)

   (:predicates 
        (connected ?agent1 ?agent2 - agent)  ; if agent1 can connect to agent2
        (knows ?agent - agent ?secret - secret)   ; if agent knows secret
        (deceptive ?agent - agent)  ; if agent is deceptive
        (true_belief ?agent - agent ?secret - secret)   ; if agent believes that secret is true
        (false_belief ?agent - agent ?secret - secret)  ; if agent believes that secret is false
   )
   
   (:action tell
        :parameters (?teller ?receiver - agent ?secret - secret)
        :precondition (and (knows ?teller ?secret) (connected ?teller ?receiver))
        :effect 
            (knows ?receiver ?secret)
   )
   
   (:action share_belief
        :parameters (?teller ?receiver - agent ?secret - secret)
        :precondition (and (or (true_belief ?teller ?secret) (false_belief ?teller ?secret)) (connected ?teller ?receiver))
        :effect 
            (and
                ; when deceptive teller has a secret that he believes is false and receiver also believes that secret is false, receiver then believes that secret is true
                (when (and (deceptive ?teller) (false_belief ?teller ?secret) (false_belief ?receiver ?secret))
                    (and (not (false_belief ?receiver ?secret)) (true_belief ?receiver ?secret))
                )
                ; when deceptive teller has a secret that he believes is false and receiver has no belief of that secret, receiver then believes that secret is true
                (when (and (deceptive ?teller) (false_belief ?teller ?secret) (not (true_belief ?receiver ?secret)) (not (false_belief ?receiver ?secret)))
                    (and (true_belief ?receiver ?secret))
                )
                ; when deceptive teller has a secret that he believes is true and receiver also believes that secret is true, receiver then believes that secret is false
                (when (and (deceptive ?teller) (true_belief ?teller ?secret) (true_belief ?receiver ?secret))
                    (and (not (true_belief ?receiver ?secret)) (false_belief ?receiver ?secret))
                )
                ; when deceptive teller has a secret that he believes is true and receiver has no belief of that secret, receiver then believes that secret is false
                (when (and (deceptive ?teller) (true_belief ?teller ?secret) (not (true_belief ?receiver ?secret)) (not (false_belief ?receiver ?secret)))
                    (and (false_belief ?receiver ?secret))
                )
                    
                ; when honest teller has a secret that he believes is false and receiver believes that secret is true, receiver then believes that secret is false
                (when (and (not (deceptive ?teller)) (false_belief ?teller ?secret) (true_belief ?receiver ?secret))
                    (and (not (true_belief ?receiver ?secret)) (false_belief ?receiver ?secret))
                )
                ; when honest teller has a secret that he believes is false and receiver has no belief of that secret, receiver then believes that secret is false
                (when (and (not (deceptive ?teller)) (false_belief ?teller ?secret) (not (true_belief ?receiver ?secret)) (not (false_belief ?receiver ?secret)))
                    (and (false_belief ?receiver ?secret))
                )
                ; when honest teller has a secret that he believes is true and receiver believes that secret is false, receiver then believes that secret is true
                (when (and (not (deceptive ?teller)) (true_belief ?teller ?secret) (false_belief ?receiver ?secret))
                    (and (not (false_belief ?receiver ?secret)) (true_belief ?receiver ?secret))
                )
                ; when honest teller has a secret that he believes is true and receiver has no belief of that secret, receiver then believes that secret is true
                (when (and (not (deceptive ?teller)) (true_belief ?teller ?secret) (not (true_belief ?receiver ?secret)) (not (false_belief ?receiver ?secret)))
                    (and (true_belief ?receiver ?secret))
                )
            )
   )
)
