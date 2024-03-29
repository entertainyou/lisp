(defparameter *nodes* '((living-room (you are in the living room. a wizard is snoring loudy on the couch.))
                        (garden (you are in a beautiful garden. there is a well in front of you))
                        (attic (you are in the attic. there is a giant welding torch in the corner.))))

(defparameter *edges* '((living-room (garden west door) (attic upstairs ladder))
                        (garden (living-room east door))
                        (attic (living-room downstairs ladder))))

(defun describe-location (location nodes)
  (cadr (assoc location nodes)))

(defun describe-path (edge)
  `(there is a ,(caddr edge) going ,(cadr edge) from here.))

(defun describe-paths (location edges)
  (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))

(defparameter *objects* '(whiskey bucket frog chain))

(defparameter *object-locations* '((whiskey living-room)
                                   (bucket living-room)
                                   (frog garden)
                                   (chain garden)))

(defun objects-at (loc objs obj-locs)
  (labels ((at-loc-p (obj)
             (eq (cadr (assoc obj obj-locs)) loc)))
    (remove-if-not #'at-loc-p objs)))

(defun describe-objects (loc objs obj-loc)
  (labels ((describe-obj (obj)
             `(you see a ,obj on the floor.)))
  (apply #'append (mapcar #'describe-obj (objects-at loc objs obj-loc)))))

(defparameter *location* 'living-room)

(defun look()
  (append (describe-location *location* *nodes*)
          (describe-paths *location* *edges*)
          (describe-objects *location* *objects* *object-locations*)))

(find 'west
      (cdr (assoc *location* *edges*))
      :key #'cadr)

(defun walk (direction)
  (let ((next (find direction
                    (cdr (assoc *location* *edges*))
                    :key #'cadr)))
    (if next
        (progn (setf *location* (car next))
               (look))
        '(you cannot go that way))))

(look)
(setf *location* 'living-room)
(walk 'upstairs)
(walk 'downstairs)
(walk 'west)


*location*
(describe-objects 'living-room *objects* *object-locations*)
(objects-at 'living-room *objects* *object-locations*)

(describe-path '(garden west door))
(describe-location 'living-rooma *node*)
(describe-paths 'living-room *edges*)
(assoc 'living-room *node*)

