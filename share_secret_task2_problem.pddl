(define (problem task2)
    (:domain secrets)
    (:objects a1 a2 a3 - agent s1 - secret)
    (:init 
        (connected a1 a2) 
        (connected a2 a3) 
        (knows a1 s1)
    )
    (:goal 
        (knows a3 s1)
    )
)