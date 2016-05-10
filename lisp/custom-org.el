;; http://www.brool.com/post/using-org-mode-with-gtd/

(use-package org
  :ensure t
  :mode (("\\.org\\'" . org-mode))
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (emacs-lisp . t)
     (python . t)
     (sh . t)
     (clojure . t)
     (haskell . t)
     (ruby . t)
     (js . t)
     (java . t)))

  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)

  (setq org-agenda-files
        (list "~/org/gtd.org" "~/org/work.org" "~/org/personal.org"))

  ;; TODO keywords
  (setq org-todo-keywords
        '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

  ;; Customizations
  (setq org-enforce-todo-dependencies t
        org-confirm-babel-evaluate nil
        org-return-follows-link t)

  ;; Aesthetics
  (setq org-src-fontify-natively t)

  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "red" :weight bold)
                ("INPROGRESS" :foreground "blue" :weight bold)
                ("DONE" :foreground "forest green" :weight bold)
                ("WAITING" :foreground "orange" :weight bold)
                ("HOLD" :foreground "magenta" :weight bold)
                ("CANCELLED" :foreground "forest green" :weight bold)
                ("MEETING" :foreground "forest green" :weight bold)
                ("PHONE" :foreground "forest green" :weight bold))))

  (setq org-use-fast-todo-selection t)

  (setq org-log-done 'time)


  (use-package org-bullets
    :ensure t
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))))


(provide 'custom-org)
