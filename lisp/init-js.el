;; https://emacs.cafe/emacs/javascript/setup/2017/05/09/emacs-setup-javascript-2.html
;; https://emacs.cafe/emacs/javascript/setup/2017/04/23/emacs-setup-javascript.html
;; needs to install ag https://github.com/ggreer/the_silver_searcher

(use-package js2-mode
  :ensure t
  :mode (("\\.js\\'" . js2-mode)
         ("\\.spec.js\\'" . js2-mode)
         ("\\.jsx\\'" . js2-jsx-mode))
  :config
  (setq-default tab-width 2)
  (setq-default js2-basic-offset 2)

  (setq-default js2-mode-indent-ignore-first-tab t)
  (setq-default js2-show-parse-errors nil)
  (setq-default js2-strict-inconsistent-return-warning nil)
  (setq-default js2-strict-var-hides-function-arg-warning nil)
  (setq-default js2-strict-missing-semi-warning nil)
  (setq-default js2-strict-trailing-comma-warning nil)
  (setq-default js2-strict-cond-assign-warning nil)
  (setq-default js2-strict-var-redeclaration-warning nil)

  (sp-with-modes '(js2-mode js2-jsx-mode)
    (sp-local-pair "<" ">"))

  (setq flycheck-disable-checker '(javascript-jshint))
  (flycheck-add-mode 'javascript-eslint 'js2-mode)
  (flycheck-add-mode 'javascript-eslint 'js2-jsx-mode))


(use-package add-node-modules-path
  :ensure t
  :after js2-mode
  :config
  (add-hook 'js-mode-hook #'add-node-modules-path))

(use-package prettier-js
  :ensure t
  :after js2-mode
  :config
  (setq prettier-js-args '(
                           "--use-tabs" "false"
                           "--tab-width" "2"
                           "--trailing-comma" "none"
                           "--bracket-spacing" "true"
                           "--jsx-bracket-same-line" "false"
                           "--single-quote" "false"
                           "--print-width" "80"
                           ))
  (add-hook 'js2-mode-hook 'prettier-js-mode))

(use-package tern
  :ensure t
  :after js2-mode
  :config
  (add-hook 'js2-mode-hook (lambda ()
                             (tern-mode)
                             (company-mode))))

(use-package xref-js2
  :ensure t
  :after js2-mode
  :config
  (define-key js-mode-map (kbd "M-.") nil)
  (add-hook 'js2-mode-hook (lambda ()
                             (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t))))

(provide 'init-js)
