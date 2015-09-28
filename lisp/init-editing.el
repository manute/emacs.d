
;; THANKS tuxicity-> http://rejeep.github.io/emacs/elisp/2010/03/11/duplicate-current-line-or-region-in-emacs.html

(defun duplicate-current-line-or-region (arg)
    "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
    (interactive "p")
    (let (beg end (origin (point)))
      (if (and mark-active (> (point) (mark)))
          (exchange-point-and-mark))
      (setq beg (line-beginning-position))
      (if mark-active
          (exchange-point-and-mark))
      (setq end (line-end-position))
      (let ((region (buffer-substring-no-properties beg end)))
        (dotimes (i arg)
          (goto-char end)
          (newline)
          (insert region)
          (setq end (point)))
        (goto-char (+ origin (* (length region) arg) arg)))))

(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)


;;http://stackoverflow.com/questions/9688748/emacs-comment-uncomment-current-line
(defun manu/comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (next-line)))

(global-set-key (kbd "C-x c") 'manu/comment-or-uncomment-region-or-line)


;;----------------------------------------------------------------------------
;; Cut/copy the current line if no region is active https://github.com/purcell/emacs.d/blob/master/lisp/init-editing-utils.el
;;----------------------------------------------------------------------------
(require 'whole-line-or-region)
(whole-line-or-region-mode t)
(diminish 'whole-line-or-region-mode)
(make-variable-buffer-local 'whole-line-or-region-mode)

(provide 'init-editing)