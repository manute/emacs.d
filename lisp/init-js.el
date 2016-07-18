
;; npm install -g eslint babel-eslint eslint-plugin-react
;; file ~/.eslintrc with these rules -> ;; http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html

(use-package js2-mode
  :ensure t
  :mode (("\\.js\\'" . js2-mode)
         ("\\.jsx\\'" . js2-jsx-mode))
  :config
  (setq flycheck-disable-checker '(javascript-jshint))
  (flycheck-add-mode 'javascript-eslint 'js2-mode)
  (flycheck-add-mode 'javascript-eslint 'js2-jsx-mode))

;; M-x run-skewer for start
(use-package skewer-mode
  :ensure t
  :after js2-mode
  :config
  (add-hook 'js2-mode-hook #'skewer-mode))


(use-package ac-js2
  :ensure t
  :after js2-mode
  :config
  (setq ac-js2-evaluate-calls t)
  (add-hook 'js2-mode-hook #'ac-js2-mode))

(provide 'init-js)
