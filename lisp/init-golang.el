;; Install these tools:
;; go get -u github.com/nsf/gocode
;; go get -u golang.org/x/tools/cmd/goimports
;; go get -u github.com/rogpeppe/godef
;; go get -u golang.org/x/tools/cmd/guru
;; go get -u github.com/motemen/gore
;; go get -u github.com/fatih/gomodifytags

;; https://github.com/golangci/golangci-lint -> flycheck linters

(use-package go-mode
  :ensure t
  :bind ("M-." . godef-jump-other-window)
  :mode ("\\.go\\'" . go-mode)
  :config
  (add-hook 'go-mode-hook  (lambda ()
                             (setq tab-width 4)
                             (setq gofmt-command "goimports")
                             (setq compile-command "go build -v && go test -v && go vet")))
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets/go-mode")
  (add-hook 'before-save-hook #'gofmt-before-save))

(use-package company-go
  :ensure t
  :after go-mode
  :config
  (add-hook 'go-mode-hook 'company-mode)
  (add-hook 'go-mode-hook (lambda ()
                            (set (make-local-variable 'company-backends) '(company-go))
                            (company-mode)))
  (setq company-tooltip-align-annotations t))

(use-package go-eldoc
  :ensure t
  :after go-mode
  :diminish eldoc-mode
  :init (add-hook 'go-mode-hook #'go-eldoc-setup))

(use-package go-tag
  :ensure t
  :after go-mode
  :config
  (define-key go-mode-map (kbd "C-c t") #'go-tag-add)
  (define-key go-mode-map (kbd "C-c T") #'go-tag-remove))

(use-package flycheck-golangci-lint
  :ensure t
  :after go-mode
  :init  (flycheck-golangci-lint-setup)
  :config
  (setq flycheck-golangci-lint-deadline "20s")
  (setq flycheck-golangci-lint-tests t)

  ;; `fast` avoids slow checkers but some of them are useful
  ;; (setq flycheck-golangci-lint-fast t)
  )

;; (use-package gorepl-mode
;;  :ensure t
;;  :after go-mode
;;  :diminish gorepl-mode
;;  :init (add-hook 'go-mode-hook #'gorepl-mode))

(provide 'init-golang)
