
;;Assign variables en masse, i.e: (assign-pars a 10 b 20 c 30 ... etc)
(defmacro assign-pairs (&rest pairs)
  (when (oddp (length pairs))
    (error "assign-pairs requires an even number of elements."))
  `(progn
     ,@(loop for (name val) on pairs by #'cddr
             collect `(defparameter ,name ,val))))




(defun triplet (l acc)
  (if (null l) acc
      (triplet
       (cdddr l)
       (cons (list (first l) (second l) (third l)) acc))))

(defun assign-helper (l acc)
  (if (null l) acc
      (assign-helper
       (cddr l)
       (cons (list 'defparameter (first l) (second l)) acc))))

(defmacro assign-pairs2 (&rest pairs)
  (when (oddp (length pairs))
    (error "assign-pairs requires an even number of elements."))
  `(progn
     ,@(assign-helper pairs nil)))
