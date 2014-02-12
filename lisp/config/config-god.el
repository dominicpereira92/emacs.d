;;; Configuration for God Mode

(require 'god-mode)

(defun set-god-mode (god-mode-key)
  (progn
    (global-unset-key (kbd god-mode-key))
    (global-set-key (kbd god-mode-key) 'god-local-mode)
    (add-to-list 'god-exempt-major-modes 'dired-mode)
    (define-key god-local-mode-map (kbd ".") 'repeat)
    (define-key god-local-mode-map (kbd "i") 'god-local-mode)
    (god-mode)))

(defun god-toggle-on-overwrite ()
  (if (bound-and-true-p overwrite-mode)
      (god-local-mode-pause)
    (god-local-mode-resume)))

(add-hook 'overwrite-mode-hook 'god-toggle-on-overwrite)

(provide 'config-god)
