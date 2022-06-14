(use-package flycheck
  :ensure t
  :defer t
  ;; :bind ("C-," . global-flycheck-mode)
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode)
  :config
  (setq flycheck-global-modes '(not emacs-lisp-mode lisp-mode magit-mode sql-mode))
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc clojure-cider-typed))
  ;; Jump between current errors with M-n and M-p.
  (global-set-key (kbd "M-n") 'next-error)
  (global-set-key (kbd "M-p") 'previous-error)

  ;; https://github.com/koalaman/shellcheck
  ;; brew install shellcheck
  (add-hook 'sh-mode-hook 'flycheck-mode))

;; https://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun manu/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))


(use-package flycheck-color-mode-line
  :ensure t
  :after flycheck
  :config
  (setq flycheck-highlighting-mode 'symbols)
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

  ;; dark mode
  (set-face-background 'flycheck-error "#660000")
  (set-face-foreground 'flycheck-error nil)
  (set-face-background 'flycheck-warning "#331800")
  (set-face-foreground 'flycheck-warning nil)
  (set-face-background 'flycheck-color-mode-line-error-face "#440000")
  (set-face-background 'flycheck-color-mode-line-warning-face "#553300")
  (set-face-background 'flycheck-color-mode-line-info-face nil)
  (set-face-foreground 'flycheck-color-mode-line-error-face "#ffffff")
  (set-face-foreground 'flycheck-color-mode-line-warning-face "#ffffff")
  (set-face-foreground 'flycheck-color-mode-line-info-face nil)

  ;; light mode
  ;; (set-face-background 'flycheck-error "#ff8888")
  ;; (set-face-foreground 'flycheck-error nil)
  ;; (set-face-background 'flycheck-warning "#ffcc88")
  ;; (set-face-foreground 'flycheck-warning nil)
  ;; (set-face-background 'flycheck-color-mode-line-error-face "#ff0000")
  ;; (set-face-foreground 'flycheck-color-mode-line-error-face "#ffffff")
  ;; (set-face-background 'flycheck-color-mode-line-warning-face "#886600")
  ;; (set-face-foreground 'flycheck-color-mode-line-warning-face "#ffffff")
  ;; (set-face-background 'flycheck-color-mode-line-info-face nil)
  ;; (set-face-foreground 'flycheck-color-mode-line-info-face nil)

  (add-hook 'flycheck-mode-hook #'manu/use-eslint-from-node-modules))


(provide 'init-flycheck)
