(load "obj")
(load "adv")
(load "adv-world")

; places
(define Dormitory (instantiate place 'Dormitory))
(define Kirin (instantiate place 'Kirin))

; places links
(can-go Haas 'east Dormitory)  
(can-go Dormitory 'west Haas)  
(can-go Soda 'north Kirin)  
(can-go Kirin 'south Soda)  

; people
(define Federico (instantiate person 'Federico Dormitory))

; things
(define potstickers (instantiate thing 'potstickers))

; place things
(ask Kirin 'appear potstickers)

; actions
(ask Federico 'go 'west)
(ask Federico 'go 'north)
(ask Federico 'go 'north)
(ask Federico 'go 'north)
(ask Federico 'take potstickers)
(ask Federico 'go 'south)
(ask Federico 'go 'up)
(ask Federico 'go 'west)
(ask Federico 'lose potstickers)
(ask Brian 'take potstickers)
(ask Federico 'go 'east)
(ask Federico 'go 'down)
(ask Federico 'go 'down)
