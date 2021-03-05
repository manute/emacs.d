(use-package lsp-mode
  :commands lsp
  :ensure t
  :diminish lsp-mode

  ;; If there're errors, download the lastest tag i.e https://github.com/emacs-lsp/lsp-mode/releases/tag/7.0.1
  ;; And move it to .emacs/local/..
  ;; :load-path "local/lsp-mode-7.0"

  ;; languages
  :hook  (
          (go-mode . lsp-deferred) ;; go get -u golang.org/x/tools/gopls
          (sh-mode . lsp-deferred) ;; npm i -g bash-language-server
          (dockerfile-mode . lsp-deferred) ;; npm install -g dockerfile-language-server-nodejs
          (yaml-mode . lsp-deferred) ;; npm install -g yaml-language-server
          (elixir-mode . lsp) ;; https://elixirforum.com/t/emacs-elixir-setup-configuration-wiki/19196
          (python-mode . lsp-deferred) ;; https://github.com/palantir/python-language-server
          (json-mode . lsp-deferred) ;; npm i -g vscode-json-languageserve
          (yaml-mode . lsp-deferred) ;; npm install -g yaml-language-server
          (terraform-mode . lsp-deferred) ;; go get github.com/juliosueiras/terraform-lsp
          ((js2-mode rjsx-mode typescript-mode) . lsp-deferred) ;; https://www.chadstovern.com/javascript-in-emacs-revisited/
  )
  :init
  ;; 1. git clone https://github.com/elixir-lsp/elixir-ls.git
  ;; 2. cd elixir-ls (that you just cloned)
  ;; 3. mix deps.get
  ;; 4. mix elixir_ls.release
  ;; 5. point here the path for release
  (add-to-list 'exec-path "/Users/manute/go/src/github.com/elixir-ls/release")

  (setq lsp-auto-guess-root t
        lsp-prefer-flymake nil
        lsp-enable-file-watchers nil
        lsp-eldoc-render-all t
        lsp-idle-delay 0.500
        lsp-pyls-plugins-flake8-enabled t
        lsp-completion-provider :capf
        lsp-gopls-codelens nil)

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


(use-package go-eldoc
  :ensure t
  :ensure-system-package (godoc . "go get -u golang.org/x/tools/cmd/godoc"))


;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-hooks ()
  ;; added on lsp
  (add-hook #'before-save-hook #'lsp-format-buffer t t)
  (add-hook #'before-save-hook #'lsp-organize-imports t t))


(use-package go-mode
  :ensure t
  :config
  (add-hook 'go-mode-hook #'lsp-go-hooks)
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

(use-package elixir-mode
  :ensure t
  :config
  (add-hook 'elixir-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'elixir-format nil t)
            (add-hook 'after-save-hook 'alchemist-iex-reload-module)
            ))

  (add-hook 'elixir-mode-hook #'rainbow-delimiters-mode)
  )

(use-package alchemist
  :ensure t
  :hook (elixir-mode . alchemist-mode)
  :config
  (setq alchemist-mix-env "dev")
  (setq alchemist-hooks-compile-on-save t)
  (setq al)
  )


(use-package exunit
  :ensure t
  :hook (elixir-mode . exunit-mode))


;; install pip
;; pip install pydocstyle pylint rope autopep8 black
(use-package python-mode
  :ensure t
  :config
  (add-hook 'python-mode-hook #'lsp-format-onsave-hook)
  (add-hook 'python-mode-hook #'lsp-deferred))


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

(use-package json-reformat
  :ensure t
  :after json-mode
  :bind (("C-c r" . json-reformat-region)))

(use-package dockerfile-mode
  :ensure t
  :mode ("Dockerfile\\'" . dockerfile-mode))

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


(provide 'init-lsp)
