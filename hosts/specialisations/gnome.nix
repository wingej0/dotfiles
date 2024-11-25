{ config, pkgs, inputs, username, ... }:
{
    # imports = [ inputs.home-manager.nixosModules.home-manager ];

    specialisation = {
        gnome-desktop.configuration = {
            # Enable the X11 windowing system.
            services.xserver.enable = true;
            
            services.xserver.displayManager.gdm.enable = true;
            services.xserver.desktopManager.gnome.enable = true;

            home-manager.users.${username} = {

                programs.kitty.settings = {
                    tab_bar_style = "powerline";
                    tab_powerline_style = "round";
                    hide_window_decorations = true;
                    background_opacity = 0.8;
                    window_padding_width = 10;
                    confirm_os_window_close = 0;
                };

                programs.zsh.initExtra = ''
                    source ~/.p10k.zsh
                    cat ~/.cache/wallust/sequences
                    bindkey -e
                    fastfetch
                '';

                gtk.cursorTheme = {
                    name = "Bibata-Modern-Classic";
                    package = pkgs.bibata-cursors;
                    size = 24;
               };

               dconf.settings = {

                    "org/gnome/shell" = {
                        disable-user-extensions = false;

                    # `gnome-extensions list` for a list
                    enabled-extensions = [
                            "AlphabeticalAppGrid@stuarthayhurst"
                            "appindicatorsupport@rgcjonas.gmail.com"
                            "blur-my-shell@aunetx"
                            "caffeine@patapon.info"
                            "clipboard-indicator@tudmotu.com"
                            "dash-to-dock@micxgx.gmail.com"
                            "tiling-assistant@leleat-on-github"
                            "user-theme@gnome-shell-extensions.gcampax.github.com"
                        ];
                    };

                    "org/gnome/shell/extensions/user-theme" = {
                        name = "Orchis";
                    };

                    "org/gnome/desktop/interface" = {
                        show-battery-percentage = true;
                    };
                };

            };
        };
    };
}