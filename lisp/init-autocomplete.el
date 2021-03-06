
(defun company-mode/backend-with-yas (backend)
  (if (and (listp backend) (member 'company-yasnippet backend))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

;; THANKS to lunaryorn https://github.com/lunaryorn/.emacs.d/blob/master/init.el
(use-package company
  :ensure t
  :defer t
  :diminish company-mode
  :init
  (setq completion-at-point-functions '(company-complete-common))
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-idle-delay nil) ; never start completions automatically
  (global-set-key (kbd "TAB") #'company-indent-or-complete-common)

  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

  (setq company-minimum-prefix-length 2
        company-selection-wrap-around t
        company-show-numbers t
        company-tooltip-align-annotations t
        company-require-match nil))


(use-package company-quickhelp          ; Show help in tooltip
  :ensure t
  :after company
  :config (company-quickhelp-mode))

(use-package company-statistics         ; Sort company candidates by statistics
  :ensure t
  :defer t
  :after company
  :config (company-statistics-mode))


(use-package company-emoji              ; Emojis completion like Github/Slack
  :ensure t
  :defer t
  :after company
  :config (add-to-list 'company-backends 'company-emoji))


(defcustom display-icon (display-graphic-p)
  "Display icons or not."
  :group 'icons
  :type 'boolean)

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode)
  :defines company-box-icons-all-the-icons
  :hook (company-mode . company-box-mode)
  :init (setq company-box-enable-icon display-icon
              company-box-backends-colors nil
              company-box-highlight-prefix t))

(provide 'init-autocomplete)
