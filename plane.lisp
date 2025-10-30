#!/usr/bin/sbcl --script


(require :asdf)
(require :uiop)

(defparameter *output-destination* t)
;; can be T (terminal), a stream, or NIL (return string)

(defun rec (n acc)
  (if (< 100 n) acc
      (rec (* 2 n)
	   (cons (cons (- n 1) (+ n 1)) acc))))


(let* ((args (cdr sb-ext:*posix-argv*))
       (dx (parse-integer (first args)))
       (dy (parse-integer (second args)))
       (offset (parse-integer (third args)))
       (option (fourth args)))

(defun spiral (i acc)
  (let*
      ((n (* i offset))
       (x1 (- dx n))
       (y1 n)
       (x2 (- dx n))
       (y2 (- dy n))
       (x3 n)
       (y3 (- dy n))
       (x4 n)
       (y4 (+ n offset))
       (points (list x1 y1 x2 y2 x3 y3 x4 y4)))
    (if (> n (/ dx 2))
	acc
	(spiral (+ 1 i) (concatenate 'list acc points)))))


(defun G01 (x y)
  (format *output-destination* "G01 X~a Y~a~%" x y))

(defun path (x y)
  (format  *output-destination* "~a ~a~%" x y))

(defun pp (f l)
  (if (null l) l
      (progn
	(funcall f (car l) (cadr l))
	(pp f (cddr l)))))


  
(let ((svg-header (uiop:read-file-string "svg-header"))
(svg-footer (uiop:read-file-string "svg-footer")))
    (defun print-svg ()
      (progn  (format *output-destination* "~a" svg-header)
	      (pp 'path (spiral 0 nil))
	      (format *output-destination* "~a" svg-footer))))

(defun print-gcode ()
  (progn  (pp 'G01 (spiral 0 nil))))



(defun output (f ext)
 (with-open-file (s (format nil "spiral-X~A-Y~A~A" dx dy ext)
                   :direction :output
                   :if-exists :append
                   :if-does-not-exist :create)
  (let ((*output-destination* s))
   (funcall f)))))

;;print the code to files:

(output #'print-gcode ".nc")

(output #'print-svg ".svg")


;;print the gcode file to standard output:

(print-gcode)
