(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(use-package evil
  :ensure t
  :init
  (evil-mode 1))

(use-package linum-relative
  :ensure t
  :init
  (linum-relative-global-mode))

(use-package nord-theme
  :ensure t
  :init
  (load-theme 'nord t)
  (add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/")))

(use-package company
  :ensure t
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
  (company-selection-wrap-around t)
  :init
  (company-tng-configure-default)
  (global-company-mode))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :ensure t)

(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook
  (rjsx-mode lsp)
  (typescript-mode lsp))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :after (lsp-mode flycheck))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

(use-package company-lsp
  :ensure t
  :after (lsp-mode company-mode)
  :init (company-lsp)
  :commands company-lsp)

(use-package rjsx-mode
  :mode "\\jsx?\\'"
  :custom
  (js-indent-level 2)
  (sgml-basic-offset 2)
  :ensure t)

(use-package web-mode
  :ensure t
  :after (lsp)
  :init
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (flycheck-add-mode 'typescript-tslint 'web-mode)
  (add-hook 'web-mode-hook (lambda ()
	      (when (string-equal "tsx" (file-name-extension buffer-file-name))
		(lsp)))))

(use-package projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (projectile-mode 1))

(use-package magit
  :ensure t)

(use-package evil-magit
  :ensure t
  :after (magit))

(use-package helm
  :ensure t
  :init
  (helm-mode)
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-b" . helm-buffers-list)
  ("C-x C-f" . helm-find-files))

(use-package helm-projectile
  :ensure t
  :after (helm projectile)
  :init
  (helm-projectile-on))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 1)
 '(company-selection-wrap-around t)
 '(js-indent-level 2)
 '(linum-relative-global-mode t)
 '(package-selected-packages
   (quote
    (yasnippet helm-projectile helm evil-magit magit projectile linum-relative rjsx-mode web-mode lsp-ui flycheck company-lsp lsp-mode typescript-mode company nord-theme evil use-package)))
 '(sgml-basic-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
