;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Plan with BFWS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain ferry)
    (:requirements :strips :typing :disjunctive-preconditions)

    (:types
        ferry location car
    )

    (:predicates
        (not-eq ?x ?y)
        (is-car ?c -car)
        (location ?l - location)
        (port ?l -location)
        ; (ferry ?f -ferry)
        (type-a ?f -ferry)
        (type-b ?f -ferry)
        (at-ferry ?f -ferry ?l - location)
        (at ?c -car ?l -location)
        (empty ?f -ferry)
        (on ?c -car ?f -ferry)
    )

    (:action sail
        :parameters (?from - location ?to - location ?f -ferry)
        :precondition (and (not-eq ?from ?to)
            ; (location ?from) (location ?to)
            (at-ferry ?f ?from))
        :effect (and (at-ferry ?f ?to)
            (not (at-ferry ?f ?from)))
    )

    (:action board
        :parameters (?c -car ?l - location ?f -ferry)
        :precondition (and (is-car ?c) (location ?l) (port ?l)
            (at ?c ?l) (at-ferry ?f ?l) (empty ?f)
            (or(and(type-a ?f)(port ?l))(type-b ?f))
        )
        :effect (and (on ?c ?f)
            (not (at ?c ?l))
            (not (empty ?f)))
    )

    (:action debark
        :parameters (?c -car ?l - location ?f -ferry)
        :precondition (and (is-car ?c) (location ?l) (port ?l)
            (on ?c ?f) (at-ferry ?f ?l)
        )
        :effect (and (at ?c ?l)
            (empty ?f)
            (not (on ?c ?f)))
    )
)