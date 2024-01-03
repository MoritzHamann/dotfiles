
(use-package emacs
  :init
  (setq inhibit-splash-screen t)
  (setq evil-want-keybinding nil)
  (global-display-line-numbers-mode)
  (setq display-line-numbers-type 'relative)
  (pixel-scroll-precision-mode)

  :bind
  ("C-c p" . project-find-file)

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
  :ensure t
  :config
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
  (company-idle-delay 0.3 "A bit faster autocomplete")
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

(use-package catppuccin-theme
  :ensure t
  :defer t
  :config
  ;;(load-theme 'catppuccin t)
  ;;(catppuccin-load-flavor 'macchiato)
  )

(use-package zenburn-theme
  :ensure t
  :defer t
  :config
  ;;(load-theme 'zenburn t)
)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :defer t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(sanityinc-tomorrow-night))
 '(custom-safe-themes
   '("18cf5d20a45ea1dff2e2ffd6fbcd15082f9aa9705011a3929e77129a971d1cb3" "80214de566132bf2c844b9dee3ec0599f65c5a1f2d6ff21a2c8309e6e70f9242" "6fc9e40b4375d9d8d0d9521505849ab4d04220ed470db0b78b700230da0a86c1" "04aa1c3ccaee1cc2b93b246c6fbcd597f7e6832a97aaeac7e5891e6863236f9f" "b11edd2e0f97a0a7d5e66a9b82091b44431401ac394478beb44389cf54e6db28" "6bdc4e5f585bb4a500ea38f563ecf126570b9ab3be0598bdf607034bb07a8875" "76ddb2e196c6ba8f380c23d169cf2c8f561fd2013ad54b987c516d3cabc00216" "f1882fc093d7af0794aa8819f15aab9405ca109236e5f633385a876052532468" default))
 '(newsticker-url-list nil)
 '(package-selected-packages
   '(zenburn-theme magit lua-mode ivy evil-collection company color-theme-sanityinc-tomorrow catppuccin-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
