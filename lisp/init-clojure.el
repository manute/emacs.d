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
  (add-hook 'clojurescript-mode-hook #'smartparens-mode)

  (use-package cider
    :ensure t
    :bind (("C-x j" . cider-jack-in)
           ("C-c j" . cider-jack-in-clojurescript)
           ("C-c r" . cider-restart))
    :config
    (setq org-babel-clojure-backend 'cider)
    (add-hook 'cider-mode-hook #'cider-turn-on-eldoc-mode)
    (add-hook 'cider-mode-hook #'smartparens-mode)

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
    (add-hook 'clojurescript-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'cider-mode-hook #'rainbow-delimiters-mode)))

;; INDENTATION ALWAYS 2 SPACES
;; (setq clojure-defun-style-default-indent t)


(provide 'init-clojure)
