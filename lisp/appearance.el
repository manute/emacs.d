

;; LOAD THEME ON WINDOW SYSTEM
(when window-system
  (load-theme 'atom-one-dark t))

;;TOMORROW THEME on CONSOLE MODE
(when (not window-system)
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/themes"))
  (require 'color-theme-tomorrow)
  (color-theme-tomorrow--define-theme night))




;; SMART LINE
(setq sml/no-confirm-load-theme t)
(sml/setup)
(setq sml/theme 'respectful)

(when (eq system-type 'darwin)
  (set-face-attribute 'default nil :height 150 :family "consolas")
  (setq mac-allow-anti-aliasing t))  ;; nice fonts in OS X

;; (set-face-attribute 'default nil :height 130)
(setq-default truncate-lines 1)  ;; no word wrap
(setq-default line-spacing 4)


;; http://www.masteringemacs.org/articles/2012/09/10/hiding-replacing-modeline-strings/
(defvar mode-line-cleaner-alist
  `((smartparens-mode . " ()")
    (eldoc-mode . "")
    (abbrev-mode . "")
    ;; Major modes
    (help-mode . "？")
    (fundamental-mode . "∅")
    (lisp-interaction-mode . "λ")
    (python-mode . "Py")
    (clojure-mode . "λ")
    (emacs-lisp-mode . "λ")))


(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                 (mode-str (cdr cleaner))
                 (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
                 (setcar old-mode-str mode-str))
               ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

(provide 'appearance)
