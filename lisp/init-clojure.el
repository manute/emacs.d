(require 'ob-clojure)
(require 'cider)
(require 'elein)
(require 'clojure-mode)
(require 'clj-refactor)

(setq org-babel-clojure-backend 'cider)

; Cider
(setq nrepl-hide-special-buffers t
      cider-repl-pop-to-buffer-on-connect nil
      cider-popup-stacktraces nil
      cider-repl-popup-stacktraces nil)

(define-key clojure-mode-map (kbd "C-x t") 'elein-test)
(define-key clojure-mode-map (kbd "C-o j") 'cider-jack-in)
(define-key clojure-mode-map (kbd "C-o l") 'cider-jack-in-clojurescript)
(define-key clojure-mode-map (kbd "C-o J") 'cider-restart)

; Cider mode hooks
(add-hook 'cider-mode-hook #'cider-turn-on-eldoc-mode)
(add-hook 'cider-mode-hook #'rainbow-delimiters-mode)

;Change lambda chars
(defun change-symbol-specials-chars()
 (dolist (mode '(clojure-mode clojurescript-mode cider-mode))
  (eval-after-load mode
    (font-lock-add-keywords
     mode '(("(\\(fn\\)[\[[:space:]]"  ; anon funcs 1
             (0 (progn (compose-region (match-beginning 1)
                                       (match-end 1) "λ")
                       nil)))
            ("\\(#\\)("                ; anon funcs 2
             (0 (progn (compose-region (match-beginning 1)
                                       (match-end 1) "ƒ")
                       nil)))
            ("\\(#\\){"                 ; sets
             (0 (progn (compose-region (match-beginning 1)
                                       (match-end 1) "∈")
                       nil))))))))

(add-hook 'after-init-hook 'change-symbol-specials-chars)


(defun manu/clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import
    (cljr-add-keybindings-with-prefix "C-c C-n"))


(add-hook 'clojure-mode-hook #'manu/clojure-mode-hook)

(provide 'init-clojure)
