(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))


(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(use-package company
  :defer 2
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :diminish
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))(:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t)
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))


(use-package dashboard
  :ensure t
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  ;;(setq dashboard-startup-banner "~/.config/emacs/images/emacs-dash.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)))
  :custom
  (dashboard-modify-heading-icons '((recents . "file-text")
				      (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

;; XDG CONFIGS

  (defvar xdg-bin (getenv "XDG_BIN_HOME")
  "The XDG bin base directory.")

(defvar xdg-cache (getenv "XDG_CACHE_HOME")
  "The XDG cache base directory.")

(defvar xdg-config (getenv "XDG_CONFIG_HOME")
  "The XDG config base directory.")

(defvar xdg-data (getenv "XDG_DATA_HOME")
  "The XDG data base directory.")

(defvar xdg-lib (getenv "XDG_LIB_HOME")
  "The XDG lib base directory.")

;; SANE DEFAULTS
(delete-selection-mode 1)    ;; You can select text and delete it by typing.
(electric-indent-mode -1)    ;; Turn off the weird indenting that Emacs does by default.
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
;; The following prevents <> from auto-pairing when electric-pair-mode is on.
;; Otherwise, org-tempo is broken when you try to <s TAB...
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(global-auto-revert-mode t)  ;; Automatically show changes if the file has changed
(global-display-line-numbers-mode 1) ;; Display line numbers
(global-visual-line-mode t)  ;; Enable truncated lines
(menu-bar-mode -1)           ;; Disable the menu bar
(scroll-bar-mode -1)         ;; Disable the scroll bar
(tool-bar-mode -1)           ;; Disable the tool bar
(setq org-edit-src-content-indentation 0) ;; Set src block automatic indent to 0 instead of 2.
(setq use-file-dialog nil)   ;; No file dialog
(setq use-dialog-box nil)    ;; No dialog box
(setq pop-up-windows nil)    ;; No popup windows


;; DIMINISH


(use-package diminish)

;; NATIVE COMPILE

;; Silence compiler warnings as they can be pretty disruptive
(if (boundp 'comp-deferred-compilation)
    (setq comp-deferred-compilation nil)
    (setq native-comp-deferred-compilation nil))
;; In noninteractive sessions, prioritize non-byte-compiled source files to
;; prevent the use of stale byte-code. Otherwise, it saves us a little IO time
;; to skip the mtime checks on every *.elc file.
(setq load-prefer-newer noninteractive)

(use-package command-log-mode)

;; IVY

(use-package counsel
  :after ivy
  :diminish
  :config 
    (counsel-mode)
    (setq ivy-initial-inputs-alist nil)) ;; removes starting ^ regex in M-x

(use-package ivy
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :diminish
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

;; IVY-RICH CONFIGURATION
(use-package ivy-rich
  :after ivy
  :ensure t
  :init
  (ivy-rich-mode 1) ;; Enable ivy-rich
  :custom
  (ivy-rich-path-style 'abbrev) ;; Abbreviate file paths
  (ivy-virtual-abbreviate 'full) ;; Show full paths for virtual buffers
  (ivy-rich-switch-buffer-align-virtual-buffer t) ;; Align virtual buffers
  :config
  (setq ivy-rich-display-transformers-list
        '(ivy-switch-buffer
          (:columns
           ((ivy-rich-candidate (:width 30)) ;; Display buffer name
            (ivy-rich-switch-buffer-size (:width 7)) ;; Buffer size
            (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right)) ;; Indicators
            (ivy-rich-switch-buffer-major-mode (:width 12 :face warning)) ;; Major mode
            (ivy-rich-switch-buffer-project (:width 15 :face success)) ;; Project name
            (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x 50)))))) ;; File path
          :predicate
          (lambda (cand) (get-buffer cand))))) ;; Only display for buffers
          
;; IVY-PRESCIENT CONFIGURATION
(use-package ivy-prescient
  :after counsel
  :ensure t
  :custom
  (ivy-prescient-enable-filtering nil) ;; Disable filtering
  :config
  (prescient-persist-mode 1) ;; Remember sorting across sessions
  (ivy-prescient-mode 1)) ;; Enable ivy-prescient

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; DOOM MODELINE

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; FONTS

(set-face-attribute 'default nil
  :font "JetBrainsMono Nerd Font"
  :height 110
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "Ubuntu Nerd Font"
  :height 120
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "JetBrainsMono Nerd Font"
  :height 110
  :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-11"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)

;; DOOM THEMES

;; Don't keep asking to load theme
(setq sml/no-confirm-load-theme t)
(setq custom-safe-themes t)

(use-package doom-themes
  :init (load-theme 'doom-one))

;; ZOOMING IN AND OUT

;; zoom in/out like we do everywhere else.
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; RAINBOW DELIMMITERS

(use-package rainbow-delimiters
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)
         (prog-mode . rainbow-delimiters-mode)))

;; RAINBOW MODE
(use-package rainbow-mode
  :diminish
  :hook org-mode prog-mode)

;; EVIL
;; Expands to: (elpaca evil (use-package evil :demand t))
(use-package evil
    :init      ;; tweak evil's configuration before loading it
    (setq evil-want-integration t  ;; This is optional since it's already set to t by default.
          evil-want-keybinding nil
          evil-vsplit-window-right t
          evil-split-window-below t
          evil-undo-system 'undo-redo)  ;; Adds vim-like C-r redo functionality
    (evil-mode))

(use-package evil-collection
  :after evil
  :config
  ;; Do not uncomment this unless you want to specify each and every mode
  ;; that evil-collection should works with.  The following line is here
  ;; for documentation purposes in case you need it.
  ;; (setq evil-collection-mode-list '(calendar dashboard dired ediff info magit ibuffer))
  (add-to-list 'evil-collection-mode-list 'help) ;; evilify help mode
  (evil-collection-init))

(use-package evil-tutor)

;; Using RETURN to follow links in Org/Evil
;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link t) will not work
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
;; Setting RETURN key in org-mode to follow links
  (setq org-return-follows-link  t)


(use-package which-key
  :init
    (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
	  which-key-sort-order #'which-key-key-order-alpha
	  which-key-allow-imprecise-window-fit nil
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.25
	  which-key-idle-delay 0.8
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit nil
	  which-key-separator " → " ))

;; GENERAL KEY BINDS

(use-package general
  :config
  (general-evil-setup)

  ;; set up 'SPC' as the global leader key
  (general-create-definer dt/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  (dt/leader-keys
    "SPC" '(counsel-M-x :wk "Counsel M-x")
    "." '(find-file :wk "Find file")
    "=" '(perspective-map :wk "Perspective") ;; Lists all the perspective keybindings
    "TAB TAB" '(comment-line :wk "Comment lines")
    "u" '(universal-argument :wk "Universal argument"))

   (dt/leader-keys
    "a" '(:ignore t :wk "A.I.")
    "a a" '(ellama-ask-about :wk "Ask ellama about region")
    "a e" '(:ignore t :wk "Ellama enhance")
    "a e g" '(ellama-improve-grammar :wk "Ellama enhance wording")
    "a e w" '(ellama-improve-wording :wk "Ellama enhance grammar")
    "a i" '(ellama-chat :wk "Ask ellama")
    "a p" '(ellama-provider-select :wk "Ellama provider select")
    "a s" '(ellama-summarize :wk "Ellama summarize region")
    "a t" '(ellama-translate :wk "Ellama translate region"))

  (dt/leader-keys
    "b" '(:ignore t :wk "Bookmarks/Buffers")
    "b b" '(switch-to-buffer :wk "Switch to buffer")
    "b c" '(clone-indirect-buffer :wk "Create indirect buffer copy in a split")
    "b C" '(clone-indirect-buffer-other-window :wk "Clone indirect buffer in new window")
    "b d" '(bookmark-delete :wk "Delete bookmark")
    "b i" '(ibuffer :wk "Ibuffer")
    "b k" '(kill-current-buffer :wk "Kill current buffer")
    "b K" '(kill-some-buffers :wk "Kill multiple buffers")
    "b l" '(list-bookmarks :wk "List bookmarks")
    "b m" '(bookmark-set :wk "Set bookmark")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer")
    "b R" '(rename-buffer :wk "Rename buffer")
    "b s" '(basic-save-buffer :wk "Save buffer")
    "b S" '(save-some-buffers :wk "Save multiple buffers")
    "b w" '(bookmark-save :wk "Save current bookmarks to bookmark file"))

  (dt/leader-keys
    "d" '(:ignore t :wk "Dired")
    "d d" '(dired :wk "Open dired")
    "d f" '(wdired-finish-edit :wk "Writable dired finish edit")
    "d j" '(dired-jump :wk "Dired jump to current")
    "d n" '(neotree-dir :wk "Open directory in neotree")
    "d p" '(peep-dired :wk "Peep-dired")
    "d w" '(wdired-change-to-wdired-mode :wk "Writable dired"))

  (dt/leader-keys
    "e" '(:ignore t :wk "Ediff/Eshell/Eval/EWW")
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-expression :wk "Evaluate and elisp expression")
    "e f" '(ediff-files :wk "Run ediff on a pair of files")
    "e F" '(ediff-files3 :wk "Run ediff on three files")
    "e h" '(counsel-esh-history :which-key "Eshell history")
    "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "e n" '(eshell-new :wk "Create new eshell buffer")
    "e r" '(eval-region :wk "Evaluate elisp in region")
    "e R" '(eww-reload :which-key "Reload current page in EWW")
    "e s" '(eshell :which-key "Eshell")
    "e w" '(eww :which-key "EWW emacs web wowser"))

  (dt/leader-keys
    "f" '(:ignore t :wk "Files")
    "f c" '((lambda () (interactive)
              (find-file "~/.config/emacs/config.org"))
            :wk "Open emacs config.org")
    "f e" '((lambda () (interactive)
              (dired "~/.config/emacs/"))
            :wk "Open user-emacs-directory in dired")
    "f d" '(find-grep-dired :wk "Search for string in files in DIR")
    "f g" '(counsel-grep-or-swiper :wk "Search for string current file")
    "f i" '((lambda () (interactive)
              (find-file "~/.config/emacs/init.el"))
            :wk "Open emacs init.el")
    "f j" '(counsel-file-jump :wk "Jump to a file below current directory")
    "f l" '(counsel-locate :wk "Locate a file")
    "f r" '(counsel-recentf :wk "Find recent files")
    "f u" '(sudo-edit-find-file :wk "Sudo find file")
    "f U" '(sudo-edit :wk "Sudo edit file"))

  (dt/leader-keys
    "g" '(:ignore t :wk "Git")
    "g /" '(magit-displatch :wk "Magit dispatch")
    "g ." '(magit-file-displatch :wk "Magit file dispatch")
    "g b" '(magit-branch-checkout :wk "Switch branch")
    "g c" '(:ignore t :wk "Create")
    "g c b" '(magit-branch-and-checkout :wk "Create branch and checkout")
    "g c c" '(magit-commit-create :wk "Create commit")
    "g c f" '(magit-commit-fixup :wk "Create fixup commit")
    "g C" '(magit-clone :wk "Clone repo")
    "g f" '(:ignore t :wk "Find")
    "g f c" '(magit-show-commit :wk "Show commit")
    "g f f" '(magit-find-file :wk "Magit find file")
    "g f g" '(magit-find-git-config-file :wk "Find gitconfig file")
    "g F" '(magit-fetch :wk "Git fetch")
    "g g" '(magit-status :wk "Magit status")
    "g i" '(magit-init :wk "Initialize git repo")
    "g l" '(magit-log-buffer-file :wk "Magit buffer log")
    "g r" '(vc-revert :wk "Git revert file")
    "g s" '(magit-stage-file :wk "Git stage file")
    "g t" '(git-timemachine :wk "Git time machine")
    "g u" '(magit-stage-file :wk "Git unstage file"))

 (dt/leader-keys
    "h" '(:ignore t :wk "Help")
    "h a" '(counsel-apropos :wk "Apropos")
    "h b" '(describe-bindings :wk "Describe bindings")
    "h c" '(describe-char :wk "Describe character under cursor")
    "h d" '(:ignore t :wk "Emacs documentation")
    "h d a" '(about-emacs :wk "About Emacs")
    "h d d" '(view-emacs-debugging :wk "View Emacs debugging")
    "h d f" '(view-emacs-FAQ :wk "View Emacs FAQ")
    "h d m" '(info-emacs-manual :wk "The Emacs manual")
    "h d n" '(view-emacs-news :wk "View Emacs news")
    "h d o" '(describe-distribution :wk "How to obtain Emacs")
    "h d p" '(view-emacs-problems :wk "View Emacs problems")
    "h d t" '(view-emacs-todo :wk "View Emacs todo")
    "h d w" '(describe-no-warranty :wk "Describe no warranty")
    "h e" '(view-echo-area-messages :wk "View echo area messages")
    "h f" '(describe-function :wk "Describe function")
    "h F" '(describe-face :wk "Describe face")
    "h g" '(describe-gnu-project :wk "Describe GNU Project")
    "h i" '(info :wk "Info")
    "h I" '(describe-input-method :wk "Describe input method")
    "h k" '(describe-key :wk "Describe key")
    "h l" '(view-lossage :wk "Display recent keystrokes and the commands run")
    "h L" '(describe-language-environment :wk "Describe language environment")
    "h m" '(describe-mode :wk "Describe mode")
    "h r" '(:ignore t :wk "Reload")
    "h r r" '((lambda () (interactive)
                (load-file "~/.config/emacs/init.el")
                (ignore (elpaca-process-queues)))
              :wk "Reload emacs config")
    "h t" '(load-theme :wk "Load theme")
    "h v" '(describe-variable :wk "Describe variable")
    "h w" '(where-is :wk "Prints keybinding for command if set")
    "h x" '(describe-command :wk "Display full documentation for command"))

  (dt/leader-keys
    "m" '(:ignore t :wk "Org")
    "m a" '(org-agenda :wk "Org agenda")
    "m e" '(org-export-dispatch :wk "Org export dispatch")
    "m i" '(org-toggle-item :wk "Org toggle item")
    "m t" '(org-todo :wk "Org todo")
    "m B" '(org-babel-tangle :wk "Org babel tangle")
    "m T" '(org-todo-list :wk "Org todo list"))

  (dt/leader-keys
    "m b" '(:ignore t :wk "Tables")
    "m b -" '(org-table-insert-hline :wk "Insert hline in table"))

  (dt/leader-keys
    "m d" '(:ignore t :wk "Date/deadline")
    "m d t" '(org-time-stamp :wk "Org time stamp"))

  (dt/leader-keys
    "o" '(:ignore t :wk "Open")
    "o d" '(dashboard-open :wk "Dashboard")
    "o e" '(elfeed :wk "Elfeed RSS")
    "o f" '(make-frame :wk "Open buffer in new frame")
    "o F" '(select-frame-by-name :wk "Select frame by name"))

  ;; projectile-command-map already has a ton of bindings
  ;; set for us, so no need to specify each individually.
  (dt/leader-keys
    "p" '(projectile-command-map :wk "Projectile"))

  (dt/leader-keys
    "r" '(:ignore t :wk "Radio")
    "r p" '(eradio-play :wk "Eradio play")
    "r s" '(eradio-stop :wk "Eradio stop")
    "r t" '(eradio-toggle :wk "Eradio toggle"))


  (dt/leader-keys
    "s" '(:ignore t :wk "Search")
    "s d" '(dictionary-search :wk "Search dictionary")
    "s m" '(man :wk "Man pages")
    "s o" '(pdf-occur :wk "Pdf search lines matching STRING")
    "s t" '(tldr :wk "Lookup TLDR docs for a command")
    "s w" '(woman :wk "Similar to man but doesn't require man"))

  (dt/leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t e" '(eshell-toggle :wk "Toggle eshell")
    "t f" '(flycheck-mode :wk "Toggle flycheck")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t n" '(neotree-toggle :wk "Toggle neotree file viewer")
    "t o" '(org-mode :wk "Toggle org mode")
    "t r" '(rainbow-mode :wk "Toggle rainbow mode")
    "t t" '(visual-line-mode :wk "Toggle truncated lines")
    "t v" '(vterm-toggle :wk "Toggle vterm"))

  (dt/leader-keys
    "w" '(:ignore t :wk "Windows/Words")
    ;; Window splits
    "w c" '(evil-window-delete :wk "Close window")
    "w n" '(evil-window-new :wk "New window")
    "w s" '(evil-window-split :wk "Horizontal split window")
    "w v" '(evil-window-vsplit :wk "Vertical split window")
    ;; Window motions
    "w h" '(evil-window-left :wk "Window left")
    "w j" '(evil-window-down :wk "Window down")
    "w k" '(evil-window-up :wk "Window up")
    "w l" '(evil-window-right :wk "Window right")
    "w w" '(evil-window-next :wk "Goto next window")
    ;; Move Windows
    "w H" '(buf-move-left :wk "Buffer move left")
    "w J" '(buf-move-down :wk "Buffer move down")
    "w K" '(buf-move-up :wk "Buffer move up")
    "w L" '(buf-move-right :wk "Buffer move right")
    ;; Words
    "w d" '(downcase-word :wk "Downcase word")
    "w u" '(upcase-word :wk "Upcase word")
    "w =" '(count-words :wk "Count words/lines for buffer"))
)

 ;; Using garbage magic hack.
 (use-package gcmh
   :config
   (gcmh-mode 1))
;; Setting garbage collection threshold
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; Silence compiler warnings as they can be pretty disruptive (setq comp-async-report-warnings-errors nil)


;; PROJECTILE

(use-package projectile
  :diminish projectile-mode
  :config
  (progn
    (projectile-mode 1) ;; Enable projectile-mode
    (projectile-global-mode 1)) ;; Enable global mode (if desired, but it’s not necessary with the latest projectile versions)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config
  (counsel-projectile-mode 1))


 ;; MAGIT
(use-package transient)

 (use-package magit
  :after transient
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; GIT TIMEMACHINE
(use-package git-timemachine
  :after git-timemachine
  :hook (evil-normalize-keymaps . git-timemachine-hook)
  :config
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-j") 'git-timemachine-show-previous-revision)
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-k") 'git-timemachine-show-next-revision)
)


;; ORG MODE

(setq org-directory "~/Org/"
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "
        org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-log-done 'time
        org-hide-emphasis-markers t
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
          '(("google" . "http://www.google.com/search?q=")
            ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
            ("ddg" . "https://duckduckgo.com/?q=")
            ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-table-convert-region-max-lines 20000
    )

;; ORG FONTS

;; Enable variable-pitch mode in Org Mode, but keep code blocks and tables fixed pitch
(defun my/org-mode-setup ()
  (variable-pitch-mode 0)
  (set-face-attribute 'org-table nil :family "JetBrains Mono" :weight 'normal :height 110)
  (set-face-attribute 'org-code nil :family "JetBrains Mono" :weight 'normal :height 110)
  (set-face-attribute 'org-block nil :family "JetBrains Mono" :weight 'normal :height 110)
  (set-face-attribute 'org-verbatim nil :family "JetBrains Mono" :weight 'normal :height 110))

(add-hook 'org-mode-hook 'my/org-mode-setup)


(add-hook 'org-mode-hook
          (lambda ()
            (set-face-attribute 'org-indent nil
                                :inherit '(org-hide fixed-pitch))))

;; ORG HEADERS

(defun my-org-mode-customizations ()
  "Customizations for Org mode."
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.7))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.6))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.5))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.4))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.3))))
   '(org-level-6 ((t (:inherit outline-5 :height 1.2))))
   '(org-level-7 ((t (:inherit outline-5 :height 1.1))))))
(add-hook 'org-mode-hook 'my-org-mode-customizations)


;; ORG BULLETS

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; ORG AGENDA

(with-eval-after-load 'org
  (setq org-agenda-files '("~/Org/agenda.org"))
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "ASSIGNMENT(a)" "PROJECT(q)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(A)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
        '(("Archive.org" :maxlevel . 1)
          ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling
  (advice-add 'org-refile :after #'org-save-all-org-buffers))


  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "ASSIGNMENT"
        ((org-agenda-overriding-header "Assignments")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("a" "Assignments"
     ((todo "ASSIGNMENT"
        ((org-agenda-overriding-header "Assignments")))))

    ("u" "Uni Tasks" tags-todo "+uni-email")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "PROJECT"
            ((org-agenda-overriding-header "Projects")
             (org-agenda-files org-agenda-files)))
      (todo "ASSIGNMENT"
            ((org-agenda-overriding-header "Active Assignments")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))
;; ORG ROAM
;; Org-roam configuration
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/RoamNotes")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i"    . completion-at-point))
  :config
  (org-roam-setup))

;; ORG ROAM UI

(use-package websocket
    :after org-roam)

(use-package org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; ORG BABEL
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (emacs-lisp . nil)
   (python . t)))

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

  ;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

;; CCLS

(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode c-ts-mode c++-ts-mode) .
         (lambda () (require 'ccls) (lsp))))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package hl-todo
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

;; LSP MODE

(defun efs/lsp-mode-setup ()
  "Custom LSP setup for Emacs."
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((lsp-mode . efs/lsp-mode-setup)
         (lsp-mode . lsp-enable-which-key-integration)
         (LaTeX-mode . lsp-deferred)
         (c-mode . lsp)
         (c-ts-mode . lsp)
         (c++-mode . lsp)
         (c++-ts-mode . lsp)
         (python-mode . lsp)
         (go-mode . lsp)
         (rustic-mode . lsp)
         (rust-ts-mode . lsp)
)  ;; Directly hook rustic-mode to lsp
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (setq lsp-tex-server 'texlab)
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-inlay-hint-enable t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)

;; TYPESCRIPT MDOE
(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

;; CCLS

 (use-package ccls

:ensure t

:config

(setq ccls-executable "ccls")

(setq lsp-prefer-flymake nil)

(setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))

:hook ((c-mode c++-mode objc-mode c-ts-mode c++-ts-mode) .

	(lambda () (require 'ccls) (lsp))))

;; PYTHON

(use-package python-mode
  :ensure t
  :hook ((python-mode . lsp-deferred)(python-ts-mode . lsp-deferred))
  :custom
  ;; NOTE: Set these if Python 3 is called "python3" on your system!
  ;; (python-shell-interpreter "python3")
  ;; (dap-python-executable "python3")
  (dap-python-debugger 'debugpy)
  :config
  (require 'dap-python))

(use-package pyvenv
  :after python-mode
  :config
  (pyvenv-mode 1))

;; GIT GUTTER
;; Enable git-gutter globally for all buffers
(setq git-gutter:enabled t)

;; Enable git-gutter-fringe for displaying in the fringe area (instead of gutter)
(use-package git-gutter-fringe
  :ensure t
  :config
  (global-git-gutter-mode +1)  ;; Enable git-gutter globally
  (setq git-gutter:modified-sign "│")  ;; Symbol for modified lines
  (setq git-gutter:added-sign "+")     ;; Symbol for added lines
  (setq git-gutter:deleted-sign "-")   ;; Symbol for deleted lines
  (setq git-gutter:window-width 2)     ;; Width of the gutter
  (setq git-gutter:update-interval 2)) ;; How often to update the gutter

;; BROWSER FIX

(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "firefox")
;;(setq browse-url-browser-function 'browse-url-default-macosx-browser)


;; CENTAUR TABS

(use-package centaur-tabs
  :init
  (setq centaur-tabs-enable-key-bindings t)
  :config
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 32
        centaur-tabs-set-icons t
        centaur-tabs-show-new-tab-button t
        centaur-tabs-set-modified-marker t
        centaur-tabs-show-navigation-buttons t
        centaur-tabs-set-bar 'under
        centaur-tabs-show-count nil
        ;; centaur-tabs-label-fixed-length 15
        ;; centaur-tabs-gray-out-icons 'buffer
        ;; centaur-tabs-plain-icons t
        x-underline-at-descent-line t
        centaur-tabs-left-edge-margin nil)
  (centaur-tabs-change-fonts (face-attribute 'default :font) 110)
  (centaur-tabs-headline-match)
  ;; (centaur-tabs-enable-buffer-alphabetical-reordering)
  ;; (setq centaur-tabs-adjust-buffer-order t)
  (centaur-tabs-mode t)
  (setq uniquify-separator "/")
  (setq uniquify-buffer-name-style 'forward)
  (defun centaur-tabs-buffer-groups ()
    "`centaur-tabs-buffer-groups' control buffers' group rules.

Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
All buffer name start with * will group to \"Emacs\".
Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list
     (cond
      ;; ((not (eq (file-remote-p (buffer-file-name)) nil))
      ;; "Remote")
      ((or (string-equal "*" (substring (buffer-name) 0 1))
           (memq major-mode '(magit-process-mode
                              magit-status-mode
                              magit-diff-mode
                              magit-log-mode
                              magit-file-mode
                              magit-blob-mode
                              magit-blame-mode
                              )))
       "Emacs")
      ((derived-mode-p 'prog-mode)
       "Editing")
      ((derived-mode-p 'dired-mode)
       "Dired")
      ((memq major-mode '(helpful-mode
                          help-mode))
       "Help")
      ((memq major-mode '(org-mode
                          org-agenda-clockreport-mode
                          org-src-mode
                          org-agenda-mode
                          org-beamer-mode
                          org-indent-mode
                          org-bullets-mode
                          org-cdlatex-mode
                          org-agenda-log-mode
                          diary-mode))
       "OrgMode")
      (t
       (centaur-tabs-get-group-name (current-buffer))))))
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  ("C-S-<prior>" . centaur-tabs-move-current-tab-to-left)
  ("C-S-<next>" . centaur-tabs-move-current-tab-to-right)
  (:map evil-normal-state-map
        ("g t" . centaur-tabs-forward)
        ("g T" . centaur-tabs-backward)))


;; LOCALE SETTINGS

(setenv "LANG" "en_US.UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")

;; SNIPPETS

;; Install and configure yasnippet
(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)  ;; Enable yasnippet globally
  :config
  (setq yas-snippet-dirs '("~/.config/emacs/snippets" ;; Your custom snippets directory
                           ;; You can add others here as needed
                           )
        yas-trigger-key "TAB")  ;; You can change the keybinding if necessary
  )

;; Install yasnippet-snippets
(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)  ;; Make sure yasnippet is loaded before loading snippets

;; FLYCHECK
(use-package flycheck
  :ensure t
  :defer t
  :diminish
  :init (global-flycheck-mode))

;; TREEMACS

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-files-by-mouse-dragging    t
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

;; LATEX

;; Ensure AUCTeX is installed and properly loaded
;; Ensure AUCTeX is installed and properly loaded
(use-package auctex
  :ensure t
  :defer t
  :config
  ;; Enable AUCTeX features
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-save-query nil ;; Automatically save before compilation
        TeX-show-compilation nil)) ;; Don't show the compilation buffer


;; Add latexmk as a custom TeX command
(defun my-latexmk-setup ()
  "Setup latexmk for automatic compilation."
  ;; Add latexmk to the TeX-command-list if not already present
  (add-to-list 'TeX-command-list
               '("LatexMk" "latexmk -pdf -interaction=nonstopmode %s"
                 TeX-run-TeX nil t
                 :help "Run latexmk on the file"))
  ;; Set latexmk as the default command for LaTeX compilation
  (setq TeX-command-default "LatexMk"))

;; Run latexmk automatically on save
(defun auto-compile-with-latexmk ()
  "Run latexmk automatically when a LaTeX file is saved."
  (when (and (derived-mode-p 'latex-mode) ;; Check for LaTeX mode
             (not (TeX-process-running-p))) ;; Ensure no active TeX process
    (save-excursion
      (let ((TeX-show-compilation nil)) ;; Temporarily suppress compilation buffer
        (TeX-command "LatexMk" 'TeX-master-file -1)))))

;; Helper function to check if a TeX process is running
(defun TeX-process-running-p ()
  "Return non-nil if a TeX process is running for the current buffer."
  (let ((process (TeX-active-process)))
    (and process (process-live-p process))))

;; Hook setup
(add-hook 'LaTeX-mode-hook #'my-latexmk-setup)
(add-hook 'after-save-hook #'auto-compile-with-latexmk)

;; Optional: Set latexmk as the default TeX command
(setq TeX-command-default "LatexMk")

;; RUSTIC

(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook)

  :hook ((rustic-mode . lsp-deferred)(rust-ts-mode . lsp-deferred))  ;; Use deferred LSP initialization for rustic
 )

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (add-hook 'before-save-hook 'lsp-format-buffer nil t))

;; PDF TOOLS

(use-package pdf-tools
  :defer t
  :commands (pdf-loader-install)
  :mode "\\.pdf\\'"
  :bind (:map pdf-view-mode-map
              ("j" . pdf-view-next-line-or-next-page)
              ("k" . pdf-view-previous-line-or-previous-page)
              ("C-=" . pdf-view-enlarge)
              ("C--" . pdf-view-shrink))
  :init (pdf-loader-install)
  :config (add-to-list 'revert-without-query ".pdf"))

(add-hook 'pdf-view-mode-hook #'(lambda () (interactive) (display-line-numbers-mode -1)
                                                         (blink-cursor-mode -1)
                                                         (doom-modeline-mode -1)))

;; VISUAL FILL MODE

(use-package pdf-tools
  :defer t
  :commands (pdf-loader-install)
  :mode "\\.pdf\\'"
  :bind (:map pdf-view-mode-map
              ("j" . pdf-view-next-line-or-next-page)
              ("k" . pdf-view-previous-line-or-previous-page)
              ("C-=" . pdf-view-enlarge)
              ("C--" . pdf-view-shrink))
  :init (pdf-loader-install)
  :config (add-to-list 'revert-without-query ".pdf"))

(add-hook 'pdf-view-mode-hook #'(lambda () (interactive) (display-line-numbers-mode -1)
                                                         (blink-cursor-mode -1)
                                                         (doom-modeline-mode -1)))
