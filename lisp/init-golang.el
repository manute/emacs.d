(use-package go-mode
  :ensure t
  :bind ( "M-." . godef-jump-other-window)
  :mode ("\\.go\\'" . go-mode)
  :config

  (when (memq window-system '(mac ns))
    (setenv "PATH" (concat (getenv "PATH") (getenv "GOPATH")))
    (setenv "PATH" (concat (getenv "PATH") (getenv "GOROOT"))))

  (setq compile-command "go build -v && go test -v && go vet")
  (setq gofmt-command "goimports")
  (add-hook 'go-mode-hook #'flycheck-mode)
  (add-hook 'before-save-hook #'gofmt-before-save)

  (use-package company-go
    :ensure t
    :config
    (add-hook 'go-mode-hook 'company-mode)
    (add-hook 'go-mode-hook (lambda ()
                              (set (make-local-variable 'company-backends) '(company-go))
                              (company-mode))))

  (use-package go-eldoc
    :ensure t
    :diminish eldoc-mode
    :config (add-hook 'go-mode-hook #'go-eldoc-setup))

  (use-package gorepl-mode
    :ensure t
    :diminish gorepl-mode
    :config (add-hook 'go-mode-hook #'gorepl-mode)))

(provide 'init-golang)
