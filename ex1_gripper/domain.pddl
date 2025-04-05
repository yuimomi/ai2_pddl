;Header and description

(define (domain gripper)

  ;remove requirements that are not needed
  (:requirements :adl :typing :numeric-fluents)
  (:types
    room ball gripper
  )

  (:predicates
    (at-robby ?r1 - room)
    (at ?b - ball ?r - room)
    ;(free ?g – gripper)		
    (carry ?b - ball ?g - gripper)
    ;(gripper-capacity ?g - gripper ?n - number)
    ;(carry-count ?g - gripper ?n - number)
  )

  (:functions ; ← ここで数値関数を定義（number型）
    (gripper-capacity ?g - gripper)
    (carry-count ?g - gripper)
  )

  ;define actions here
  (:action move
    :parameters (?from - room ?to - room)
    :precondition (and (at-robby ?from))
    :effect (and (at-robby ?to)
      (not (at-robby ?from)))
  )

  (:action pick
    :parameters (?obj - ball ?room - room ?gripper - gripper)
    :precondition (and (at ?obj ?room) (at-robby ?room) ;;(free ?gripper)
      ; (gripper-capacity ?gripper ?max)
      ; (carry-count ?gripper ?count)
      ; (< ?count ?max))
      (< (carry-count ?gripper) (gripper-capacity ?gripper)) ; ← 関数呼び出し形式に変更
    ) ;; Whether the gripper can hold balls or not

    :effect (and (carry ?obj ?gripper)
      (not (at ?obj ?room)) (increase (carry-count ?gripper) 1)
    )
  )

  (:action drop ;Action to put a ball onto a table
    :parameters (?obj - ball ?room - room ?gripper - gripper)
    :precondition (and (carry ?obj ?gripper) (at-robby ?room))
    :effect (and (at ?obj ?room)
      (not (carry ?obj ?gripper))
      (decrease (carry-count ?gripper) 1))
  )
)