;;-------------------------------------------------
;; Bootstrap package system and use-package
;;-------------------------------------------------
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;-------------------------------------------------
;; Basic UI/UX Tweaks
;;-------------------------------------------------
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(global-display-line-numbers-mode t)

;;-------------------------------------------------
;; Org Mode
;;-------------------------------------------------
(use-package org
  :config
  (setq org-startup-indented t
        org-hide-leading-stars t))

;;-------------------------------------------------
;; Magit (Git)
;;-------------------------------------------------
(use-package magit
  :commands (magit-status))

;;-------------------------------------------------
;; LSP Support with Eglot
;;-------------------------------------------------
(use-package eglot
  :hook ((python-mode . eglot-ensure)
         (c-mode       . eglot-ensure)
         (c++-mode     . eglot-ensure)
         (haskell-mode . eglot-ensure))
  :config
  (setq eglot-autoshutdown t))

;;-------------------------------------------------
;; Python Support
;;-------------------------------------------------
(use-package python-mode)

;;-------------------------------------------------
;; Haskell Support
;;-------------------------------------------------
(use-package haskell-mode)

;;-------------------------------------------------
;; Scheme Support (e.g., Guile or Racket)
;;-------------------------------------------------
(use-package geiser
  :config
  (setq geiser-active-implementations '(guile)))

;;-------------------------------------------------
;; Terminal (vterm)
;;-------------------------------------------------
(use-package vterm
  :if (executable-find "cmake") ;; needed to build vterm
  :commands vterm)

;;-------------------------------------------------
;; Theme
;;-------------------------------------------------
(use-package darkplum-theme
  :ensure t
  :config
  (load-theme 'darkplum t))

;;-------------------------------------------------
;; Evil Mode Core
;;-------------------------------------------------
(use-package evil
  :init
  (setq evil-want-integration t) ;; required for evil-collection
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

;;-------------------------------------------------
;; Evil Collection (extends Evil to other modes)
;;-------------------------------------------------
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;;-------------------------------------------------
;; Evil Surround (cs/ys/ds)
;;-------------------------------------------------
(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

;;-------------------------------------------------
;; Evil Commentary (gcc, gc, etc.)
;;-------------------------------------------------
(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))

;; Optional: evil-org for Vim keys in Org-mode
(use-package evil-org
  :after (evil org)
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

