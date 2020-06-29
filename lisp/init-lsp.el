
(use-package lsp-mode
  ;; :ensure t

  ;; Download this tag https://github.com/emacs-lsp/lsp-mode/releases/tag/6.3.1
  ;; And move it to .emacs/local/lsp-mode-6.3.1
  :load-path "local/lsp-mode-6.3.1"
  ;; languages
  :hook  (
          (go-mode . lsp-deferred) ;; go get -u golang.org/x/tools/gopls
          (sh-mode . lsp) ;; npm i -g bash-language-server
          (dockerfile-mode . lsp) ;; npm install -g dockerfile-language-server-nodejs
          (yaml-mode . lsp) ;; npm install -g yaml-language-server
          )
  :init
  (setq lsp-auto-guess-root t
        lsp-prefer-flymake nil
        lsp-enable-file-watchers nil
        lsp-idle-delay 0.500
        lsp-prefer-capf t

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
  )


(use-package go-eldoc
  :ensure t
  :ensure-system-package (godoc . "go get -u golang.org/x/tools/cmd/godoc"))

(use-package lsp-ui
  ;; :ensure t

  ;; Download this tag https://github.com/emacs-lsp/lsp-ui/releases/tag/6.0
  ;; And move it to .emacs/local/lsp-mode-6.3.1
  :load-path "local/lsp-ui-6.0"
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


;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))


(use-package go-mode
  :ensure t
  ;; :bind  (
        ;;  ("C-c C-j" . lsp-find-definition)
        ;;  ("C-c C-d" . lsp-describe-thing-at-point)
        ;;  )
  :config
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
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

(provide 'init-lsp)
