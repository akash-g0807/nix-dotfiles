{ pkgs, ... }:
let

  # My shell aliases
  myAliases = {
    #ls = "eza --icons -l -T -L=1";
    #cat = "bat";
    #htop = "btm";
    #fd = "fd -Lu";
    #w3m = "w3m -no-cookie -v";
    #neofetch = "disfetch";
    #fetch = "disfetch";
    #gitfetch = "onefetch";
    #"," = "comma";
  };
in
{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    shellAliases = myAliases;
    initExtra = ''
    PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f
     %F{green}→%f "
    RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
    [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
    bindkey '^P' history-beginning-search-backward
    bindkey '^N' history-beginning-search-forward
    '';
  

  zplug = {
    enable = true;
    plugins = [
      { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
    ];
  };
 
 # oh-my-zsh = {
 #   enable = true;
 #   plugins = [ "git" ];
 #   theme = "robbyrussell";
 # };
  };
  

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  #home.packages = with pkgs; [
  #  disfetch lolcat cowsay onefetch
  #  gnugrep gnused
  #  bat eza bottom fd bc
  #  direnv nix-direnv
  #];

  #programs.direnv.enable = true;
  #programs.direnv.enableZshIntegration = true;
  #programs.direnv.nix-direnv.enable = true;
}
