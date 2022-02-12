(use-package lsp-mode
  :commands lsp
  :ensure t
  :diminish lsp-mode

  ;; uncomment this the first time
  ;; :ensure-system-package
  ;; ((typescript-language-server . "npm install -g typescript-language-server")
  ;;  (javascript-typescript-langserver . "npm install -g javascript-typescript-langserver")
  ;;  (yaml-language-server . "npm install -g yaml-language-server")
  ;;  (tsc . "npm install -g typescript")
  ;;  (json-mode . "npm i -g vscode-json-languageserver")
  ;;  (dockerfile-mode . "npm i -g dockerfile-language-server-nodejs")
  ;;  (sh-mode . "npm i -g bash-language-server")
  ;;  (gopls . "go install golang.org/x/tools/gopls@latest")
  ;;  (terraform-mode . "go install github.com/juliosueiras/terraform-lsp@latest")
  ;;  (python-mode . "pip install python-lsp-server")
  ;;  (clojure-mode . "brew install clojure-lsp/brew/clojure-lsp-native")
  ;;  )

  ;; If there're errors, download the lastest tag i.e https://github.com/emacs-lsp/lsp-mode/releases/tag/7.0.1
  ;; And move it to .emacs/local/..
  ;; :load-path "local/lsp-mode-7.0"

  ;; languages
  :hook  (
          (go-mode . lsp-deferred) 
          (sh-mode . lsp-deferred)
          (dockerfile-mode . lsp-deferred) 
          (yaml-mode . lsp-deferred)
          (python-mode . lsp-deferred) 
          (json-mode . lsp-deferred)
          (terraform-mode . lsp-deferred)
          ((js2-mode rjsx-mode typescript-mode) . lsp-deferred)
          (clojure-mode . lsp-deferred)
  )
  :init
  (setq lsp-auto-guess-root t
        lsp-prefer-flymake nil
        lsp-enable-file-watchers nil
        lsp-eldoc-render-all t
        lsp-idle-delay 0.500
        lsp-pyls-plugins-flake8-enabled t
        lsp-completion-provider :capf
        lsp-gopls-codelens nil
        ;; lsp-lens-enable t
        lsp-signature-auto-activate nil
        lsp-clojure-custom-server-command '("bash" "-c" "/usr/local/bin/clojure-lsp")
        )

  :bind (:map lsp-mode-map
              ("C-c C-j" . lsp-find-definition)
              ("C-c C-d" . lsp-describe-thing-at-point)
              )
  ;; uncomment to enable gopls http debug server
  ;; :custom (lsp-gopls-server-args '("-debug" "127.0.0.1:0"))
  :commands (lsp lsp-deferred)
  :config
  (lsp-register-custom-settings
   '(("pyls.plugins.pyls_mypy.enabled" t t)
     ("pyls.plugins.pyls_mypy.live_mode" nil t)
     ("pyls.plugins.pyls_black.enabled" t t)
     ("pyls.plugins.pyls_isort.enabled" t t)))
  )


(use-package lsp-ui
  :ensure t

  ;; If there're errors, download the latest tag i.e tag https://github.com/emacs-lsp/lsp-ui/releases/tag/6.0
  ;; and move it to .emacs/local/..
  ;; :load-path "local/lsp-ui-7.0"

  :commands lsp-ui-mode
  :custom-face (lsp-ui-doc-background ((t (:background ,(face-background 'tooltip)))))
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ("C-c u" . lsp-ui-imenu))
  :init
  (setq lsp-ui-doc-border (face-foreground 'default))
  :config
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-eldoc-enable-hover t)
  )

;;;;;;;;;;;;;;;;;;
;; golang
;;;;;;;;;;;;;;;;;;

(use-package go-eldoc
  :ensure t
  :after go-mode)
  ;; :ensure-system-package (godoc . "go get -u golang.org/x/tools/cmd/godoc"))


(use-package go-mode
  :ensure t
  :config
  (add-hook 'before-save-hook #'lsp-organize-imports)
  (add-hook 'before-save-hook #'lsp-format-buffer)
  (add-hook 'go-mode-hook #'lsp-deferred))


(use-package gotest
  :ensure t
  :after go-mode
  :config
  (define-key go-mode-map (kbd "C-c C-t n") 'go-test-current-file)
  (define-key go-mode-map (kbd "C-c t") 'go-test-current-test)
  (define-key go-mode-map (kbd "C-c C-t p") 'go-test-current-project)
  (define-key go-mode-map (kbd "C-c C-t b") 'go-test-current-benchmark)
  (define-key go-mode-map (kbd "C-c C-t x") 'go-run))

;;;;;;;;;;;;;;;;;;
;; python
;;;;;;;;;;;;;;;;;;

;; install pip
;; pip install pydocstyle pylint rope autopep8 black
(use-package python-mode
  :ensure t
  :mode (("\\.py\\'" . python-mode)
         ("\\.python\\'" . python-mode))
  :config
  (add-hook 'before-save-hook #'lsp-organize-imports)
  (add-hook 'before-save-hook #'lsp-format-buffer)  
  (add-hook 'python-mode-hook #'lsp-deferred))

;;;;;;;;;;;;;;;;;;
;; extensions
;;;;;;;;;;;;;;;;;;

(use-package yaml-mode
  :ensure t
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)))

(use-package json-mode
  :ensure t
  :mode (("\\.json\\'" . json-mode)
         ("\\.tmpl\\'" . json-mode)
         ("\\.eslintrc\\'" . json-mode))
  :config (setq-default js-indent-level 2))

(use-package jsonnet-mode
  :ensure t
  :mode (("\\.jsonnet\\'" . jsonnet-mode)))
  ;; :config
  ;; (add-hook 'jsonnet-mode-hook
  ;;           (lambda () (add-hook 'before-save-hook  #'jsonnet-reformat-buffer)))
  

(use-package json-reformat
  :ensure t
  :after json-mode
  :bind (("C-c r" . json-reformat-region)))

(use-package dockerfile-mode
  :ensure t
  :mode ("Dockerfile\\'" . dockerfile-mode))

(use-package terraform-mode
  :ensure t
  :defer t
  :mode (
         ("\\.tf\\'" . terraform-mode)
         )
  :config
  (add-hook 'terraform-mode-hook
            (lambda () (add-hook 'before-save-hook  #'terraform-format-buffer))))

;;;;;;;;;;;;;;;;;;
;; javascript
;;;;;;;;;;;;;;;;;;
(use-package rjsx-mode
  :ensure t
  :mode ("\\.js\\'"
         "\\.jsx\\'")
  :config
  (setq js2-mode-show-parse-errors nil
        js2-mode-show-strict-warnings nil
        js2-basic-offset 2
        js-indent-level 2)
  (setq-local flycheck-disabled-checkers (cl-union flycheck-disabled-checkers
                                                   '(javascript-jshint))) ; jshint doesn't work for JSX
  (add-hook 'js2-mode-hook #'lsp-format-onsave-hook)

  (electric-pair-mode 1))

(use-package typescript-mode
  :ensure t
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . typescript-mode))
  :config
  (setq-default typescript-indent-level 2)
  (add-hook 'typescript-mode-hook #'lsp-format-onsave-hook))

(use-package add-node-modules-path
  :ensure t
  :defer t
  :hook (((js2-mode rjsx-mode) . add-node-modules-path)))

(use-package prettier-js
  :defer t
  :diminish prettier-js-mode
  :hook (((js2-mode rjsx-mode) . prettier-js-mode)))

;;;;;;;;;;;;;;;;;;
;; clojure
;;;;;;;;;;;;;;;;;;

(use-package clojure-mode
  :ensure t
  :mode  (("\\.clj"  . clojure-mode)
          ("\\.edn"  . clojure-mode)
          ("\\.cljs" . clojurescript-mode)
          ("\\.java" . clojure-mode))
  :config
  (add-hook 'clojure-mode-hook #'smartparens-mode)
  (add-hook 'clojurescript-mode-hook #'smartparens-mode)
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'clojurescript-mode-hook #'rainbow-delimiters-mode)
  )

;; lambda and special chars for clojure

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

  ;; (add-hook 'cider-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'smartparens-mode)
  ;; (add-hook 'cider-mode-hook #'eldoc-mode)
  ;; (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'rainbow-delimiters-mode)

  ;; Fuzzy candidate matching
  ;; (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
  ;; (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion)
  )



(provide 'init-lsp)
