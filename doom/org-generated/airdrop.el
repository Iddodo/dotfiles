(defun airdrop-cli-prompt-run ()
  (interactive)
  (let ((target-fname
          (read-file-name "File: " default-directory (buffer-file-name))))
         (unless (file-exists-p target-fname)
           (error "File does not exist."))
         (call-process "airdrop" nil nil nil (expand-file-name target-fname))))

(defun dired-do-airdrop-marked-files ()
  (interactive)
  (unless (derived-mode-p 'dired-mode)
    (error "This command can only be used in a dired buffer."))
  (unless (dired-get-marked-files)
    (error "No files were marked."))
  (apply (apply-partially 'call-process "airdrop" nil nil nil) (dired-get-marked-files)))

(defun airdrop-cli-png-from-clipboard ()
  (interactive)
  (let* ((tmp-dir-name ".airdrop-tmp")
         (tmp-file-name "clipboard.png")
         (tmp-file-path (concat tmp-dir-name "/" tmp-file-name))
         (tmp-dir-exists-p (f-directory? tmp-dir-name)))

    (unless tmp-dir-exists-p
      (mkdir tmp-dir-name))

    (call-process "pngpaste"  nil nil nil  tmp-file-path)
    (call-process "airdrop" nil nil nil tmp-file-path)
    (delete-file tmp-file-path)
    (delete-directory tmp-dir-name)))

(defvar airdrop-minor-mode-map
  (let ((amap (make-sparse-keymap)))
    (define-key amap (kbd "C-c a r") #'airdrop-cli-prompt-run)
    (define-key amap (kbd "C-c a m")#'dired-do-airdrop-marked-files)
    (define-key amap (kbd "C-c a d") #'airdrop-cli-share-directory-contents)
    (define-key amap (kbd "C-c a p") #'airdrop-cli-png-from-clipboard)
    amap))

(define-minor-mode airdrop-minor-mode
  "A set of configurations and keybindings for
   using AirDrop inside the terminal."
  :lighter "AirDrop"
  :keymap airdrop-minor-mode-map)

(use-package! org-mode
  :hook (org-mode . airdrop-minor-mode))

(use-package! pdf-tools
  :hook (pdf-view-mode . airdrop-minor-mode))

(use-package! dired
  :hook (dired-mode . airdrop-minor-mode))
