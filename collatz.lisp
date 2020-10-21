;;;; -*- Mode: Common-Lisp -*-

(proclaim '(optimize (speed 3) (safety 0) (space 0)))

(defconstant limit (expt 10 1000))

(defparameter *noisy* t)

(defmacro noisy (&rest form)
  (if *noisy* `(progn ,@form)))

(defun collatz (a)
  (declare (type (integer 0) a))
  (let ((seen (make-hash-table :test 'eql))
	(p nil))
    (loop
       (cond ((evenp a)
	      (setf a (/ a 2 ))
	      (setf p "even"))
	     (t
	      (setf a (+ (* 3 a) 1))
	      (setf p "odd")))
       (cond ((= a 1)
	      (let ((len (hash-table-size seen)))
		(noisy (format t "Finished in ~d moves~%" len))
		(return len)))
	     ((gethash a seen)
	      (noisy (format t "Counterexample! ~d~%" a))
	      (throw 'counterexample a)))
       (setf (gethash a seen) t)
       (noisy (format t "~d ~s ~d~%" a p (hash-table-size seen))))))

(defun trial (random-state)
  (let ((a (random limit random-state)))
    (noisy (format t "========== ~s a: ~d~%" random-state a))
    (collatz a)
    (noisy (format t "==========~%"))))

(defun run ()
  ;; handling of random state is not deterministic like strick's code
  (do ((n 0 (+ n 1))
       (random-state (make-random-state t) (make-random-state random-state)))
      ((= n 1000000))
    (declare (type fixnum n))
    (trial random-state)))
