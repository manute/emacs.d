(require 'groovy-mode)
(require 'inf-groovy)

(add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))

(setq groovy-home "~/.gvm/groovy/current")

(defun indent-groovy-mode ()
  (setq indent-tabs-mode nil
        c-basic-offset 4))

(add-hook 'groovy-mode-hook
          '(lambda ()
             (auto-complete-mode)
             (indent-groovy-mode)))

;;;------------------
;;; Inferior groovy
;;;------------------

;; (add-hook 'inf-groovy-mode-hook 'auto-complete-mode)

;; (eval-after-load "auto-complete"
;;   '(add-to-list 'ac-modes 'inf-groovy-mode))

;; (eval-after-load "inf-groovy"
;;   '(define-key inferior-groovy-mode-map (kbd "TAB") 'auto-complete))


(provide 'init-groovy)
