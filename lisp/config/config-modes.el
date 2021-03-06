;;; Configuration for god-mode, modeline, frame/cursor

(use-package god-mode
  :ensure t
  :diminish god-local-mode
  :commands (modes/set-god-mode
             modes/set-mode-line-format)
  :config

  (defun modes/set-god-mode (god-mode-key god-mode-all-key)
    (bind-key god-mode-key 'god-local-mode)
    (bind-key god-mode-all-key 'god-mode-all)
    (add-to-list 'god-exempt-major-modes 'dired-mode)
    (bind-key "." 'repeat god-local-mode-map)
    (bind-key "z" 'repeat god-local-mode-map)
    (bind-key "i" 'god-local-mode god-local-mode-map)
    (bind-key "M-i" 'god-local-mode)
    (god-mode))

  (defun god-toggle-on-overwrite ()
    (if (bound-and-true-p overwrite-mode)
        (god-local-mode-pause)
      (god-local-mode-resume)))

  (defun modes/set-mode-line-format ()
    (add-to-list 'default-mode-line-format
                 (quote (:eval (propertize (if (and (boundp 'god-local-mode) god-local-mode) "^" " "))))))

  (add-to-list 'god-exempt-major-modes 'Custom-mode)
  (add-to-list 'god-exempt-major-modes 'ag-mode)
  (add-to-list 'god-exempt-major-modes 'compilation-mode)
  (add-to-list 'god-exempt-major-modes 'debugger-mode)
  (add-to-list 'god-exempt-major-modes 'dired-mode)
  (add-to-list 'god-exempt-major-modes 'ediff-mode)
  (add-to-list 'god-exempt-major-modes 'eww-mode)
  (add-to-list 'god-exempt-major-modes 'geben-breakpoint-list-mode)
  (add-to-list 'god-exempt-major-modes 'ibuffer-mode)
  (add-to-list 'god-exempt-major-modes 'org-agenda-mode)
  (add-to-list 'god-exempt-major-modes 'recentf-dialog-mode)
  (add-to-list 'god-exempt-major-modes 'wdired-mode)

  (add-hook 'overwrite-mode-hook 'god-toggle-on-overwrite))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :bind (("C-' k" . which-key-mode)
         ("C-' C-k" . which-key-mode))
  :config
  (which-key-setup-minibuffer)
  (setq max-mini-window-height 0.3)
  (which-key-mode t)

  (use-package god-mode
    :config
    (defvar config-which-key--timer nil)

    (defun config-god-mode-cancel-timer (&rest e)
      (if config-which-key--timer
          (cancel-timer config-which-key--timer)))

    (defun config-god-mode-lookup-key-sequence (f &rest args)
      (if (car args)
          (progn
            (config-god-mode-cancel-timer nil)
            (setq config-which-key--timer
                  (run-with-idle-timer
                   which-key-idle-delay nil
                   (lambda (prefix-key)
                     (which-key--create-buffer-and-show prefix-key))
                   (kbd (car args)))))))

    (defun config-which-key-mode-hook ()
      (if which-key-mode
          (progn
            (advice-add 'god-mode-lookup-key-sequence :before 'config-god-mode-lookup-key-sequence)
            (advice-add 'god-mode-lookup-command :after 'config-god-mode-cancel-timer)
            (advice-add 'command-error-default-function :after 'config-god-mode-cancel-timer))
        (progn
          (advice-remove 'god-mode-lookup-key-sequence 'config-god-mode-lookup-key-sequence)
          (advice-remove 'god-mode-lookup-command 'config-god-mode-cancel-timer)
          (advice-remove 'command-error-default-function 'config-god-mode-cancel-timer))))

    (add-hook 'which-key-mode-hook 'config-which-key-mode-hook)))

(use-package frame
  :bind (("C-x C-5 C-0" . delete-frame)
         ("C-x C-5 C-1" . delete-other-frames)
         ("C-x C-5 C-2" . make-frame-command))
  :init
  (custom-set-variables
   '(echo-keystrokes 0.05)
   '(cursor-in-non-selected-windows nil))

  :config

  (defun configure-cursor ()
    (let* ((is-line-overflow
            (> (current-column) 70))
           (is-god-mode
            (and (boundp 'god-local-mode)
                 god-local-mode))
           (cur-color
            (cond (buffer-read-only "Gray")
                  (is-line-overflow "IndianRed")
                  (overwrite-mode "yellow")
                  (t "green")))
           (cur-type
            (cond (buffer-read-only 'box)
                  ((and overwrite-mode
                        is-god-mode)
                   'hollow)
                  ((or is-god-mode
                       overwrite-mode)
                   'box)
                  (t 'bar))))
      (progn
        (setq cursor-type cur-type)
        (set-cursor-color cur-color)
        (set-face-background 'mode-line cur-color)
        (set-face-attribute 'mode-line-buffer-id nil :background cur-color))))

  (custom-set-faces
   '(cursor ((t (:background "green")))))

  (add-hook 'post-command-hook 'configure-cursor)
  (blink-cursor-mode t))

(use-package multiple-cursors
  :ensure t
  :bind (("C-<" . mc/mark-previous-like-this)
         ("C->" . mc/mark-next-like-this)
         ("C-c C-<f3>" . mc/mark-all-like-this)
         ("C-c C->" . mc/mark-all-like-this)
         ("C-x <C-return>" . mc/edit-lines)
         ("C-x RET RET" . set-rectangular-region-anchor)))

(use-package desktop
  :config
  (desktop-save-mode t))

(provide 'config-modes)
