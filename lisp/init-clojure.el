;Change lambda chars
(defun manu/change-symbol-specials-chars()
  (font-lock-add-keywords
   mode '(("(\\(fn\\)[\[[:space:]]"  ; anon funcs 1
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
                     nil))))))

(use-package clojure-mode
  :ensure t
  :mode  (("\\.clj\\'" . clojure-mode)
          ("\\.cljs\\'" . clojure-mode)
          ("\\.cljc\\'" . clojure-mode))
  :config
  (setq org-babel-clojure-backend 'cider)
  ;; Cider
  (setq nrepl-hide-special-buffers t
        cider-repl-pop-to-buffer-on-connect nil
        cider-popup-stacktraces nil
        cider-repl-popup-stacktraces nil
        cider-show-error-buffer nil)

  (add-hook 'clojure-mode-hook #'manu/change-symbol-specials-chars)

  (use-package elein
    :ensure t
    :bind ("C-x t" . elein-test))

  (use-package cider
    :ensure t
    :bind (("C-x j" . cider-jack-in)
           ("C-c j" . cider-jack-in-clojurescript)
           ("C-c r" . cider-restart))
    :config
    ;; Cider mode hooks
    (add-hook 'cider-mode-hook #'cider-turn-on-eldoc-mode)
    (add-hook 'cider-mode-hook #'rainbow-delimiters-mode))

  (use-package clj-refactor
    :ensure t
    :diminish clj-refactor-mode
    :config
    (yas-minor-mode 1)
    (clj-refactor-mode 1))

  (use-package paren
    :ensure t
    :config
    (show-paren-mode)
    (setq show-paren-style 'expression)
    (electric-pair-mode t))

  (use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'clojurescript-mode-hook #'rainbow-delimiters-mode))

  (use-package smartparens
    :ensure t
    :config
    (add-hook 'clojure-mode-hook #'smartparens-mode)
    (add-hook 'clojurescript-mode-hook #'smartparens-mode)))


;; INDENTATION ALWAYS 2 SPACES
;; (setq clojure-defun-style-default-indent t)


(provide 'init-clojure)
