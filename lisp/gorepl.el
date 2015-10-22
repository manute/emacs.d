
(defgroup gorepl nil
  "GO repl interactive"
  :prefix "gorepl-"
  :group 'applications
  :link '(url-link :tag "Github" "https://github.com/manute/gorepl-mode")
  :link '(emacs-commentary-link :tag "Commentary" "gorepl"))


(defcustom gorepl-command
  "gore"
  "The command used to execute gore."
  :type 'string
  :group 'gorepl)


(defconst gorepl-version "0.1.0-snapshot")
(defconst gorepl-buffer "*Go REPL*")
(defconst gorepl-buffer-name "Go REPL")


(defvar gorepl-arguments '()
  "Commandline arguments to pass to `gorepl'")


(defun gorepl-version ()
  "Display GOREPL's version."
  (interactive)
  (message "GOREPL %s" gorepl-version))


;; https://github.com/magnars/s.el
(require 's)
(require 'go-mode)

;; MANY THANKS to masteringenmacs -> https://www.masteringemacs.org/article/comint-writing-command-interpreter
(defun gorepl-run ()
  "Run an inferior instance of `gore' inside Emacs."
  (interactive)
  (let* ((buffer (comint-check-proc gorepl-buffer-name)))
    ;; pop to the "*go-repl-buffer*" buffer if the process is dead, the
    ;; buffer is missing or it's got the wrong mode.
    (pop-to-buffer
     (if (or buffer (not (derived-mode-p 'gorepl-mode))
             (comint-check-proc (current-buffer)))
         (get-buffer-create (or buffer gorepl-buffer))
       (current-buffer)))
    ;; create the comint process if there is no buffer.
    (unless buffer
      (apply 'make-comint-in-buffer gorepl-buffer-name buffer
             gorepl-command gorepl-arguments)
      (gorepl-mode))))


(read-)


(defun gorepl--send-string (s)
  "Send string to gore repl process and return the output."
  (with-current-buffer (get-buffer gorepl-buffer)
    ;;insert into gorepl as comment for visual representation
    (insert (concat "/*" s "*/"))
    (comint-send-string (get-buffer-process gorepl-buffer) s)
    (comint-send-input)))


(defun gorepl-eval-region ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (gorepl--send-string (filter-buffer-substring (region-beginning)
                                                (region-end))))



;;;###autoload
(define-minor-mode gorepl-mode
  "A minor mode for run a go repl"
  :lighter " gorepl"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c g") 'gorepl-run)
            (define-key map (kbd "C-x C-e") 'gorepl-eval-region)
            map))


(provide 'gorepl)
