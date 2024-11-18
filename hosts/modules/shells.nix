{ config, pkgs, ... }:
{
    # Change shell to zsh
    environment.shells = with pkgs; [zsh bash];
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;
}