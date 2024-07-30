{ config, pkgs, ... }:
{
    programs.git = {
        enable = true;
        userName  = "Jeff Winget";
        userEmail = "jeff@3dgradebook.com";
    };
}