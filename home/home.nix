{ config, pkgs, ... }:

{
  imports = 
  [
    # System Configs
    ./system/zsh.nix
    ./system/gnome.nix
    ./system/gtk.nix

    # Program Configs
    ./programs/kitty.nix
    ./programs/fastfetch.nix
  ];

  # Edit Mailspring desktop file
  xdg.desktopEntries.mailspring = {
    name="Mailspring Client";
    exec="mailspring --password-store=${"gnome-libsecret"} %U";
    icon="mailspring";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # Source dotfiles to .config
    ".config/dunst".source = ./configs/dunst;
    ".config/picom".source = ./configs/picom;
    ".config/qtile".source = ./configs/qtile;
    ".config/rofi".source = ./configs/rofi;
    ".config/swappy".source = ./configs/swappy;
    ".config/swaylock".source = ./configs/swaylock;
    ".config/wallust".source = ./configs/wallust;
    ".config/wlogout".source = ./configs/wlogout;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/wingej0/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };
}
