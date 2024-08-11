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
            bindkey -e
            cat ~/.cache/wallust/sequences
            fastfetch
        '';
        shellAliases = {
            ll = "ls -la";
            nrs = "sudo nixos-rebuild boot --flake .";
            hms = "home-manager switch --flake .";
            update = "nix flake update";
            office = "wlr-randr --output eDP-1 --off --output DP-6 --mode 1920x1080 0,0 --output DP-7 --mode 1920x1080 1920,0 --output HDMI-A-1 --mode 1280x720 3840,0 --transform 90";
        };
    };
}