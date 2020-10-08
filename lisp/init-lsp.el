
(use-package lsp-mode
  ;; :ensure t

  ;; If there're errors, download the lastest tag i.e https://github.com/emacs-lsp/lsp-mode/releases/tag/7.0.1
  ;; And move it to .emacs/local/..
  :load-path "local/lsp-mode-7.0"

  ;; languages
  :hook  (
          (go-mode . lsp-deferred) ;; go get -u golang.org/x/tools/gopls
          (sh-mode . lsp) ;; npm i -g bash-language-server
          (dockerfile-mode . lsp) ;; npm install -g dockerfile-language-server-nodejs
          (yaml-mode . lsp) ;; npm install -g yaml-language-server
          (elixir-mode . lsp) ;; https://elixirforum.com/t/emacs-elixir-setup-configuration-wiki/19196
          (python-mode . lsp)
          )
  :init
  ;; https://elixirforum.com/t/emacs-elixir-setup-configuration-wiki/19196
  (add-to-list 'exec-path "/Users/manute/go/src/github.com/elixir-ls/release/")

  (setq lsp-auto-guess-root t
        lsp-prefer-flymake nil
        lsp-enable-file-watchers nil
        lsp-eldoc-render-all t
        lsp-idle-delay 0.500
        lsp-prefer-capf t
        lsp-pyls-plugins-flake8-enabled t

        ;; https://github.com/emacs-lsp/lsp-mode/issues/1778
        ;; lsp-gopls-codelens nil
        )
  ;; :ensure-system-package
  ;; (
  ;;  (gopls . "go get golang.org/x/tools/gopls@latest")
  ;;  )
  :bind (:map lsp-mode-map
              ("C-c C-j" . lsp-find-definition)
              ("C-c C-d" . lsp-describe-thing-at-point)
              )
  ;; uncomment to enable gopls http debug server
  ;; :custom (lsp-gopls-server-args '("-debug" "127.0.0.1:0"))
  :commands (lsp lsp-deferred)
  :config
  ;; Configure LSP clients
  (use-package lsp-clients)
  (lsp-register-custom-settings
   '(("pyls.plugins.pyls_mypy.enabled" t t)
     ("pyls.plugins.pyls_mypy.live_mode" nil t)
     ("pyls.plugins.pyls_black.enabled" t t)
     ("pyls.plugins.pyls_isort.enabled" t t)))
  )


(use-package go-eldoc
  :ensure t
  :ensure-system-package (godoc . "go get -u golang.org/x/tools/cmd/godoc"))

(use-package lsp-ui
  ;; :ensure t

  ;; If there're errors, download the latest tag i.e tag https://github.com/emacs-lsp/lsp-ui/releases/tag/6.0
  ;; and move it to .emacs/local/..
  :load-path "local/lsp-ui-7.0"

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
  (setq lsp-eldoc-enable-hover t))


(use-package company-lsp
  :ensure t
  :commands company-lsp
  :requires company
  ;; :init (setq company-lsp-cache-candidates 'auto)
  :config
  (push 'company-lsp company-backends)
  ;; Disable client-side cache because the LSP server does a better job.
  (setq company-transformers nil
        company-lsp-async t
        company-lsp-cache-candidates nil))


;; (defun lsp-format-onsave-hook ()
;;   (add-hook #'before-save-hook #'lsp-format-buffer t t))

(use-package format-all
  :ensure t
  :config
  (add-hook #'before-save-hook #'format-all-mode))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-hooks ()
  ;; (lsp-format-onsave-hook)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))


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
  (add-hook 'elixir-mode-hook #'lsp-format-onsave-hook))

;; install pip
;; pip install pydocstyle pylint rope autopep8 black
(use-package python-mode
  :ensure t)

;; (use-package pyvenv
;;   :ensure t
;;   :config
;;   (setq pyvenv-workon "emacs")  ; Default venv
;;   (pyvenv-tracking-mode 1))  ; Automatically use pyvenv-workon via dir-locals


(provide 'init-lsp)
