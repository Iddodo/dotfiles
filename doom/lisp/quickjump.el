;;; ../../git/dotfiles/doom/lisp/quickjump.el -*- lexical-binding: t; -*-


(defmacro defquickjumps
    (&rest jumps)
  `(defvar my/quickjump-alist ',jumps))

(defmacro defquickjump-shortcuts
    (prefix &rest jumps)
  "Define a quickjump list."
  (let ((target-jumps
         (mapcar (lambda (x)
                   (list :desc
                         (concat "Quickjump to: " (alist-get (car x) my/quickjump-alist))
                         (cdr x)
                         `(lambda () (interactive) (my/quickjump-to ',(car x))))) jumps)))
    `(map! :leader (:prefix ,prefix ,@target-jumps))))

(defun my/quickjump-add-alias (alias route)
  (add-to-list 'my/quickjump-alist (cons alias route)))


(defun my/quickjump (&optional dired?)
  (interactive)
  (let* ((key (completing-read "Quickjump: " my/quickjump-alist nil t))
         (path (alist-get key my/quickjump-alist nil nil 'string=)))
    (unless path
      (error "No such quickjump: %s" key))
    (if dired?
        (dired path)
      (ido-find-file-in-dir path))))


(defun my/quickjump-dired ()
  (interactive)
  (my/quickjump t))

(defun my/quickjump-to (target)
  (find-file (alist-get target my/quickjump-alist)))
