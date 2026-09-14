{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    # This automatically enables the shell integration for bash/zsh/fish
    enableBashIntegration = true; 
    
    settings = {
      # Your specific format
      format = ''
        [╭─┐ ](bold blue)$hostname$directory$git_branch$git_status$nix_shell
        [╰](bold blue)$character
      '';

      hostname = {
        ssh_only = true;
        format = "[$hostname](bold purple)[ ┌┐ ](bold blue)";
        trim_at = "."; # Changes 'minipc.local' to just 'minipc'
      };

      directory = {
        truncation_length = 8;
        truncation_symbol = "…/";
        style = "bold blue";
      };

      git_branch = {
        format = "on [$symbol$branch(:$remote_branch)](bold blue) ";
      };

      nix_shell = {
        impure_msg = "[impure ](bold red)";
        pure_msg = "[pure ](bold green)";
        unknown_msg = "[unknown ](bold yellow)";
        format = "via $state ";
      };
      
      # Optional: make the prompt character a specific color/shape
      character = {
        success_symbol = "[❯](bold blue)";
        error_symbol = "[❯](bold red)";
      };
    };
  };
}
