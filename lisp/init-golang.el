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
  (setq compile-command "go build -v && go test -v && go vet")
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook #'gofmt-before-save))

(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns))
  :after go-mode
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOROOT")
  (exec-path-from-shell-copy-env "GOPATH"))


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

;; (use-package gorepl-mode
;;   :ensure t
;;   :after go-mode
;;   :diminish gorepl-mode
;;   :init (add-hook 'go-mode-hook #'gorepl-mode))

(provide 'init-golang)
