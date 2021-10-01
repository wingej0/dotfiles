
from typing import List  # noqa: F401
import os
import subprocess

from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"
terminal = "alacritty"

keys = [
    # Open terminal
    Key([mod], "Return", lazy.spawn(terminal), 
        desc="Launch terminal"),

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

    # Window Focus (Arrows and Vim keys)
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
    Key([mod], "r", lazy.layout.reset(),
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
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),
        desc="Shuffle window up."),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Shuffle window down."),
    Key([mod, "shift"], "h", lazy.layout.swap_left(),
        desc="Shuffle window left."),
    Key([mod, "shift"], "l", lazy.layout.swap_right(),
        desc="Shuffle window right."),
    
    # Switch focus to specific monitor (out of three)
    Key([mod], "i",
        lazy.to_screen(0),
        desc='Keyboard focus to monitor 1'),
    Key([mod], "o",
        lazy.to_screen(1),
        desc='Keyboard focus to monitor 2'),
    Key([mod], "p",
        lazy.to_screen(2),
        desc='Keyboard focus to monitor 3'),

    # Switch focus of monitors
    Key([mod], "period",
        lazy.next_screen(),
        desc='Move focus to next monitor'),
    Key([mod], "comma",
        lazy.prev_screen(),
        desc='Move focus to prev monitor'),
]

# Colors (Based on Arc Dark GTK theme)
bg = "#383c4a"
bg_accent = "#2c2f3a"
fg = "#d3dae3"
fg_accent = "#63686d"
color1 = "#e14245"
color1_accent = "#783228"
color2 = "#5294e2"
color2_accent = "#2b486b"
color3 = "#f6ab32"
color3_accent = "#b65619"
color4 = "#5ca75b"
color4_accent = "#4b7c16"
color5 = "#8ca9bf"
color5_accent = "#1b668f"
color6 = "#a660c3"
color6_accent = "#614a73"

# Create labels for groups and assign them a default layout.
groups = []

group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

group_labels = ["", "", "", "", "", "", "", "", "", ""]

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
layout_theme = {
        "margin":8,
        "border_width":2,
        "border_focus": color2,
        "border_normal": bg
    }

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

# Define Widgets
widget_defaults = dict(
    font="Noto Sans",
    fontsize = 12,
    padding = 2,
    background=bg
)

# Widget list for primary monitor
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
        hide_unused = False,
        rounded = False,
        highlight_method = "line",
        highlight_color = [bg, bg],
        this_current_screen_border = color2,
        this_screen_border = color4,
        other_screen_border = color3,
        other_current_screen_border = color3,
        urgent_alert_method = "line",
        urgent_border = color1,
        urgent_text = color1,
        foreground = fg,
        background = bg,
        use_mouse_wheel = False
    ),
    widget.TaskList(
        icon_size = 0,
        font = "Roboto Bold",
        foreground = fg,
        background = bg,
        borderwidth = 1,
        border = color2,
        margin = 0,
        padding = 11,
        highlight_method = "block",
        title_width_method = "uniform",
        urgent_alert_method = "border",
        urgent_border = color1,
        rounded = False,
    ),
    widget.Sep(
        linewidth = 1,
        padding = 10,
        foreground = fg,
    ),
    widget.TextBox(
        text = "  1",
        fontsize = 16,
        font = "FontAwesome5Free",
        foreground = fg,
    ),
    widget.CurrentLayoutIcon(
        scale = 0.5,
        foreground = fg,
        background = bg
    ),
    widget.Sep(
        linewidth = 1,
        padding = 10,
        foreground = fg,
        background = bg
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
        font = "Roboto",
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
        font = "Roboto",
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
        font = "Roboto",
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
        font = "Roboto",
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
        font = "Roboto",
        foreground = fg,
    ),
    widget.Sep(
        linewidth = 0,
        padding = 10,
    ),
]

# Widget lists for secondary monitors (no systray or lock/shutdown buttons)
secondary_widgets_list = [
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
        hide_unused = False,
        inactive = fg,
        rounded = False,
        highlight_method = "line",
        highlight_color = [bg, bg],
        this_current_screen_border = color2,
        this_screen_border = color4,
        other_screen_border = color3,
        other_current_screen_border = color3,
        urgent_alert_method = "line",
        urgent_border = color1,
        urgent_text = color1,
        foreground = fg,
        background = bg,
        use_mouse_wheel = False
    ),
    widget.TaskList(
        icon_size = 0,
        font = "Roboto Bold",
        foreground = fg,
        background = bg,
        borderwidth = 1,
        border = color2,
        margin = 0,
        padding = 11,
        highlight_method = "block",
        title_width_method = "uniform",
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
    widget.TextBox(
        text = "  2",
        fontsize = 16,
        font = "FontAwesome5Free",
        foreground = fg,
    ),
    widget.CurrentLayoutIcon(
        scale = 0.5,
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
        font = "Roboto",
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
        font = "Roboto",
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
        font = "Roboto",
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
        font = "Roboto",
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
        font = "Roboto",
        foreground = fg,
    ),
    widget.Sep(
        linewidth = 0,
        padding = 10,
    ),
]

secondary_widgets_list_2 = [
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
        hide_unused = False,
        rounded = False,
        highlight_method = "line",
        highlight_color = [bg, bg],
        this_current_screen_border = color2,
        this_screen_border = color4,
        other_screen_border = color3,
        other_current_screen_border = color3,
        urgent_alert_method = "line",
        urgent_border = color1,
        urgent_text = color1,
        foreground = fg,
        background = bg,
        use_mouse_wheel = False
    ),
    widget.TaskList(
        icon_size = 0,
        font = "Roboto Bold",
        foreground = fg,
        background = bg,
        borderwidth = 1,
        border = color2,
        margin = 0,
        padding = 11,
        highlight_method = "block",
        title_width_method = "uniform",
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
    widget.TextBox(
        text = "  3",
        fontsize = 16,
        font = "FontAwesome5Free",
        foreground = fg,
    ),
    widget.CurrentLayoutIcon(
        scale = 0.5,
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
        font = "Roboto",
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
        font = "Roboto",
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
        font = "Roboto",
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
        font = "Roboto",
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
        font = "Roboto",
        foreground = fg,
    ),
    widget.Sep(
        linewidth = 0,
        padding = 10,
    ),
]

# Define 3 monitors
screens = [
    Screen(
        top=bar.Bar(
            widgets=widgets_list,
            size=36,
            background=bg,
            margin=0, 
            opacity=0.8
        ),
    ),
    Screen(
        top=bar.Bar(
            widgets=secondary_widgets_list,
            size=36,
            background=bg,
            margin=0, 
            opacity=0.8
        ),
    ),
    Screen(
        top=bar.Bar(
            widgets=secondary_widgets_list_2,
            size=36,
            background=bg,
            margin=0, 
            opacity=0.8
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# Startup applications
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class='Mailspring'), # Mail client
], fullscreen_border_width = 0, border_width = 0)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"