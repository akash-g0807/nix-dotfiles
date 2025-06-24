{config, pkgs, inputs, ... }:

{
 
environment.systemPackages = with pkgs; [
    emacs-pgtk # replace with emacs-gtk, or a version provided by the community overlay if desired.

   ((emacsPackagesFor emacs-pgtk).emacsWithPackages (
      epkgs: [ epkgs.all-the-icons]
    ))
  ];

  services.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };  
  
}


