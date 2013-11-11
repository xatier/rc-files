; disable tool-bar-mode
(setq tool-bar-mode -1)

;; cololum and line number on minibuffer
(setq column-number-mode t)
(setq line-number-mode t)

; no startup message
(setq inhibit-startup-message t)

; image file mode
(setq auto-image-file-mode t)

; display time
(display-time-mode t)
(setq display-time-24hr-format t)

; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

; show match parenthsis
(show-paren-mode t)

; selection-highlighting
(transient-mark-mode t)

; no TAB!, use C-q TAB
(setq indent-tabs-mode nil)
(setq default-tab-width 4)

; color in shell-mode
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)

; always use bash in ansi-term
(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)


; anti idle for BBS
(defvar antiidle)
(defun enable-anti-idle ()
  (interactive)
    (setq antiidle
      (run-with-timer 0 180 '(lambda ()
        (term-send-up)
          (term-send-down)))))

(defun disable-anti-idle ()
  (interactive)
    (cancel-timer antiidle))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; plugins
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/")

; irc clinet on emacs
(require 'erc)

; git-emacs
(add-to-list 'load-path "~/.emacs.d/plugins/git-emacs")
(require 'git-emacs)

; ibuffer-mode
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

; ido
(require 'ido)
(ido-mode t)

; desktop
(load "desktop")
(desktop-load-default)
(desktop-read)


;; python-mode
(add-to-list 'load-path "~/.emacs.d/plugins/python-mode")
(autoload 'python-mode "python-mode" "Python editing mode." t)

