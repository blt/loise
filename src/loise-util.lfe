(defmodule loise-util
  (export all)
  (import
    (from erlang
      (list_to_tuple 1)
      (rem 2)
      (round 1)
      (trunc 1)
      (tuple_to_list 1))
    (from lists
      (flatten 1)
      (foldl 3)
      (map 2)
      (seq 2)
      (zipwith 3))
    (from loise
      (perlin 1) (perlin 2) (perlin 3)
      (simplex 1) (simplex 2) (simplex 3))
    (from math
      (pow 2))))

(defun vector-ref (tuple position)
  "
  This provides the same interface as the Racket function of the same name.
  "
  (: erlang element (+ 1 position) tuple))

(defun remainder (a b)
  "
  This is essentially an alias so that Racket-based code will be easier to use.
  "
  (rem a b))

(defun bitwise-and (a b)
  "
  This is essentially an alias so that Racket-based code will be easier to use.
  "
  (band a b))

(defun dot (g x y z)
   (+ (* (vector-ref g 0) x)
      (* (vector-ref g 1) y)
      (* (vector-ref g 2) z)))

(defun get-perlin-for-point
  "
  "
  (((tuple x) (tuple width) multiplier)
    (perlin (* multiplier (/ x width))))
  (((tuple x y) (tuple width height) multiplier)
    (perlin (* multiplier (/ x width))
            (* multiplier (/ y height))))
  (((tuple x y z) (tuple width height depth) multiplier)
    (perlin (* multiplier (/ x width))
            (* multiplier (/ y height))
            (* multiplier (/ z depth)))))

(defun get-perlin-range
  "
  This function is used for generating large lists of perlin noise numbers
  across a range of multipliers and sizes.
  "
  (((tuple mult-start mult-end) (tuple width))
    (flatten
      (map
        (lambda (multiplier)
          (map
            (lambda (x)
              (get-perlin-for-point (tuple x) (tuple width) multiplier))
            (seq 0 (- width 1))))
          (seq mult-start mult-end))))
  (((tuple mult-start mult-end) (tuple width height))
    (flatten
      (map
        (lambda (multiplier)
          (map
            (lambda (x)
              (map
                (lambda (y)
                  (get-perlin-for-point
                    (tuple x y)
                    (tuple width height)
                    multiplier))
                (seq 0 (- height 1))))
            (seq 0 (- width 1))))
          (seq mult-start mult-end))))
  (((tuple mult-start mult-end) (tuple width height depth)))
  ; let's save this one for later...
  )

(defun get-simplex-range
  "
  This function is used for generating large lists of perlin noise numbers
  across a range of multipliers and sizes.
  "
  (((tuple mult-start mult-end) (tuple width))
    (flatten
      (map
        (lambda (multiplier)
          (map
            (lambda (x)
              (get-simplex-for-point (tuple x) (tuple width) multiplier))
            (seq 0 (- width 1))))
          (seq mult-start mult-end))))
  (((tuple mult-start mult-end) (tuple width height))
    (flatten
      (map
        (lambda (multiplier)
          (map
            (lambda (x)
              (map
                (lambda (y)
                  (get-simplex-for-point
                    (tuple x y)
                    (tuple width height)
                    multiplier))
                (seq 0 (- height 1))))
            (seq 0 (- width 1))))
          (seq mult-start mult-end))))
  (((tuple mult-start mult-end) (tuple width height depth)))
  ; let's save this one for later...
  )

(defun get-simplex-for-point
  "
  "
  (((tuple x) (tuple width) multiplier)
    (simplex (* multiplier (/ x width))))
  (((tuple x y) (tuple width height) multiplier)
    (simplex (* multiplier (/ x width))
             (* multiplier (/ y height))))
  (((tuple x y z) (tuple width height depth) multiplier)
    (simplex (* multiplier (/ x width))
             (* multiplier (/ y height))
             (* multiplier (/ z depth)))))