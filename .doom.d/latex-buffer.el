;;; latex-buffer.el -*- lexical-binding: t; -*-


(define-minor-mode my/quick-latex-minor-mode
  "Minor mode for having a quick, temporary LaTeX buffer."
  :init-value nil)

(defvar my/quick-latex-minor-mode-map (make-sparse-keymap)
  "The keymap for my/quick-latex-minor-mode.")

(add-to-list 'minor-mode-map-alist (cons 'my/quick-latex-minor-mode
                                         my/quick-latex-minor-mode-map))

(defun my/prompt-latex-buffer (split? new?)
  "Open / Duplicate the quick buffer for LaTeX editing"
  (let
      ((latex-buffer
        (funcall (if new? 'generate-new-buffer 'get-buffer-create)
                 "*latex-scratch-buffer*")))

    (if split? (split-window (selected-window) nil 'above))

    (let ((src-buffer (current-buffer)))

    (with-current-buffer latex-buffer
        (LaTeX-mode)
        (my/quick-latex-minor-mode)
        ;;(insert "$$")
        ;;(backward-char 1)
        (evil-insert-state)
        (setq-local latex-buffer-split? split?
                    latex-src-buffer src-buffer)))

    (define-key my/quick-latex-minor-mode-map (kbd "C-c C-c")
      (lambda ()
        (interactive)
        (let* ((latex-input (buffer-string))
               (src-buffer latex-src-buffer))
          (if latex-buffer-split? (delete-window))
          ;;(kill-buffer)
          ;;(message latex-src-split?)
          (switch-to-buffer src-buffer)
          (insert latex-input))))
    (switch-to-buffer latex-buffer)))

(defun my/open-latex-buffer (&optional split?)
  (interactive)
  (my/prompt-latex-buffer split? nil))

(defun my/new-latex-buffer (&optional split?)
  (interactive)
  (my/prompt-latex-buffer split? t))


(defun my/latex-buffer-split () (my/latex-buffer t))
