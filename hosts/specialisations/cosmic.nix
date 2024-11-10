{ config, pkgs, inputs, username, ... }:
{
    imports = [
        {
            nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
        }
        inputs.nixos-cosmic.nixosModules.default
    ];

    specialisation = {
        cosmic-desktop.configuration = {
            services.displayManager.cosmic-greeter.enable = true;
            services.desktopManager.cosmic.enable = true;

            environment.systemPackages = with pkgs; [
                # Gnome stuff
                gnome-online-accounts
                gnome-calendar
            ];

            programs.dconf.enable = true;
            services.gnome.evolution-data-server.enable = true;
            services.gnome.gnome-online-accounts.enable = true;
            services.gnome.gnome-keyring.enable = true;

            home-manager.users.${username} = {

                programs.kitty.settings = {
                    tab_bar_style = "powerline";
                    tab_powerline_style = "round";
                    active_tab_background = "#6296BE";
                    active_tab_foreground = "#1B1B1B";
                    inactive_tab_background = "#BEBEBE";
                    inactive_tab_foreground = "#1B1B1B";
                    hide_window_decorations = true;
                    background_opacity = 0.8;
                    window_padding_width = 10;
                    confirm_os_window_close = 0;

                    foreground = "#C4C4C4";
                    background = "#2E3440";
                    selection_foreground = "#8E8E8E";
                    selection_background = "#FFFACD";
                    url_color = "#6296BE";
                    cursor = "#C4C4C4";

                    # black
                    color0 = "#1B1B1B";
                    color8 = "#808080";

                    # red
                    color1 = "#F16161";
                    color9 = "#FF8985";

                    # green
                    color2 = "#7CB987";
                    color10 = "#97D5A0";

                    # yellow
                    color3 = "#DDC74C";
                    color11 = "#FAE365";

                    # blue
                    color4 = "#6296BE";
                    color12 = "#7DB1DA";

                    # magenta
                    color5 = "#BE6DEE";
                    color13 = "#D68EFF";

                    # cyan
                    color6 = "#49BAC8";
                    color14 = "#49BAC8";

                    # white
                    color7 = "#BEBEBE";
                    color15 = "#C4C4C4";
                };

                programs.zsh.initExtra = ''
                    source ~/.p10k.zsh
                    bindkey -e
                    fastfetch
                '';

                gtk.cursorTheme = {
                    name = "Adwaita";
                    size = 24;
                };
            };
        };
    };
}