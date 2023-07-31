;; MELPA repository
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Skip splash screen
(setq inhibit-startup-screen t)

;; (server-start)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js-indent-level 2)
 '(package-selected-packages '(use-package doom-themes web-mode magit))
 '(safe-local-variable-values
   '((elpy-rpc-backend . "jedi")
     (eval setq virtualenv-default-directory
	   (expand-file-name "."))
     (virtualenv-default-directory . ".")
     (virtualenv-workon . "better_banner"))))
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

;disable menu bar
(tool-bar-mode -1)

;enable showing column numbers on bottom
(column-number-mode +1)

;enable desktop auto saving and loading
(desktop-save-mode 1)
(put 'downcase-region 'disabled nil)

;; Web mode customizations
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-js-indent-level 2)
  (setq web-mode-script-padding 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)


(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(setq doom-theme 'doom-vibrant)
