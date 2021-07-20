# Qtile config.py based on Gruvbox Dark Terminal and GTK Themes
# Created by Jeff Winget

import os
import re
import socket
import subprocess
from libqtile.config import Drag, Key, Screen, Group, Drag, Click, Rule
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook, qtile
from libqtile.widget import Spacer

#mod4 or mod = super key
mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser('~')
terminal = "alacritty"

# @lazy.function
# def window_to_prev_group(qtile):
#     if qtile.currentWindow is not None:
#         i = qtile.groups.index(qtile.currentGroup)
#         qtile.currentWindow.togroup(qtile.groups[i - 1].name)

# @lazy.function
# def window_to_next_group(qtile):
#     if qtile.currentWindow is not None:
#         i = qtile.groups.index(qtile.currentGroup)
#         qtile.currentWindow.togroup(qtile.groups[i + 1].name)

keys = [

# Qtile System Actions

    Key([mod, "shift"], "r", lazy.restart(),
        desc="Restart Qtile"),

# Active Window Actions

    Key([mod], "f", lazy.window.toggle_fullscreen(), 
        desc="Toggle window fullscreen"),
    Key([mod], "q", lazy.window.kill(), 
        desc="Close active window"),
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        desc="Increase active window size."
        ),
    Key([mod, "control"], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        desc="Increase active window size."
        ),
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        desc="Decrease active window size."
        ),
    Key([mod, "control"], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        desc="Decrease active window size."
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        desc="Increase active window size."
        ),
    Key([mod, "control"], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        desc="Increase active window size."
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        desc="Decrease active window size."
        ),
    Key([mod, "control"], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        desc="Decrease active window size."
        ),

# Window Focus (Vim Keys and Arrows)
    Key([mod], "Up", lazy.layout.up(),
        desc="Change focus to window above."),
    Key([mod], "Down", lazy.layout.down(),
        desc="Change focus to window below."),
    Key([mod], "Left", lazy.layout.left(),
        desc="Change focus to window on the left."),
    Key([mod], "Right", lazy.layout.right(),
        desc="Change focus to window on the right."),
    Key([mod], "k", lazy.layout.up(),
        desc="Change focus to window above."),
    Key([mod], "j", lazy.layout.down(),
        desc="Change focus to window below."),
    Key([mod], "h", lazy.layout.left(),
        desc="Change focus to window on the left."),
    Key([mod], "l", lazy.layout.right(),
        desc="Change focus to window on the right."),

# Qtile Layout Actions
    Key([mod], "n", lazy.layout.reset(),
        desc="Reset the sizes of all window in group."),
    Key([mod], "Tab", lazy.next_layout(),
        desc="Switch to the next layout."),
    Key([mod, "shift"], "f", lazy.layout.flip(),
        desc="Flip layout for Monadtall/Monadwide"),
    Key([mod, "shift"], "space", lazy.window.toggle_floating(),
        desc="Toggle floating window."),

# Move windows around MonadTall/MonadWide Layouts
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(),
        desc="Shuffle window up."),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(),
        desc="Shuffle window down."),
    Key([mod, "shift"], "Left", lazy.layout.swap_left(),
        desc="Shuffle window left."),
    Key([mod, "shift"], "Right", lazy.layout.swap_right(),
        desc="Shuffle window right."),

    ]

# Colors
bg = "#282828"
bg_accent = "#928374"
fg = "#ebdbb2"
fg_accent = "#a89984"
color1 = "#cc241d"
color1_accent = "#fb4934"
color2 = "#98971a"
color2_accent = "#b8bb26"
color3 = "#d79921"
color3_accent = "#fabd2f"
color4 = "#458588"
color4_accent = "#83a598"
color5 = "#b16286"
color5_accent = "#d3869b"
color6 = "#689d6a"
color6_accent = "#8ec07c"

# Create labels for groups and assign them a default layout.
groups = []

group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",]

group_labels = ["", "", "", "", "", "", "", "", "", "",]

group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall",]

# Add group names, labels, and default layouts to the groups object.
for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

# Add group specific keybindings
for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Mod + number to move to that group."),
        Key(["mod1"], "Tab", lazy.screen.next_group(),
            desc="Move to next group."),
        Key(["mod1", "shift"], "Tab", lazy.screen.prev_group(),
            desc="Move to previous group."),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            desc="Move focused window to new group."),
    ])

# Define layouts and layout themes
def init_layout_theme():
    return {"margin":8,
            "border_width":2,
            "border_focus": color2,
            "border_normal": bg
            }

layout_theme = init_layout_theme()

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Floating(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme)
]

# Mouse callback functions
def launch_menu():
    qtile.cmd_spawn("xfce4-appfinder")

def lock_screen():
    qtile.cmd_spawn("multilockscreen -l")

def shutdown_menu():
    qtile.cmd_spawn("rofi -show power-menu -modi power-menu:~/.local/bin/rofi-power-menu -width 20 -lines 6")

# Define widgets for the bar.
def init_widgets_defaults():
    return dict(font="Noto Sans",
                fontsize = 12,
                padding = 2,
                background=bg)

widget_defaults = init_widgets_defaults()

def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
               widget.TextBox(
                    "", 
                    font = "FontAwesome5Free",
                    fontsize = 18,
                    padding = 10,
                    background = color2,
                    foreground = fg,
                    mouse_callbacks = {'Button1' : launch_menu}
                ),
                widget.GroupBox(
                    font="FontAwesome5Free",
                    fontsize = 18,
                    margin_y = 2,
                    margin_x = 4,
                    padding_y = 6,
                    padding_x = 6,
                    borderwidth = 2,
                    disable_drag = True,
                    active = color2,
                    inactive = fg,
                    rounded = False,
                    highlight_method = "line",
                    highlight_color = [bg, bg],
                    this_current_screen_border = color2_accent,
                    other_screen_border = color3,
                    other_current_screen_border = color3_accent,
                    urgent_alert_method = "line",
                    urgent_border = "color1",
                    urgent_text = "color1_accent",
                    foreground = fg,
                    background = bg
                ),
                widget.TaskList(
                    icon_size = 0,
                    font = "Input Mono",
                    foreground = fg,
                    background = bg,
                    borderwidth = 1,
                    border = color2,
                    margin = 0,
                    padding = 11,
                    highlight_method = "block",
                    title_width_method = "uniform",
                    max_title_width = 250,
                    urgent_alert_method = "border",
                    urgent_border = color1,
                    rounded = False,
                ),
                widget.Sep(
                    linewidth = 1,
                    padding = 10,
                    foreground = fg,
                    background = bg
                ),
                widget.CurrentLayout(
                    font = "Input Mono",
                    foreground = fg,
                    background = bg
                ),
                widget.Sep(
                    linewidth = 1,
                    padding = 10,
                    foreground = fg,
                    background = bg
                ),
                widget.TextBox(
                   text = "",
                   fontsize = 18,
                   font = "FontAwesome5Free",
                   foreground = color1,
               ),
               widget.ThermalSensor(
                    foreground = fg,
                    foreground_alert = color1,
                    background = bg,
                    metric = True,
                    padding = 3,
                    threshold = 80,
                    font = "Input Mono",
                ),
                widget.Sep(
                    linewidth = 0,
                    padding = 10
                ),
                widget.TextBox(
                    text = "",
                    fontsize = 18,
                    font = "FontAwesome5Free",
                    foreground = color2,
                ),
                widget.Battery(
                    format = "{percent:2.0%} ({hour:d}:{min:02d})",
                    font = "Input Mono",
                    foreground = fg,
                ),
                widget.Sep(
                    linewidth = 0,
                    padding = 10
                ),
                widget.TextBox(
                    text = "",
                    fontsize = 18,
                    font = "FontAwesome5Free",
                    foreground = color3,
                ),
                widget.Memory(
                    font = "Input Mono",
                    foreground = fg,
                ),
                widget.Sep(
                    linewidth = 0,
                    padding = 10
                ),
                widget.TextBox(
                    text = "",
                    fontsize = 18,
                    font = "FontAwesome5Free",
                    foreground = color4,
                ),
                widget.Net(
                    font = "Input Mono",
                    foreground = fg,
                    format = "{down} ↓↑ {up}"
                ),
                widget.Sep(
                    linewidth = 0,
                    padding = 10
                ),
                widget.TextBox(
                    text = "",
                    fontsize = 18,
                    font = "FontAwesome5Free",
                    foreground = color5,
                ),
                widget.Clock(
                    format='%b %d - %I:%M %p',
                    font = "Input Mono",
                    foreground = fg,
                ),
                widget.Sep(
                    linewidth = 1,
                    padding = 10,
                    foreground = fg,
                ),
                widget.Systray(
                    background = bg,
                    icon_size = 20,
                    padding = 4,
                ),
                widget.Sep(
                    linewidth = 1,
                    padding = 10,
                    foreground = fg,
                ),
                widget.TextBox(
                    padding = 4,
                    text = "",
                    fontsize = 16,
                    font = "FontAwesome5Free",
                    foreground = color3_accent,
                    mouse_callbacks = {'Button1' : lock_screen}
                ),
                widget.TextBox(
                    padding = 4,
                    text = "",
                    fontsize = 16,
                    foreground = color1,
                    font = "FontAwesome5Free",
                    mouse_callbacks = {'Button1' : shutdown_menu}
                ),
                widget.Sep(
                    linewidth = 0,
                    padding = 10,
                ),
              ]
    return widgets_list

widgets_list = init_widgets_list()


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2

widgets_screen1 = init_widgets_screen1()
widgets_screen2 = init_widgets_screen2()


def init_screens():
    return [Screen(
                top=bar.Bar(
                    widgets=init_widgets_screen1(), 
                    size=36,
                    background=bg,
                    margin=6, 
                    opacity=0.8
                    )
                ),
            Screen(
                top=bar.Bar(
                    widgets=init_widgets_screen2(), 
                    size=36,
                    background=bg,
                    margin=6, 
                    opacity=0.8))]
screens = init_screens()


# MOUSE CONFIGURATION
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

dgroups_key_binder = None
dgroups_app_rules = []

# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME
# BEGIN

#########################################################
################ assgin apps to groups ##################
#########################################################
# @hook.subscribe.client_new
# def assign_app_group(client):
#     d = {}
#     #####################################################################################
#     ### Use xprop fo find  the value of WM_CLASS(STRING) -> First field is sufficient ###
#     #####################################################################################
#     d[group_names[0]] = ["Navigator", "Firefox", "Vivaldi-stable", "Vivaldi-snapshot", "Chromium", "Google-chrome", "Brave", "Brave-browser",
#               "navigator", "firefox", "vivaldi-stable", "vivaldi-snapshot", "chromium", "google-chrome", "brave", "brave-browser", ]
#     d[group_names[1]] = [ "Atom", "Subl3", "Geany", "Brackets", "Code-oss", "Code", "TelegramDesktop", "Discord",
#                "atom", "subl3", "geany", "brackets", "code-oss", "code", "telegramDesktop", "discord", ]
#     d[group_names[2]] = ["Inkscape", "Nomacs", "Ristretto", "Nitrogen", "Feh",
#               "inkscape", "nomacs", "ristretto", "nitrogen", "feh", ]
#     d[group_names[3]] = ["Gimp", "gimp" ]
#     d[group_names[4]] = ["Meld", "meld", "org.gnome.meld" "org.gnome.Meld" ]
#     d[group_names[5]] = ["Vlc","vlc", "Mpv", "mpv" ]
#     d[group_names[6]] = ["VirtualBox Manager", "VirtualBox Machine", "Vmplayer",
#               "virtualbox manager", "virtualbox machine", "vmplayer", ]
#     d[group_names[7]] = ["Thunar", "Nemo", "Caja", "Nautilus", "org.gnome.Nautilus", "Pcmanfm", "Pcmanfm-qt",
#               "thunar", "nemo", "caja", "nautilus", "org.gnome.nautilus", "pcmanfm", "pcmanfm-qt", ]
#     d[group_names[8]] = ["Evolution", "Geary", "Mail", "Thunderbird",
#               "evolution", "geary", "mail", "thunderbird" ]
#     d[group_names[9]] = ["Spotify", "Pragha", "Clementine", "Deadbeef", "Audacious",
#               "spotify", "pragha", "clementine", "deadbeef", "audacious" ]
#     ######################################################################################
#
# wm_class = client.window.get_wm_class()[0]
#
#     for i in range(len(d)):
#         if wm_class in list(d.values())[i]:
#             group = list(d.keys())[i]
#             client.togroup(group)
#             client.group.cmd_toscreen(toggle=False)

# END
# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME



main = None

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])

@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])

@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True

floating_types = ["notification", "toolbar", "splash", "dialog"]


follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'Arcolinux-welcome-app.py'},
    {'wmclass': 'Arcolinux-tweak-tool.py'},
    {'wmclass': 'Arcolinux-calamares-tool.py'},
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},
    {'wmclass': 'makebranch'},
    {'wmclass': 'maketag'},
    {'wmclass': 'Arandr'},
    {'wmclass': 'feh'},
    {'wmclass': 'Galculator'},
    {'wmclass': 'arcolinux-logout'},
    {'wmclass': 'xfce4-terminal'},
    {'wname': 'branchdialog'},
    {'wname': 'Open File'},
    {'wname': 'pinentry'},
    {'wmclass': 'ssh-askpass'},
    {'wmclass': 'Mailspring'},

],  fullscreen_border_width = 0, border_width = 0)
auto_fullscreen = True

focus_on_window_activation = "focus" # or smart

wmname = "LG3D"
