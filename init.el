(setq inhibit-startup-screen t)
(setq inhibit-splash-screnn t)
(setq initila-buffer-choice nil)
(setq blink-match-paren t)
(global-linum-mode t)
(show-paren-mode)

;; β ε \ set-input-methods   or C-x 8 (ucs-insert)  
(defun open-init()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f1>") #'open-init)

(defun load-init()
  (interactive)
  (load "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") #'load-init)

(setq tool-bar-mode nil)
(dired "~")
;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Removes *scratch* from buffer after the mode has been set.
;; (defun remove-scratch-buffer ()
;;   (if (get-buffer "*scratch*")
;;       (kill-buffer "*scratch*")))
;; (add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; ;; Removes *messages* from the buffer.
;; (setq-default message-log-max nil)
;; (kill-buffer "*Messages*")

;; ;; Removes *Completions* from buffer after you've opened a file.
;; (add-hook 'minibuffer-exit-hook
;;       '(lambda ()
;;          (let ((buffer "*Completions*"))
;;            (and (get-buffer buffer)
;;                 (kill-buffer buffer)))))

;; ;; Don't show *Buffer list* when opening multiple files at the same time.
;; ;; (setq inhibit-startup-buffer-menu t)

;; ;; Show only one active window when opening multiple files at the same time.
;; (add-hook 'window-setup-hook 'delete-other-windows)

(defun remove-buffer-if-exists(name)
  (and (get-buffer name)
       (kill-buffer name)))

(add-hook 'after-change-major-mode-hook #'(lambda()
					    (and (get-buffer "*scratch*")
						 (kill-buffer "*scratch*"))))
(remove-buffer-if-exists "*Message*")
(add-hook 'minibuffer-exit-hook #'(lambda()
				    (remove-buffer-if-exists "*Completions*")))

(defun quit-help-window()
  (interactive)
  (delete-window (get-buffer-window "*Help*"))
  (remove-buffer-if-exists "*Help*"))
(global-set-key (kbd "<f3>") #'quit-help-window)


(setq initial-frame-alist '((top . 50)
			    (left . 100)
			    (height . 50)
			    (width . 100)))

(defun open-package-archive-dir()
  (interactive)
  (dired "~/.emacs.d/elpa/"))
(global-set-key (kbd "<f4>") #'open-package-archive-dir)

(setq package-archives '(("gnu" . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(setq package-list '(general evil use-package elisp-slime-nav company))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(eval-when-compile
  (require 'use-package))

(use-package evil
  :config
  (evil-mode)
  )

;; (use-package general)
(require 'general)

(use-package company
  :config
  (global-company-mode)
  )

(general-def 'motion
  "C-e" #'move-end-of-line
  "C-a" #'move-beginning-of-line)

(defun oo-elisp-mode-hook()
  (use-package elisp-slime-nav)
  (turn-on-elisp-slime-nav-mode)
  (general-def 'normal
    "M-," #'pop-tag-mark
    "M-." #'elisp-slime-nav-find-elisp-thing-at-point)
  (make-local-variable 'company-backends)
  (setq company-backends '(company-capf)))
(add-hook 'emacs-lisp-mode-hook #'oo-elisp-mode-hook)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (elisp-slime-nav use-package evil general))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

