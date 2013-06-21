(setq inhibit-startup-screen t)
;; (server-start)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((elpy-rpc-backend . "jedi") (eval setq virtualenv-default-directory (expand-file-name ".")) (virtualenv-default-directory . ".") (virtualenv-workon . "better_banner")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)

;; Everything Below this I've written myself.
; Set ctrl+c ctrl+z to adjust adornment in rst
(eval-after-load "rst-mode"
                 (global-set-key (kbd "C-c C-z") 'rst-adjust-adornment))

;disable backup
(setq backup-inhibited t)

;disable auto save
(setq auto-save-default nil)

;always keep buffers up to date
(global-auto-revert-mode +1)

;disable menu bar
(menu-bar-mode -1)

;enable showing column numbers on bottom
(column-number-mode +1)

;enable desktop auto saving and loading
(desktop-save-mode 1)
