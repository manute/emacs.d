(defun change-lamda-chars (mode)
  (font-lock-add-keywords
   mode
   `(("(\\(fn\\)[\[[:space:]]"  ; anon funcs 1
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

(use-package rainbow-delimiters
  :ensure t
  :diminish rainbow-delimiters-mode)

(use-package clojure-mode
  :ensure t
  :after rainbow-delimiters-mode
  :mode  (("\\.clj" . clojure-mode)
          ("\\.edn" . clojure-mode)
          ("\\.cljs" . clojurescript-mode)
          )
  :config
  (change-lamda-chars 'clojure-mode)
  (change-lamda-chars 'clojurescript-mode)

  (add-hook 'clojure-mode-hook #'eldoc-mode)
  (add-hook 'clojurescript-mode-hook #'eldoc-mode)

  (add-hook 'clojure-mode-hook #'smartparens-mode)
  (add-hook 'clojurescript-mode-hook #'smartparens-mode)

  (add-hook 'clojure-mode-hook #'company-mode)
  (add-hook 'clojurescript-mode-hook #'company-mode)

  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'clojurescript-mode-hook #'rainbow-delimiters-mode))


(defun manu/clj-format-before-save-hook ()
  (when (eq major-mode 'clojure-mode)
    (cider-format-buffer)))

(use-package cider
  :ensure t
  :after clojure-mode
  :config
  ;; Config CIDER figwheel
  ;; (setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

  ;; Shortcut keys config
  (define-key clojure-mode-map (kbd "C-c r") #'cider-jack-in)
  (define-key clojure-mode-map (kbd "C-c s") #'cider-jack-in-clojurescript)
  (define-key clojure-mode-map (kbd "C-c t") #'cider-test-run-test)

  ;; Format buffer
  (add-hook 'before-save-hook #'manu/clj-format-before-save-hook)

  ;; REPL history file
  (setq cider-repl-history-file "~/.emacs.d/cider-history")

  ;; nice pretty printing
  (setq cider-repl-use-pretty-printing t)

  ;; go right to the REPL buffer when it's finished connecting
  (setq cider-repl-pop-to-buffer-on-connect t)

  ;; When there's a cider error, show its buffer and switch to it
  (setq cider-show-error-buffer t)
  (setq cider-auto-select-error-buffer t)

  ;; nicer font lock in REPL
  (setq cider-repl-use-clojure-font-lock t)

  ;; result prefix for the REPL
  (setq cider-repl-result-prefix ";; => ")

  ;; never ending REPL history
  (setq cider-repl-wrap-history t)

  ;; looong history
  (setq cider-repl-history-size 3000)

  (add-hook 'cider-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'smartparens-mode)
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'rainbow-delimiters-mode))

(use-package clj-refactor
  :ensure t
  :diminish clj-refactor-mode
  :after clojure-mode
  :config
  (yas-minor-mode 1)
  (clj-refactor-mode 1))



(use-package flycheck-clojure
  :ensure t
  :after (clojure-mode flycheck)
  :config (flycheck-clojure-setup))

(use-package flycheck-pos-tip
  :ensure t
  :after flycheck
  :config
  (when (eq major-mode 'clojure-mode)
    (setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

(provide 'init-clojure)
