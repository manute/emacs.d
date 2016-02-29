(use-package go-mode
  :ensure t
  :mode ("\\.go\\'" . go-mode)
  :config

  (when (memq window-system '(mac ns))
    (setenv "PATH" (concat (getenv "PATH") (getenv "GOPATH")))
    (setenv "PATH" (concat (getenv "PATH") (getenv "GOROOT"))))

  (setq compile-command "go build -v && go test -v && go vet")
   ;; Key binding to jump to method definition
  (local-set-key (kbd "M-.") #'godef-jump-other-window)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)

  (use-package company-go
    :ensure t
    :defer t
    :config
    (set (make-local-variable 'company-backends) '(company-go)))

  (use-package go-eldoc
    :ensure t
    :defer t
    :config (go-eldoc-setup))

  (use-package gorepl-mode
    :ensure t
    :defer t
    :config (add-hook 'go-mode-hook 'gorepl-mode)))

(provide 'init-golang)
