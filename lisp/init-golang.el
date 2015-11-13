(require 'go-mode)
(require 'gorepl-mode)

(defun go-run-buffer()
  (interactive)
  (shell-command (concat "go run " (buffer-name))))

(defun go-kill()
  (interactive)
  (if (go-mode-in-string)
      (paredit-kill-line-in-string)
    (paredit-kill)))

(defun go-backward-delete()
  (interactive)
  (if (go-mode-in-string)
      (paredit-backward-delete-in-string)
    (paredit-backward-delete)))


(defun go-mode-setup ()
  (set (make-local-variable 'company-backends) '(company-go))
  (setq compile-command "go build -v && go test -v && go vet")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
   ;; Key binding to jump to method definition
  (local-set-key (kbd "M-.") #'godef-jump-other-window)
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))


(add-hook 'go-mode-hook 'go-mode-setup)
(add-hook 'go-mode-hook 'gorepl-mode)

(provide 'init-golang)
