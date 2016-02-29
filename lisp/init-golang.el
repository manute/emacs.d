(use-package go-mode
  :ensure t
  :mode ("\\.go\\'" . go-mode)
  :config
  (set (make-local-variable 'company-backends) '(company-go))
  (setq compile-command "go build -v && go test -v && go vet")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
   ;; Key binding to jump to method definition
  (local-set-key (kbd "M-.") #'godef-jump-other-window)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)

  (use-package go-eldoc
    :ensure t
    :config (go-eldoc-setup))

  (use-package gorepl-mode
    :ensure t
    :config (add-hook 'go-mode-hook 'gorepl-mode)))

(provide 'init-golang)
