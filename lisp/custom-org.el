;; THANKS to these files
;; http://www.brool.com/post/using-org-mode-with-gtd/
;; https://github.com/kostajh/.emacs.d/blob/master/customizations/09-org.el
;; https://github.com/xenodium/dotfiles/blob/master/emacs/init.el

(defun gtd ()
  (interactive)
  (find-file "~/org/gtd.org"))


(use-package org
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c c" . org-capture)
         ("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c b" . org-iswitchb)
         ("C-c o o" . gtd))
  :init
  (visual-line-mode)
  (setq org-directory "~/org")

  (setq org-agenda-files
        (list "~/org/gtd.org" "~/org/work.org" "~/org/personal.org" "~/org/eod.org"))

  (setq org-todo-keywords
        '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

  (setq org-src-fontify-natively t
        org-log-done t
        org-return-follows-link t
        org-enforce-todo-dependencies t
        org-use-fast-todo-selection t
        org-confirm-babel-evaluate nil)

  ;; Colors.
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "#d33682" :weight bold)
                ("INPROGRESS" :foreground "#cb4b16" :weight bold)
                ("DONE" :foreground "#859900" :weight bold)
                ("WAITING" :foreground "#b58900" :weight bold)
                ("CANCELLED" :foreground "#859900" :weight bold))))

  ;; Required by code block syntax highlighting.
  (use-package htmlize :ensure t)

  ;;beautify theme special config
  (ignore-errors
    (when (display-graphic-p)
      (use-package org-beautify-theme :ensure t
        :config
        ;; From https://github.com/howardabrams/dot-files/blob/HEAD/emacs-client.org
        (deftheme ar/org-theme "Sub-theme to beautify org mode")
        (let* ((sans-font (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                                ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                                ((x-list-fonts "Verdana")         '(:font "Verdana"))
                                ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
               (base-font-color  (face-foreground 'default nil 'default))
               (background-color (face-background 'default nil 'default))
               (primary-color    (face-foreground 'mode-line nil))
               (secondary-color  (face-background 'secondary-selection nil 'region))
               (headline        `(:inherit default :foreground ,base-font-color))
               (padding         `(:line-width 5 :color ,background-color)))
          (custom-theme-set-faces 'ar/org-theme
                                  `(org-agenda-structure ((t (:inherit default ,@sans-font :height 2.0 :underline nil))))
                                  `(org-level-8 ((t (,@headline ,@sans-font))))
                                  `(org-level-7 ((t (,@headline ,@sans-font))))
                                  `(org-level-6 ((t (,@headline ,@sans-font))))
                                  `(org-level-5 ((t (,@headline ,@sans-font))))
                                  `(org-level-4 ((t (,@headline ,@sans-font :height 1.1   :box ,padding))))
                                  `(org-level-3 ((t (,@headline ,@sans-font :height 1.25  :box ,padding))))
                                  `(org-level-2 ((t (,@headline ,@sans-font :height 1.5   :box ,padding))))
                                  `(org-level-1 ((t (,@headline ,@sans-font :height 1.75  :box ,padding))))
                                  `(org-document-title ((t (,@headline ,@sans-font :height 1.5 :underline nil)))))))))

  (use-package org-bullets
    :ensure t
    :commands org-bullets-mode)

  (add-hook 'org-mode-hook #'org-bullets-mode 1))

(setq org-roam-v2-ack t)

(use-package org-roam
  :ensure t
  :bind (("C-c o r l" . org-roam-buffer-toggle)
         ("C-c o r f" . org-roam-node-find)
         ("C-c o r g" . org-roam-graph)
         ("C-c o r i" . org-roam-node-insert)
         ("C-c o r c" . org-roam-capture)
         ;; Dailies
         ("C-c o r t" . org-roam-dailies-capture-today))
  :custom
  (org-roam-directory "~/org/roam")
  :config
  ;; (org-roam-db-autosync-mode)
  )

(provide 'custom-org)
