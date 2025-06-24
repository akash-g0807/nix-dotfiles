{ config, pkgs, userSettings, ... }:

{

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk; # or emacs-gtk, if you prefer
    extraPackages = epkgs: with epkgs; [
      all-the-icons
      magit
      use-package
      all-the-icons-dired
      company
      company-box
      dashboard
      diminish
      command-log-mode
      counsel
      ivy
      all-the-icons-ivy-rich
      ivy-prescient
      helpful 
      doom-modeline
      doom-themes
      rainbow-delimiters
      rainbow-mode
      evil
      evil-collection
      evil-tutor
      which-key
      general
      gcmh
      projectile
      counsel-projectile
      transient
      magit
      git-timemachine
      org-bullets
      org-roam
      org-roam-ui
      websocket
      ccls
      lsp-mode
      lsp-ui
      lsp-treemacs
      lsp-ivy
      python
      hl-todo
      typescript-mode
      python-mode
      pyvenv
      git-gutter
      git-gutter-fringe
      yasnippet
      yasnippet-snippets
      centaur-tabs
      treesit-auto
      tree-sitter
      tree-sitter-langs
      flycheck
      treemacs
      treemacs-icons-dired
      treemacs-magit
      treemacs-persp
      treemacs-tab-bar
      treemacs-evil
      treemacs-projectile
      auctex
      rustic
      pdf-tools
      # add more here
    ];
  };


  home.file.".emacs.d" = {
    source = ./emacs/.emacs.d;
    recursive=true;
  };

}
