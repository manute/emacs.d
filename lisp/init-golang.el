;; Install these tools:
;; - https://github.com/nsf/gocode
;; - https://github.com/bradfitz/goimports
;; - https://github.com/buaazp/Godef
;; - https://github.com/motemen/gore

(use-package go-mode
  :ensure t
  :bind ( "M-." . godef-jump-other-window)
  :mode ("\\.go\\'" . go-mode)
  :config
  (add-hook 'go-mode-hook  (lambda ()
                             (setq tab-width 4)
                             (setq gofmt-command "goimports")
                             (setq compile-command "go build -v && go test -v && go vet")))
  (add-hook 'before-save-hook #'gofmt-before-save))

(use-package company-go
  :ensure t
  :after go-mode
  :config
  (add-hook 'go-mode-hook 'company-mode)
  (add-hook 'go-mode-hook (lambda ()
                             (set (make-local-variable 'company-backends) '(company-go))
                             (company-mode))))

(use-package go-eldoc
  :ensure t
  :after go-mode
  :diminish eldoc-mode
  :init (add-hook 'go-mode-hook #'go-eldoc-setup))

(use-package gorepl-mode
  :ensure t
  :after go-mode
  :diminish gorepl-mode
  :init (add-hook 'go-mode-hook #'gorepl-mode))

(provide 'init-golang)
