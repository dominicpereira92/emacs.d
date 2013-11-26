;;; Dynamic cursor configuration

(defun configure-cursor ()
  (let* ((is-line-overflow
          (> (current-column) 70))
         (cur-color
          (cond (buffer-read-only "dark sea green")
                (is-line-overflow "tan")
                (overwrite-mode "yellow")
                (t "green")))
         (cur-type
          (cond (buffer-read-only 'box)
                ((and overwrite-mode
                      god-local-mode)
                 'hollow)
                ((or god-local-mode
                     overwrite-mode)
                 'box)
                (t 'bar))))
    (progn
      (setq cursor-type cur-type)
      (set-cursor-color cur-color))))

(setq cursor-in-non-selected-windows nil)
(add-hook 'post-command-hook 'configure-cursor)

(provide 'config-cursor)