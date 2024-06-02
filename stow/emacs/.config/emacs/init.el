
(use-package emacs
  :init
  (setq inhibit-splash-screen t)
  (global-display-line-numbers-mode)
  (setq display-line-numbers-type 'relative)
  (setq evil-want-keybinding nil)
  ;;(pixel-scroll-precision-mode)
  (tool-bar-mode -1)

  :custom
  (scroll-conservatively most-positive-fixnum "Smoother scrolling")
)

(use-package package
  :init
  ; adding MELPA to the package collection
  (add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t))

(use-package evil
  :demand
  :init
  :ensure t
  :config
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-define-key 'normal 'global (kbd "<leader>pp") 'project-switch-project)
  (evil-define-key 'normal 'global (kbd "C-p") 'project-find-file)
  (evil-define-key 'normal 'global (kbd "<leader>pf") 'project-find-file)
  (evil-define-key 'normal 'global (kbd "<leader>pg") 'project-find-regexp)
  (evil-define-key 'normal 'global (kbd "K") 'eldoc)
  (evil-define-key 'insert 'company-mode (kbd "C-<tab>") 'company-complete)
  (evil-mode 1))

(use-package evil-collection
  :demand
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package magit
  :ensure t
  :defer t
  )


(use-package company
  :ensure t
  :defer t
  :hook (prog-mode . company-mode)
  :custom
  (company-idle-delay 0 "A bit faster autocomplete")
  (company-minimum-prefix-length 1 "Provide autocomplete form the first character")
 )

(use-package ivy
  :ensure t
  :config
  (ivy-mode))

(use-package lua-mode
  :ensure t
  :defer t)

(use-package eglot
  :ensure t
  :defer t
  :config
  (add-hook 'eglot-managed-mode-hook (lambda () (eldoc-mode -1))))

(use-package modus-themes
  :ensure t
  :defer t
  )

(use-package slime
  :config
  (slime-setup '(slime-fancy slime-quicklisp slime-asdf slime-mrepl slime-company))
  (setq inferior-lisp-program (executable-find "sbcl"))
)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tsdh-light))
 '(custom-safe-themes
   '("611ef0918b8b413badb8055089b5499c1d4ac20f1861efba8f3bfcb36ad0a448" default))
 '(ede-project-directories '("/Users/moe/Projects/emacs"))
 '(package-selected-packages
   '(slime-company slime fountain-mode zenburn-theme modus-themes material-theme magit lua-mode ivy evil-collection company color-theme-sanityinc-tomorrow catppuccin-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
