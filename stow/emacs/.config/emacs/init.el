; adding MELPA to the package collection
(use-package emacs
  :init
  (setq inhibit-splash-screen t)
  (setq global-display-line-numbers-mode t)
  (setq evil-want-keybinding nil)
)

(use-package package
  :init
  (add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t))


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
  :ensure t)

(use-package company
  :ensure t
  :custom
  (company-idle-delay 0.3 "A bit faster autocomplete")
  (company-minimum-prefix-length 1 "Provide autocomplete form the first character")
 )
  


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wheatgrass))
 '(newsticker-url-list nil)
 '(package-selected-packages '(evil-collection company evil use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
