(use-package clojure-mode
  :ensure t
  :mode  (("\\.clj\\'" . clojure-mode)
          ("\\.cljs\\'" . clojure-mode)
          ("\\.cljc\\'" . clojure-mode))
  :config

  ;;Change lambda chars
  (font-lock-add-keywords
   `clojure-mode `(("(\\(fn\\)[\[[:space:]]"  ; anon funcs 1
           (0 (progn (compose-region (match-beginning 1)
                                     (match-end 1) "λ")
                     nil)))
          ("\\(#\\)("                ; anon funcs 2
           (0 (progn (compose-region (match-beginning 1)
                                     (match-end 1) "ƒ")
                     nil)))
          ("\\(#\\){"                 ; sets
           (0 (progn (compose-region (match-beginning 1)
                                     (match-end 1) "∈")
                     nil)))))

  (add-hook 'clojure-mode-hook #'smartparens-mode)
  (add-hook 'clojure-mode-hook #'eldoc-mode)

  (use-package cider
    :ensure t
    :config
    (setq org-babel-clojure-backend 'cider)
    (add-hook 'cider-mode-hook #'smartparens-mode)
    (add-hook 'cider-mode-hook #'eldoc-mode)

    ;; Config CIDER figwheel
    ;; (setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

    (setq nrepl-hide-special-buffers t
          cider-repl-pop-to-buffer-on-connect nil
          cider-popup-stacktraces nil
          cider-repl-popup-stacktraces nil
          cider-show-error-buffer nil))

  (use-package clj-refactor
    :ensure t
    :diminish clj-refactor-mode
    :config
    (yas-minor-mode 1)
    (clj-refactor-mode 1))

  (use-package rainbow-delimiters
    :ensure t
    :diminish rainbow-delimiters-mode
    :config
    (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'cider-mode-hook #'rainbow-delimiters-mode)))



;; INDENTATION ALWAYS 2 SPACES
;; (setq clojure-defun-style-default-indent t)


(provide 'init-clojure)
