(setq display-line-numbers-type 'relative)

(setq org-directory "~/org/")

(setq doom-theme 'doom-1337)

(setq prettify-symbols-unprettify-at-point t)

(map! :leader )

(use-package! evil
  :config
  (setq evil-want-fine-undo t))

(defun toggle-rtl-mode ()
      (interactive
       (if (eq bidi-paragraph-direction 'left-to-right)
         (setq bidi-paragraph-direction 'right-to-left)
         (setq bidi-paragraph-direction 'left-to-right))))

(map! :leader
      (:prefix "l"
       :desc "Toggle bidi-paragraph-direction" "r" #'toggle-rtl-mode))

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

(defquickjumps
  (algo . "~/Notes/summer23-24/algorithms/")
  (public . "~/git/public-notes")
  (db . "~/Notes/summer23-24/databases/")
  (atam . "~/Notes/summer23-24/atam")
  (notes . "~/Notes/")
  (code . "~/Code")
  (learn . "~/learn")
  (git . "~/git")
  (dotfiles . "~/git/dotfiles")
  (whats . "~/Downloads/WhatsApp")
  (downloads . "~/Downloads")
  (documents . "~/Documents")
  (learn . "~/learn")
  )

(defquickjump-shortcuts "j"
  (notes . "n")
  (code . "c")
  (algo . "a")
  (db . "db")
  (dotfiles . "df")
  (downloads . "dl")
  (documents . "D")
  (learn . "l")
  (git . "g")
  )

(map! :leader
      (:prefix "j"
       :desc "Quickjump" "j" #'my/quickjump-dired
       :desc "Quickjump (ido-find-file)" "q" #'my/quickjump))

(map! :leader (:prefix "o"
                       :desc "exams" "x" (lambda() (interactive) (find-file "~/org/exams.org"))))

(map! :leader (:prefix "o"
                       :desc "Technion" "X" (lambda() (interactive) (find-file "~/org/courses.org"))))

(use-package! org
  :hook ((org-mode . (lambda() (org-bullets-mode 1)))
         (org-mode . (lambda ()
                         (setq-default bidi-display-reordering t)
                         (setq-default bidi-paragraph-direction nil)))))

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.3))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.2))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
)

(with-eval-after-load 'org
  (defvar-local rasmus/org-at-src-begin -1
    "Variable that holds whether last position was a ")
  (defvar rasmus/ob-header-symbol ?☰
    "Symbol used for babel headers")

  (defun rasmus/org-prettify-src--update ()
    (let ((case-fold-search t)
          (re "^[ \t]*#\\+begin_src[ \t]+[^ \f\t\n\r\v]+[ \t]*")
          found)
      (save-excursion
        (goto-char (point-min))
        (while (re-search-forward re nil t)
          (goto-char (match-end 0))
          (let ((args (org-trim
                       (buffer-substring-no-properties (point)
                                                       (line-end-position)))))
            (when (org-string-nw-p args)
              (let ((new-cell (cons args rasmus/ob-header-symbol)))
                (cl-pushnew new-cell prettify-symbols-alist :test #'equal)
                (cl-pushnew new-cell found :test #'equal)))))
        (setq prettify-symbols-alist
              (cl-set-difference prettify-symbols-alist
                                 (cl-set-difference
                                  (cl-remove-if-not
                                   (lambda (elm)
                                     (eq (cdr elm) rasmus/ob-header-symbol))
                                   prettify-symbols-alist)
                                  found :test #'equal)))
        ;; Clean up old font-lock-keywords.
        (font-lock-remove-keywords nil prettify-symbols--keywords)
        (setq prettify-symbols--keywords (prettify-symbols--make-keywords))
        (font-lock-add-keywords nil prettify-symbols--keywords)
        (while (re-search-forward re nil t)
          (font-lock-flush (line-beginning-position) (line-end-position))))))

  (defun rasmus/org-prettify-src ()
    "Hide src options via `prettify-symbols-mode'.
  `prettify-symbols-mode' is used because it has uncollpasing. It's
  may not be efficient."
    (let* ((case-fold-search t)
           (at-src-block (save-excursion
                           (beginning-of-line)
                           (looking-at "^[ \t]*#\\+begin_src[ \t]+[^ \f\t\n\r\v]+[ \t]*"))))
      ;; Test if we moved out of a block.
      (when (or (and rasmus/org-at-src-begin
                     (not at-src-block))
                ;; File was just opened.
                (eq rasmus/org-at-src-begin -1))
        (rasmus/org-prettify-src--update))
      ;; Remove composition if at line; doesn't work properly.
      ;; (when at-src-block
      ;;   (with-silent-modifications
      ;;     (remove-text-properties (match-end 0)
      ;;                             (1+ (line-end-position))
      ;;                             '(composition))))
      (setq rasmus/org-at-src-begin at-src-block)))

  (defun rasmus/org-prettify-symbols ()
    (mapc (apply-partially 'add-to-list 'prettify-symbols-alist)
          (cl-reduce 'append
                     (mapcar (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
                             `(("#+begin_src" . ?✎) ;; ➤ 🖝 ➟ ➤ ✎
                               ("#+end_src"   . ?⌙) ;; ⏹
                               ("#+header:" . ,rasmus/ob-header-symbol)
                               ("#+begin_quote" . ?»)
                               ("#+end_quote" . ?«)))))
    (turn-on-prettify-symbols-mode)
    (add-hook 'post-command-hook 'rasmus/org-prettify-src t t))
  (add-hook 'org-mode-hook #'rasmus/org-prettify-symbols))

(use-package! org-auto-tangle
  :hook (org-mode . org-auto-tangle-mode))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (julia . t)
   (python . t)
   (jupyter . t)))

(use-package! org-download
  :init (require 'org-download))

(map! :map org-mode-map
      :leader
      (:prefix "c"
       :desc "org-download clipboard paste" "p" #'org-download-clipboard
       :desc "org-download screenshot" "S" #'org-download-screenshot))

;; (after! org-download
;;   (if (eq system-type 'darwin)
;;       (setq org-download-screenshot-method "screencapture -i %s"))

;;   (setq org-download-method 'directory)
;;   (setq org-download-image-dir (concat (file-name-sans-extension (buffer-file-name)) "-img"))
;;   (setq org-download-image-org-width 600)
;;   (setq org-download-link-format "[[file:%s]]\n"
;;         org-download-abbreviate-filename-function #'file-relative-name)
;;   (setq org-download-link-format-function #'org-download-link-format-function-default))

(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "f") 'find-file
  ;; Ranger style keybindings
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file
  ;; Marking files
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-create-empty-file
  (kbd "Y") 'dired-copy-filename-as-kill
  (kbd "Z") 'dired-do-compress
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-up-directory
  )

(map! :leader
      (:prefix ("d" . "dired")
               :desc "Open dired" "d" #'dired
               :desc "Dired jump to current" "j" #'dired-jump
               :desc "Dired go to file" "g" #'dired-goto-file)
      (:after dired
              (:map dired-mode-map
                    :desc "Peep-dired image-previews" "d p" #'peep-dired
                    :desc "Dired view file" "d v" #'dired-view-file)))

(evil-define-key 'normal peep-dired-mode-map (kbd "<SPC>") 'peep-dired-scroll-page-down
                                             (kbd "C-<SPC>") 'peep-dired-scroll-page-up
                                             (kbd "<backspace>") 'peep-dired-scroll-page-up
                                             (kbd "j") 'peep-dired-next-file
                                             (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes
                 '("\\.zip\\'" ".zip" "unzip")))

;; Non-evil
(eval-after-load "dired"
  '(define-key dired-mode-map "z" 'dired-zip-files))

;; Evl
(evil-define-key '(normal visual) dired-mode-map
  (kbd "z") 'dired-zip-files)

(defun dired-zip-files (zip-file)
  "Create an archive containing the marked files."
  (interactive "sEnter name of zip file: ")
  ;; create the zip file
  (let ((zip-file (if (string-match ".zip$" zip-file) zip-file (concat zip-file ".zip"))))
    (shell-command
     (concat "zip "
             zip-file
             " "
             (concat-string-list
              (mapcar
               '(lambda (filename)
                  (file-name-nondirectory filename))
               (dired-get-marked-files))))))

  (revert-buffer)

  ;; remove the mark on all the files  "*" to " "
  ;; (dired-change-marks 42 ?\040)
  ;; mark zip file
  ;; (dired-mark-files-regexp (filename-to-regexp zip-file))
  )

(defun concat-string-list (list)
   "Return a string which is a concatenation of all elements of the list separated by spaces"
    (mapconcat '(lambda (obj) (format "%s" obj)) list " "))

;; Dired file icons
(use-package! all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package! dired
  :hook (dired-mode . org-download-enable))

(after! org
  (setq org-roam-directory "~/org/roam/")
  (setq org-roam-index-file "~/org/roam/index.org"))

(use-package! pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))))

;; (use-package! org-noter
;;   :config
;;   (require 'org-noter-pdftools))

 (use-package! org-pdftools
   :hook (org-mode . org-pdftools-setup-link))

(setq +latex-viewers '(pdf-tools))

;; CDLatex settings
(use-package! cdlatex
  :ensure t
  :hook (LaTeX-mode . turn-on-cdlatex)
  :bind (:map cdlatex-mode-map
              ("<tab>" . cdlatex-tab)))

;; CDLatex integration with YaSnippet: Allow cdlatex tab to work inside Yas
;; fields
(use-package! cdlatex
  :hook ((cdlatex-tab . yas-expand)
         (cdlatex-tab . cdlatex-in-yas-field))
  :config
  (use-package! yasnippet
    :bind (:map yas-keymap
           ("<tab>" . yas-next-field-or-cdlatex)
           ("TAB" . yas-next-field-or-cdlatex))
    :config
    (defun cdlatex-in-yas-field ()
      ;; Check if we're at the end of the Yas field
      (when-let* ((_ (overlayp yas--active-field-overlay))
                  (end (overlay-end yas--active-field-overlay)))
        (if (>= (point) end)
            ;; Call yas-next-field if cdlatex can't expand here
            (let ((s (thing-at-point 'sexp)))
              (unless (and s (assoc (substring-no-properties s)
                                    cdlatex-command-alist-comb))
                (yas-next-field-or-maybe-expand)
                t))
          ;; otherwise expand and jump to the correct location
          (let (cdlatex-tab-hook minp)
            (setq minp
                  (min (save-excursion (cdlatex-tab)
                                       (point))
                       (overlay-end yas--active-field-overlay)))
            (goto-char minp) t))))

    (defun yas-next-field-or-cdlatex nil
      (interactive)
      "Jump to the next Yas field correctly with cdlatex active."
      (if
          (or (bound-and-true-p cdlatex-mode)
              (bound-and-true-p org-cdlatex-mode))
          (cdlatex-tab)
        (yas-next-field-or-maybe-expand)))))

(use-package! latex
  :hook (LaTeX-mode . (lambda ()
                         (setq-default bidi-display-reordering nil)
                         (setq-default bidi-paragraph-direction 'left-to-right))))

(use-package! latex
  :config
  (setq-default TeX-PDF-mode t)
  (setq-default TeX-engine 'xetex))

(use-package! latex
  :config
  (load "~/.config/doom/lisp/pretty-latex.el")
  :hook (LaTeX-mode . prettify-symbols-mode))

(use-package! latex
  :hook (LaTeX-mode . prettify-symbols-latex-symbols))

;; Function that tries to autoexpand YaSnippets
;; The double quoting is NOT a typo!
(defun my/yas-try-expanding-auto-snippets ()
  (when (bound-and-true-p yas-minor-mode)
      (let ((yas-buffer-local-condition ''(require-snippet-condition . auto)))
        (yas-expand))))

(after! latex
  (add-hook 'post-self-insert-hook
            #'my/yas-try-expanding-auto-snippets))

(with-eval-after-load 'warnings
  (cl-pushnew '(yasnippet backquote-change) warning-suppress-types
              :test 'equal))

;; Array/tabular input with org-tables and cdlatex
(use-package! org-table
  :after cdlatex
  :bind (:map orgtbl-mode-map
              ("<tab>" . lazytab-org-table-next-field-maybe)
              ("TAB" . lazytab-org-table-next-field-maybe))
  :init
  (add-hook 'cdlatex-tab-hook 'lazytab-cdlatex-or-orgtbl-next-field 90)
  ;; Tabular environments using cdlatex
  (add-to-list 'cdlatex-command-alist '("smat" "Insert smallmatrix env"
                                       "\\left( \\begin{smallmatrix} ? \\end{smallmatrix} \\right)"
                                       lazytab-position-cursor-and-edit
                                       nil nil t))
  (add-to-list 'cdlatex-command-alist '("bmat" "Insert bmatrix env"
                                       "\\begin{bmatrix} ? \\end{bmatrix}"
                                       lazytab-position-cursor-and-edit
                                       nil nil t))
  (add-to-list 'cdlatex-command-alist '("pmat" "Insert pmatrix env"
                                       "\\begin{pmatrix} ? \\end{pmatrix}"
                                       lazytab-position-cursor-and-edit
                                       nil nil t))
  (add-to-list 'cdlatex-command-alist '("tbl" "Insert table"
                                        "\\begin{table}\n\\centering ? \\caption{}\n\\end{table}\n"
                                       lazytab-position-cursor-and-edit
                                       nil t nil))
  :config
  ;; Tab handling in org tables
  (defun lazytab-position-cursor-and-edit ()
    ;; (if (search-backward "\?" (- (point) 100) t)
    ;;     (delete-char 1))
    (cdlatex-position-cursor)
    (lazytab-orgtbl-edit))

  (defun lazytab-orgtbl-edit ()
    (advice-add 'orgtbl-ctrl-c-ctrl-c :after #'lazytab-orgtbl-replace)
    (orgtbl-mode 1)
    (open-line 1)
    (insert "\n|"))

  (defun lazytab-orgtbl-replace (_)
    (interactive "P")
    (unless (org-at-table-p) (user-error "Not at a table"))
    (let* ((table (org-table-to-lisp))
           params
           (replacement-table
            (if (texmathp)
                (lazytab-orgtbl-to-amsmath table params)
              (orgtbl-to-latex table params))))
      (kill-region (org-table-begin) (org-table-end))
      (open-line 1)
      (push-mark)
      (insert replacement-table)
      (align-regexp (region-beginning) (region-end) "\\([:space:]*\\)& ")
      (orgtbl-mode -1)
      (advice-remove 'orgtbl-ctrl-c-ctrl-c #'lazytab-orgtbl-replace)))

  (defun lazytab-orgtbl-to-amsmath (table params)
    (orgtbl-to-generic
     table
     (org-combine-plists
      '(:splice t
                :lstart ""
                :lend " \\\\"
                :sep " & "
                :hline nil
                :llend "")
      params)))

  (defun lazytab-cdlatex-or-orgtbl-next-field ()
    (when (and (bound-and-true-p orgtbl-mode)
               (org-table-p)
               (looking-at "[[:space:]]*\\(?:|\\|$\\)")
               (let ((s (thing-at-point 'sexp)))
                 (not (and s (assoc s cdlatex-command-alist-comb)))))
      (call-interactively #'org-table-next-field)
      t))

  (defun lazytab-org-table-next-field-maybe ()
    (interactive)
    (if (bound-and-true-p cdlatex-mode)
        (cdlatex-tab)
      (org-table-next-field))))

(defun macos/open-in-new-kitty-window ()
  (interactive)
  (dired-smart-shell-command "open -a kitty $PWD" nil nil))

(map! :leader
      (:prefix "o"
        :desc "Open in new Kitty window" "k" #'macos/open-in-new-kitty-window))

(load-file "/Users/ido/.config/doom/org-generated/airdrop.el")

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

(load-file "/Users/ido/.config/doom/org-generated/school.el")

(use-package! magit
  :config
  (setq magit-clone-default-directory "/Users/ido/git/"))

(evil-define-key 'normal calc-mode-map
      (kbd "<up>") 'calc-ceiling
      (kbd "<down>") 'calc-floor)

(use-package! counsel-dash
  :config
  (setq counsel-dash-common-docsets '("Java" "Clojure" "Python 3"))
  (setq counsel-dash-docsets-url "https://raw.github.com/Kapeli/feeds/master")
  (setq counsel-dash-enable-debugging nil)
  (setq counsel-dash-browser-func 'eww))
