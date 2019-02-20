;; Install these tools:
;; go get -u github.com/nsf/gocode
;; go get -u golang.org/x/tools/cmd/goimports
;; go get -u github.com/rogpeppe/godef
;; go get -u golang.org/x/tools/cmd/guru
;; go get -u github.com/motemen/gore
;; go get -u github.com/fatih/gomodifytags

;; https://github.com/golangci/golangci-lint -> flycheck linters

(defun my-go-mode-hook ()
      (local-set-key (kbd "M-.") #'godef-jump)
      (add-hook 'before-save-hook 'gofmt-before-save)

      ; extra keybindings from https://github.com/bbatsov/prelude/blob/master/modules/prelude-go.el
      (let ((map go-mode-map))
        (define-key map (kbd "C-c a") 'go-test-current-project) ;; current package, really
        (define-key map (kbd "C-c m") 'go-test-current-file)
        (define-key map (kbd "C-c .") 'go-test-current-test)
        (define-key map (kbd "C-c b") 'go-run)))

(use-package go-mode
  :ensure t
  :mode ("\\.go\\'" . go-mode)
  :config
  (add-hook 'go-mode-hook 'my-go-mode-hook)

  ;; (add-hook 'before-save-hook #'gofmt-before-save)
  ;; (add-hook 'go-mode-hook  (lambda ()
  ;;                            (setq tab-width 4)
  ;;                            (setq gofmt-command "goimports")
  ;;                            (setq compile-command "go build -v && go test -v && go vet")))
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets/go-mode"))

(use-package company-go
  :ensure t
  :after go-mode
  :config
  ;; (add-hook 'go-mode-hook 'company-mode)
  ;; (add-hook 'go-mode-hook (lambda ()
  ;;                           (set (make-local-variable 'company-backends) '(company-go))
  ;;                           (company-mode)))
  (add-hook 'go-mode-hook 'company-mode)
  (add-to-list 'company-backends 'company-go)
  (setq company-tooltip-align-annotations t))


(use-package gotest
  :ensure t
  :after go-mode
  :config
  (define-key go-mode-map (kbd "C-c C-t n") 'go-test-current-file)
  (define-key go-mode-map (kbd "C-c t") 'go-test-current-test)
  (define-key go-mode-map (kbd "C-c C-t p") 'go-test-current-project)
  (define-key go-mode-map (kbd "C-c C-t b") 'go-test-current-benchmark)
  (define-key go-mode-map (kbd "C-c C-t x") 'go-run))

(use-package go-eldoc
  :ensure t
  :after go-mode
  :diminish eldoc-mode
  :init (add-hook 'go-mode-hook #'go-eldoc-setup))

(use-package go-tag
  :ensure t
  :after go-mode
  :config
  (define-key go-mode-map (kbd "C-c C-a") #'go-tag-add)
  (define-key go-mode-map (kbd "C-c C-r") #'go-tag-remove))

(use-package flycheck-golangci-lint
  :ensure t
  :after go-mode
  :init  (flycheck-golangci-lint-setup)
  :config
  (setq flycheck-golangci-lint-deadline "8s")
  (setq flycheck-golangci-lint-tests t)
  ;; `fast` avoids slow checkers but some of them are useful
  (setq flycheck-golangci-lint-fast t))

;; (use-package gorepl-mode
;;  :ensure t
;;  :after go-mode
;;  :diminish gorepl-mode
;;  :init (add-hook 'go-mode-hook #'gorepl-mode))

(provide 'init-golang)
