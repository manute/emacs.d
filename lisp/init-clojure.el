(require 'ob-clojure)
(require 'cider)
(require 'elein)
(require 'clojure-mode)

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

(define-key clojure-mode-map (kbd "s-i") 'cider-eval-last-sexp)

;; Append result of evaluating previous expression (Clojure):
(defun jj-cider-eval-and-get-value (v)
  (let ((nrepl-sync-request-timeout nil))
  (nrepl-dict-get (nrepl-sync-request:eval v) "value")))

(defun jj-cider-interactive-eval-print (form)
  "Evaluate the given FORM and print value in current buffer."
  (let ((buffer (current-buffer)))
    (cider-eval form
                (cider-eval-print-handler buffer)
                (cider-current-ns))))

(defun jj-cider-eval-last-sexp-and-append ()
  "Evaluate the expression preceding point and append result."
  (interactive)
  (let ((last-sexp (cider-last-sexp)))
    ;; we have to be sure the evaluation won't result in an error
    (jj-cider-eval-and-get-value last-sexp)
    (with-current-buffer (current-buffer)
      (insert ";;=>\n"))
    (jj-cider-interactive-eval-print last-sexp)))


(defun jj-cider-format-with-out-str-pprint-eval (form)
  "Return a string of Clojure code that will return pretty-printed FORM."
  (format "(clojure.core/let [x %s] (with-out-str (clojure.pprint/pprint x)))"
      form))


(defun jj-cider-eval-last-sexp-and-pprint-append ()
  "Evaluate the expression preceding point and append pretty-printed result."
  (interactive)
  (let ((last-sexp (cider-last-sexp)))
    ;; we have to be sure the evaluation won't result in an error
    (with-current-buffer (current-buffer)
      (insert (concat "\n;;=>\n"
                      (read
                        (jj-cider-eval-and-get-value
                         (jj-cider-format-with-out-str-pprint-eval last-sexp))))))))

(defun jj-cider-eval-last-sexp ()
  "Evaluate the expression preceding point and show pretty-printed result in minibuffer"
  (interactive)
  (let ((last-sexp (cider-last-sexp)))
    (message (read
              (jj-cider-eval-and-get-value
               (jj-cider-format-with-out-str-pprint-eval last-sexp))))))

(defun jj-cider-move-forward-and-eval ()
  (interactive)
  (paredit-forward)
  (jj-cider-eval-last-sexp))

(define-key clojure-mode-map (kbd "C-o y") 'jj-cider-eval-last-sexp-and-append)
(define-key clojure-mode-map (kbd "C-o Y") 'jj-cider-eval-last-sexp-and-pprint-append)
(define-key clojure-mode-map (kbd "s-i") 'jj-cider-eval-last-sexp)
(define-key clojure-mode-map (kbd "s-I") 'jj-cider-move-forward-and-eval)

; Clojure mode hooks
(add-hook 'clojure-mode-hook
          '(lambda ()
             (add-hook 'before-save-hook 'whitespace-cleanup nil t)
             (define-clojure-indent
               (defroutes 'defun)
               (GET 2)
               (POST 2)
               (PUT 2)
               (DELETE 2)
               (HEAD 2)
               (ANY 2)
               (context 2))
             (define-clojure-indent
               (mlet 1))))


; Cider mode hooks
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)


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

(add-hook 'cider-mode-hook #'rainbow-delimiters-mode)

;; with global company it is enough
;;(add-hook 'cider-repl-mode-hook #'company-mode)
;;(add-hook 'cider-mode-hook #'company-mode)

(provide 'init-clojure)
