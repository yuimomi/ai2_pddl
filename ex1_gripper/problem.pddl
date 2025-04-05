(define (problem gripper-x-1)
      (:domain gripper)
      (:objects
            rooma roomb roomc - room
            ball3 ball2 ball1 - ball
            left right - gripper
      )
      (:init
            (at-robby rooma)
            ; (free left)
            (at ball1 rooma)
            (at ball2 rooma)
            (at ball3 roomc)

            ;; グリッパーの容量と持っているボール数を数値関数で定義
            (= (gripper-capacity left) 2)
            (= (gripper-capacity right) 2)

            (= (carry-count left) 0)
            (= (carry-count right) 0)
      )
      ; (gripper-capacity left 2) ;Maximum capacity of the left gripper
      ; (gripper-capacity right 2) ;Maximum capacity of the right gripper

      ; (carry-count left 0) ;How many balls the left gripper has initially
      ; (carry-count right 0) ;How many balls the right gripper has initially

      (:goal
            (and (at ball1 roomb)
                  (at ball2 roomb)
                  (at ball3 roomb))
      )
)