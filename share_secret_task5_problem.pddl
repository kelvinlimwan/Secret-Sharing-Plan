(define (problem task5)
   (:domain secrets)
   (:objects a1 a2 a3 a4 a5 a6 - agent s1 - secret)
   (:init 
        (connected a1 a2)
        (connected a1 a3)
        (connected a2 a4)
        (connected a3 a5)
        (connected a3 a6)
        (connected a4 a5)
        (connected a5 a3)
        (true_belief a1 s1)
        (deceptive a5)
   )
   (:goal 
        (and
            (false_belief a3 s1)
            (true_belief a6 s1)
        )
   )
)
