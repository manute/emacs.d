
;; npm install -g eslint babel-eslint eslint-plugin-react
;; file ~/.eslintrc with these rules -> ;; http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html

(use-package js2-mode
  :ensure t
  :mode (("\\.js\\'" . js2-mode)
         ("\\.jsx\\'" . js2-jsx-mode))
  :config
  (setq flycheck-disable-checker '(javascript-jshint))
  (flycheck-add-mode 'javascript-eslint 'js2-mode)
  (flycheck-add-mode 'javascript-eslint 'js2-jsx-mode)

  ;; (setq-default js2-mode-indent-ignore-first-tab t)
  (setq-default tab-width 2)
  (setq-default js2-basic-offset 2)

  (sp-with-modes '(js2-mode js2-jsx-mode)
    (sp-local-pair "<" ">")))


;; Add $NPMBIN path as env and copy with exec-path for getting 'prettier'
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns))
  :after js2-mode
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "NPMBIN"))

(use-package prettier-js
  :after js2-mode
  :init  (setq prettier-target-mode "js2-mode")
  :config
  (setq prettier-args '("--trailing-comma" "all"
                        "--bracket-spacing" "false"))
  (add-hook 'js2-mode-hook
            (lambda ()
              (add-hook 'before-save-hook #'prettier-before-save))))


(use-package ac-js2
  :ensure t
  :after js2-mode
  :config
  (setq ac-js2-evaluate-calls t)
  (add-hook 'js2-mode-hook #'ac-js2-mode))

(provide 'init-js)
