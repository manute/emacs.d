(require 'org)

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
   (java . t)
   ))

(setq org-agenda-files (list "~/org/work.org"
                             "~/org/school.org"
                             "~/org/home.org"))


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


(provide 'custom-org)
