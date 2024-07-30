{ config, pkgs, ... }:
{
    # zsh settings (powerlevel10k, wallust, fastfetch)
    programs.zsh = {
        enable = true;
        plugins = [
        {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        ];
        initExtra = ''
            source ~/.p10k.zsh
            cat ~/.cache/wallust/sequences
            fastfetch
        '';
        shellAliases = {
            ll = "ls -la";
            nrs = "sudo nixos-rebuild switch --flake .";
            hms = "home-manager switch --flake .";
            update = "nix flake update";
        };
    };
}