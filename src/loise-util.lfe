(defmodule loise-util
  (export all)
  (import
    (from lists
      (flatten 1)
      (map 2)
      (seq 2))
    (from loise
      (perlin 1) (perlin 2) (perlin 3)
      (simplex 1) (simplex 2) (simplex 3))))

(defun get-loise-version ()
  (lutil:get-app-src-version "src/loise.app.src"))

(defun get-version ()
  (++ (lutil:get-version)
      `(#(loise ,(get-loise-version)))))

(defun index (data position)
  "A list-based version of element-index."
  (lists:nth (+ 1 position) data))

(defun element-index (tuple position)
  "This provides the same interface as the Racket function 'vector-ref' upon
  which it is based."
  (element (+ 1 position) tuple))

(defun dot (g x y z)
   (+ (* (index g 0) x)
      (* (index g 1) y)
      (* (index g 2) z)))

(defun element-dot (g x y z)
   (+ (* (element-index g 0) x)
      (* (element-index g 1) y)
      (* (element-index g 2) z)))

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
  "This function is used for generating large lists of perlin noise numbers
  across a range of multipliers and sizes."
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
  "This function is used for generating large lists of perlin noise numbers
  across a range of multipliers and sizes."
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
  (((tuple x) (tuple width) multiplier)
    (simplex (* multiplier (/ x width))))
  (((tuple x y) (tuple width height) multiplier)
    (simplex (* multiplier (/ x width))
             (* multiplier (/ y height))))
  (((tuple x y z) (tuple width height depth) multiplier)
    (simplex (* multiplier (/ x width))
             (* multiplier (/ y height))
             (* multiplier (/ z depth)))))