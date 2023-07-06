(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(osx-plist tablist sicp fireplace el-fetch cypher-mode corfu consult))
 '(safe-local-variable-values
   '((cider-offer-to-open-cljs-app-in-browser)
     (cider-shadow-watched-builds ":app")
     (cider-shadow-default-options . ":app")
     (cider-default-cljs-repl . shadow)
     (cider-preferred-build-tool . shadow-cljs))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.3))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.2))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.1)))))
(put 'downcase-region 'disabled nil)
