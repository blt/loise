(defmodule loise
  (export all)
  (import
    (from erlang
      (list_to_tuple 1)
      (rem 2)
      (trunc 1)
      (tuple_to_list 1))
    (from lists
      (flatten 1)
      (foldl 3)
      (map 2)
      (zipwith 3))))

(defmacro grad3
  '#(#( 1.0  1.0  0.0) #(-1.0  1.0  0.0) #( 1.0 -1.0  0.0) #(-1.0 -1.0  0.0)
     #( 1.0  0.0  1.0) #(-1.0  0.0  1.0) #( 1.0  0.0 -1.0) #(-1.0  0.0 -1.0)
     #( 0.0  1.0  1.0) #( 0.0 -1.0  1.0) #( 0.0  1.0 -1.0) #( 0.0 -1.0 -1.0)))

(defmacro F3 ()
  "Very nice and simple skew factor for 3D"
  (/ 1.0 3.0))

(defmacro G3 ()
  "Very nice and simple unskew factor, too"
  (/ 1.0 6.0))

(defmacro perm-half ()
  (tuple 151 160 137 91 90 15 131 13 201 95 96 53 194 233 7
         225 140 36 103 30 69 142 8 99 37 240 21 10 23 190 6
         148 247 120 234 75 0 26 197 62 94 252 219 203 117 35
         11 32 57 177 33 88 237 149 56 87 174 20 125 136 171
         168 68 175 74 165 71 134 139 48 27 166 77 146 158
         231 83 111 229 122 60 211 133 230 220 105 92 41 55
         46 245 40 244 102 143 54 65 25 63 161 1 216 80 73
         209 76 132 187 208 89 18 169 200 196 135 130 116 188
         159 86 164 100 109 198 173 186 3 64 52 217 226 250
         124 123 5 202 38 147 118 126 255 82 85 212 207 206
         59 227 47 16 58 17 182 189 28 42 223 183 170 213 119
         248 152 2 44 154 163 70 221 153 101 155 167 43 172 9
         129 22 39 253 19 98 108 110 79 113 224 232 178 185
         112 104 218 246 97 228 251 34 242 193 238 210 144 12
         191 179 162 241 81 51 145 235 249 14 239 107 49 192
         214 31 181 199 106 157 184 84 204 176 115 121 50 45
         127 4 150 254 138 236 205 93 222 114 67 29 24 72 243
         141 128 195 78 66 215 61 156 180))

(defmacro perm ()
  (add-tuples (list (perm-half) (perm-half))))

(defun add-tuples (a)
  "
  If there's a better way to do this, pull requests welcome!
  "
  (list_to_tuple
    (flatten
      (map (lambda (x) (tuple_to_list x)) a))))

(defun fast-floor (int)
  "
  Sadly, this is named 'fast-floor' only because the Racket version was given
  that name (it makes copying and pasting the code that much easier!). There
  is no good floor function in Erlang... so this should probably have been
  called 'slow-floor'.
  "
  (let* ((trunc (trunc int))
         (check (- int trunc)))
    (cond
      ((< check 0) (- trunc 1))
      ((> check 0) trunc)
      ('true trunc))))

(defun vector-ref (tuple position)
  "
  This provides the same interface as the Racket function of the same name.
  "
  (: erlang element (+ 1 position) tuple))

(defun remainder (a b)
  "
  This is another function added to provide the same interface as Racket.
  "
  (rem a b))

(defun dot-product (a b)
  "
  This doesn't appear to be needed for this particular library, but it was fun
  to write, and is quite pretty, so it's staying ;-)
  "
  (foldl #'+/2 0
    (zipwith #'*/2 a b)))

(defun dot (g x y z)
   (+ (* (vector-ref g 0) x)
      (* (vector-ref g 1) y)
      (* (vector-ref g 2) z)))

(defun mix (a b t)
  (+ (* (- 1.0 t) a) (* t b)))

(defun fade (t)
  (* t t t (+ (* t (- (* t 6.0) 15.0)) 10.0)))

(defun perlin (x y z)
  )

(defun simplex (x y z)
  )