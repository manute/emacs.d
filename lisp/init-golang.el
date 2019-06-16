(use-package company-go
  :ensure t)


(use-package go-mode
  :ensure t
  :interpreter "go"
  :mode "\\.go\\'"
  :ensure-system-package (godef . "go get github.com/rogpeppe/godef")
  :ensure-system-package (gocode . "go get -u github.com/nsf/gocode")
  :ensure-system-package (goimports . "go get -u golang.org/x/tools/cmd/goimports")
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (local-set-key (kbd "M-.") #'godef-jump-other-window)))
  (add-hook 'go-mode-hook 'go-eldoc-setup)
  (add-hook 'go-mode-hook (lambda ()
                            (setq tab-width 4 indent-tabs-mode 1)
                            (setq gofmt-command "goimports")
                            (add-hook 'before-save-hook 'gofmt-before-save)
                            (add-hook 'before-save-hook
                                      (lambda ()
                                        (setq-local comment-auto-fill-only-comments t)
                                        (auto-fill-mode 1)))))
  (add-hook 'go-mode-hook 'go-guru-hl-identifier-mode)
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets/go-mode"))


(use-package go-guru
  :ensure t
  :ensure-system-package (guru . "go get golang.org/x/tools/cmd/guru"))


(use-package go-rename
  :ensure t
  :ensure-system-package (guru . "go get golang.org/x/tools/cmd/gorename"))


(use-package go-eldoc
  :ensure t
  :ensure-system-package (godoc . "go get golang.org/x/tools/cmd/godoc"))


(use-package go-dlv
  :ensure t)


(use-package company-go
  :ensure t
  :defer t
  :after (company)
  :config
  (add-to-list 'company-backends 'company-go))


(use-package gotest
  :ensure t
  :after go-mode
  :config
  (define-key go-mode-map (kbd "C-c C-t n") 'go-test-current-file)
  (define-key go-mode-map (kbd "C-c t") 'go-test-current-test)
  (define-key go-mode-map (kbd "C-c C-t p") 'go-test-current-project)
  (define-key go-mode-map (kbd "C-c C-t b") 'go-test-current-benchmark)
  (define-key go-mode-map (kbd "C-c C-t x") 'go-run))


(use-package go-tag
  :ensure t
  :after go-mode
  :ensure-system-package (gomodifytags . "go get -u github.com/fatih/gomodifytags")
  :config
  (define-key go-mode-map (kbd "C-c C-a") #'go-tag-add)
  (define-key go-mode-map (kbd "C-c C-r") #'go-tag-remove))


;; Create a file in ~/.golangci.yaml with this content:
;; run:
;;   tests: true
;;   skip-files:
;;     - ".*/Cellar/go" # the source golang
;;   skip-dirs:
;;     - vendor
;;
;; linters-settings:
;;   lll:
;;     line-length: 100
;;
;; linters:
;;   fast: false

(use-package flycheck-golangci-lint
  :ensure t
  :after go-mode
  :ensure-system-package (golangci-lint . "go get -u github.com/golangci/golangci-lint/cmd/golangci-lint")
  :init  (flycheck-golangci-lint-setup)
  :config
  (setq flycheck-golangci-lint-config "/Users/manute/.golangci.yml"))

;; (use-package gorepl-mode
;;  :ensure t
;;  :after go-mode
;;  :ensure-system-package (gore . "go get -u github.com/motemen/gore")
;;  :diminish gorepl-mode
;;  :init (add-hook 'go-mode-hook #'gorepl-mode))

(provide 'init-golang)
