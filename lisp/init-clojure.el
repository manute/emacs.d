;; brew install borkdude/brew/clj-kondo
;; (use-package flycheck-clj-kondo
;;   :ensure t)

(use-package inf-clojure
  :ensure t)

(use-package clojure-mode
  :ensure t
  :mode  (("\\.clj"  . clojure-mode)
          ("\\.edn"  . clojure-mode)
          ("\\.cljs" . clojurescript-mode)
          ("\\.java" . clojure-mode))
  :config
  ;; (require 'flycheck-clj-kondo)
  (setq clojure-align-forms-automatically 1)

  (add-hook 'clojure-mode-hook #'eldoc-mode)
  (add-hook 'clojurescript-mode-hook #'eldoc-mode)

  (add-hook 'clojure-mode-hook #'smartparens-mode)
  (add-hook 'clojurescript-mode-hook #'smartparens-mode)

  (add-hook 'clojure-mode-hook #'company-mode)
  (add-hook 'clojurescript-mode-hook #'company-mode)

  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'clojurescript-mode-hook #'rainbow-delimiters-mode)

  ;; (add-hook 'clojure-mode-hook #'inf-clojure-minor-mode)
  )


(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("(\\(fn\\)[\[[:space:]]"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "λ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\)("
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "ƒ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\){"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "∈")
                               nil))))))


(defun manu/clj-format-before-save-hook ()
  (when (eq major-mode 'clojure-mode)
    (cider-format-buffer)))

(use-package cider
  :ensure t
  :after clojure-mode
  :config

  ;; java source paths
  ;; (setq cider-jdk-src-paths '("/Users/manute/java/openjdk11"
  ;;                             "/Users/manute/java/sources"))

  ;; lein for now
  (setq cider-jack-in-default "lein")

  ;; Config CIDER figwheel
  ;; https://github.com/Day8/re-frame-template#start-cider-from-emacs-if-using-cider
  (setq cider-cljs-lein-repl
	"(do (require 'figwheel-sidecar.repl-api)
         (figwheel-sidecar.repl-api/start-figwheel!)
         (figwheel-sidecar.repl-api/cljs-repl))")

  ;; Shortcut keys config
  (define-key clojure-mode-map (kbd "C-c r") #'cider-jack-in)
  (define-key clojure-mode-map (kbd "C-c s") #'cider-jack-in-clojurescript)
  (define-key clojure-mode-map (kbd "C-c t") #'cider-test-run-test)
  (define-key clojure-mode-map (kbd "C-c C-n") #'cider-pprint-eval-defun-at-point)
  (define-key cider-mode-map (kbd "C-c C-n") #'cider-pprint-eval-defun-at-point)

  ;; find file key
  (define-key clojure-mode-map (kbd "C-c C-f") nil)
  (define-key cider-mode-map (kbd "C-c C-f") nil)

  ;; Format buffer
  ;; (add-hook 'before-save-hook #'manu/clj-format-before-save-hook)
  ;; disable indentation - for matching Cursive code
  ;; (setq cider-dynamic-indentation nil)

  ;; nrepl
  (setq nrepl-log-messages t)
  (setq nrepl-hide-special-buffers t)

  ;; REPL history file
  (setq cider-repl-history-file "~/.emacs.d/cider-history")

  ;; nice pretty printing
  (setq cider-repl-use-pretty-printing t)

  ;; go right to the REPL buffer when it's finished connecting
  (setq cider-repl-pop-to-buffer-on-connect t)

  ;; When there's a cider error, don't show it
  (setq cider-show-error-buffer nil)
  ;; (setq cider-auto-select-error-buffer t)

  ;; nicer font lock in REPL
  (setq cider-repl-use-clojure-font-lock t)

  ;; result prefix for the REPL
  (setq cider-repl-result-prefix " - ")

  ;; never ending REPL history
  (setq cider-repl-wrap-history t)

  ;; looong history
  (setq cider-repl-history-size 3000)

  (setq cider-repl-display-help-banner nil)

  (setq cider-ns-refresh-show-log-buffer t)

  (setq cider-prefer-local-resources t)
  (setq nrepl-hide-special-buffers t)

  (add-hook 'cider-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'smartparens-mode)
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'rainbow-delimiters-mode)

  ;; Fuzzy candidate matching
  (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
  (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion)
  )

(use-package clj-refactor
  :ensure t
  :diminish clj-refactor-mode
  :after clojure-mode
  :config
  (yas-minor-mode 1)
  (clj-refactor-mode 1))


;; (use-package flycheck-joker
;;   :ensure t
;;   :after (clojure-mode flycheck))


;; (use-package flycheck-clojure
;;   :ensure t
;;   :after flycheck-joker
;;   :config (flycheck-clojure-setup))


(use-package flycheck-pos-tip
  :ensure t
  :after flycheck
  :config
  (when (eq major-mode 'clojure-mode)
    (setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

;; (use-package sayid-mode
;;   :ensure t
;;   :after cider-mode
;;   :init ((sayid-setup-package)))

(provide 'init-clojure)
