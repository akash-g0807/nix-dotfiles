{ config, pkgs, userSettings, ... }:

{

programs.vscode = {
  enable = true;
  package = pkgs.vscode.fhs;
  profiles.default.extensions = with pkgs.vscode-extensions; [
    dracula-theme.theme-dracula
    vscodevim.vim
    yzhang.markdown-all-in-one
    ms-vscode.cpptools-extension-pack
    ms-vscode.cmake-tools
    twxs.cmake
    ms-vscode.cpptools
   ms-python.python
    james-yu.latex-workshop
  ];
};

}
