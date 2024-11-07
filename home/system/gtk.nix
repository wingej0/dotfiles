{ config, pkgs, ... }:

{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-light";
      };
    };
  };

  gtk = {
    enable = true;
  
    gtk3 = {
      bookmarks = let
        home = config.home.homeDirectory;
      in [
        "file://${home}/Documents"
        "file://${home}/.dotfiles"
        "file://${home}/dev"
      ];
      extraConfig = {
        gtk-application-prefer-dark-theme = 0;
      };
    };

    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 0;
      };
    };

    font = {
      package = pkgs.fira-code-nerdfont;
      name = "Fira Code Nerd Font";
      size = 11;
    };

    cursorTheme = {
      # name = "Adwaita";
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    theme = {
      name = "Orchis";
      package = pkgs.orchis-theme;
    };

    iconTheme = {
      name = "Tela-dark";
      package = pkgs.tela-icon-theme;
    };
  };
}