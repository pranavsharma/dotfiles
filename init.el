;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; my .emacs file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq load-path
      (cons "C:\\Users\\prs\\AppData\\Roaming\\.emacs.d\\site-lisp" load-path))
(setq load-path
      (cons "~/.emacs.d/site-lisp" load-path))

(setq exec-path (append exec-path '("C:\\Users\\prs\\MySoftware\\")))
(setq exec-path (append exec-path '("C:\\Users\\prs\\MySoftware\\bin")))
(setq exec-path (append exec-path '("C:\\ProgramData\\chocolatey\\bin")))
(setq exec-path (append exec-path '("C:\\Program Files\\LLVM\\bin\\")))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

; tramp mode
;(setq tramp-default-method "plink")
; shortcut to cleanup tramp connections
;(global-set-key (kbd "C-c C-t") 'tramp-cleanup-all-connections)

;; helm
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
                                        ;(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
                                        ;(global-set-key (kbd "C-c s") 'helm-ag-project-root)
(global-set-key (kbd "C-c s") 'helm-rg-project-root)

                                        ; recent files
(require 'recentf)
(recentf-mode 1)
(global-set-key "\C-x\C-r" 'recentf-open-files)
(setq column-number-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comint-scroll-to-bottom-on-input t)
 '(compilation-message-face (quote default))
 '(cursor-type t)
 '(custom-safe-themes
   (quote
    ("e491d84f66d5d540e8459e9af173789d6b70e42a57b2a537823441b6921b39bd" "274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(display-time-day-and-date t)
 '(electric-pair-mode 1)
 '(frame-background-mode (quote dark))
 '(helm-buffer-max-length 40)
 '(ido-mode t nil (ido))
 '(inhibit-startup-screen t)
 '(magit-diff-use-overlays nil)
 '(menu-bar-mode t)
 '(package-selected-packages
   (quote
    (warm-night-theme fill-column-indicator aggressive-indent dracula-theme rg company helm-ag magit solarized-theme find-file-in-repository ag clang-format dumb-jump cmake-mode ace-window helm-cscope xcscope markdown-mode helm csharp-mode protobuf-mode)))
 '(recentf-auto-cleanup (quote never))
 '(recentf-max-saved-items 1000)
 '(ring-bell-function (quote ignore))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (file-exists-p (buffer-file-name)) (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files.") )

(global-auto-revert-mode t)

(add-hook 'text-mode-hook 'auto-fill-mode)
(setq-default fill-column 80)

(global-set-key "\C-xr" 'remember)

(global-set-key "\C-l" 'goto-line)
(display-time)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(setq-default indent-tabs-mode nil)
(global-set-key (kbd "M-o") 'ace-window)

(require 'cc-mode)

;; clang-format
(require 'clang-format)
(global-set-key (kbd "C-c i") 'clang-format-region)
(global-set-key (kbd "C-c u") 'clang-format-buffer)
(setq clang-format-style-option "Google")

(global-set-key (kbd "C-c o") 'ff-find-other-file)

(global-set-key (kbd "C-c g") 'dumb-jump-go)
(global-set-key (kbd "<f12>") 'dumb-jump-go)
(global-set-key (kbd "C-c p") 'dumb-jump-back)
(global-set-key (kbd "C-\-") 'dumb-jump-back)
(global-set-key (kbd "C-c q") 'dumb-jump-quick-look)
(setq dumb-jump-selector 'helm)

(rg-define-search rg-search-all :files "all" :dir project)
(global-set-key (kbd "C-c ,") 'rg-search-all)
;;(global-set-key (kbd "C-c ,") 'ag-project)
(global-set-key (kbd "C-x f") 'find-file-in-repository)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-c m d") 'magit-diff)
(global-set-key (kbd "C-c m l") 'magit-log)
(global-hl-line-mode 1)
;;(set-face-background hl-line-face "#333333")
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq shell-scroll-to-bottom-on-input t)

;; Google C++ style guide
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "<f8>") 'next-error)
(global-set-key (kbd "<f7>") 'compile)

(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (indent-buffer)
        (message "Indented buffer.")))))

(global-set-key (kbd "C-c n") 'indent-region-or-buffer)
(global-linum-mode)
;;(load-theme 'warm-night t)
(load-theme 'dracula t)

(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 110 :family "Consolas")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TIPS n TRICKS
;; C-C M-o to clear shell
;; use C-s to navigate elements of the ido-mode
;; To search for a word in the file without copying it put your cursor at the start
;; of the word and hit C-s C-w
;; C-x h -- select entire buffer
;; C-x C-f C-f - kicks you out of ido mode - useful when you want to create a new file
;; To repeat the previous command once, type C-x z.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
