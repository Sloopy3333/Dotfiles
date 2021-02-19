from os.path import expanduser 
from subprocess import check_output
from libqtile.bar import Bar
from libqtile.lazy import lazy
from libqtile.extension import CommandSet
from libqtile.layout import MonadTall, MonadWide, Max, Floating
from libqtile.config import Click, Drag, Group, Key, Screen, Match
from libqtile.widget import CurrentLayout, GroupBox, WindowName, GenPollText, TextBox, Sep


mod = "mod4"
terminal = "st"
terminal_alt = "alacritty"
browser = "qutebrowser"
browser_alt = "librewolf"
filemanager = "st -e vifm"
filemanager_alt = "pcmanfm"
email = "st -e neomutt"
musicplayer = "st -e cmus"

keys = [

    # launch and kill programs
    Key([mod],                      "t",                        lazy.spawn(terminal),                            desc="Launch terminal"),
    Key([mod,"shift"],              "t",                        lazy.spawn(terminal_alt),                        desc="Launch alternative terminal"),
    Key([mod],                      "b",                        lazy.spawn(browser),                             desc="Launch browser"),
    Key([mod,"shift"],              "b",                        lazy.spawn(browser_alt),                         desc="Launch alternative browser"),
    Key([mod],                      "m",                        lazy.spawn(musicplayer),                         desc="Launch musicplayer"),
    Key([mod],                      "f",                        lazy.spawn(filemanager),                         desc="Launch filemanager"),
    Key([mod,"shift"],              "f",                        lazy.spawn(filemanager_alt),                     desc="Launch alternative filemanager",),
    Key([mod],                      "e",                        lazy.spawn(email),                               desc="Launch neomutt"),
    Key([mod, "shift"],             "p",                        lazy.spawn(expanduser("~/scripts/passmenu")),    desc="Launch passmenu"),
    Key([mod],                      "q",                        lazy.window.kill(),                              desc="Kill focused window"),

    # qtile commands
    Key([mod],                      "c",                        lazy.restart(),                                  desc="Restart qtile"),
    Key([mod, "shift"],             "c",                        lazy.shutdown(),                                 desc="Shutdown qtile"),


    # shift window focus
    Key([mod],                      "j",                        lazy.layout.down(),                              desc="Shift focus down"),
    Key([mod],                      "k",                        lazy.layout.up(),                                desc="Shift focus up"),
    Key([mod],                      "h",                        lazy.layout.left(),                              desc="Shift focus left"),
    Key([mod],                      "l",                        lazy.layout.right(),                             desc="Shift focus right"),
    Key([mod],                      "Tab",                      lazy.screen.toggle_group(),                      desc="Toggle prev workspace"),

    # move windows
    Key([mod, "shift"],             "j",                        lazy.layout.shuffle_down(),                      desc="Move focused window down"),
    Key([mod, "shift"],             "k",                        lazy.layout.shuffle_up(),                        desc="Move focused window up"),
    Key([mod, "shift"],             "h",                        lazy.layout.shuffle_left(),                      desc="Move focused window left"),
    Key([mod, "shift"],             "l",                        lazy.layout.shuffle_right(),                     desc="Move focused window right"),
    Key([mod, "control"],           "Return",                   lazy.layout.flip(),                             desc="Flip windows"),

    # resize windows
    Key([mod, "control"],           "h",                        lazy.layout.shrink(),                            desc="Increase Master window size"),
    Key([mod, "control"],           "l",                        lazy.layout.grow(),                              desc="Decrease Master window size"),
    Key([mod, "control"],           "m",                        lazy.layout.maximize(),                          desc="Mazimize Master window size"),
    Key([mod, "control"],           "r",                        lazy.layout.reset(),                             desc="Reset window size"),

    # layout modifires
    Key([mod],                      "n",                        lazy.next_layout(),                              desc="Toggle next layout"),
    Key([mod],                      "p",                        lazy.prev_layout(),                              desc="Toggle prev layout"),
    Key([mod, "control"],           "f",                        lazy.window.toggle_fullscreen(),                 desc="Toggle Full Screen"),
    Key([mod, "control"],           "t",                        lazy.window.toggle_floating(),                   desc="Toggle Full Screen"),

    # screenshots
    Key( [mod],                     "Print",                    lazy.spawn(expanduser("~/scripts/sc")),          desc="Take full screen shot"),
    Key( [mod, "shift"],            "Print",                    lazy.spawn(expanduser("~/scripts/sc -s")),       desc="Take screenshot of selected area"),
    Key( [mod, "control"],          "Print",                    lazy.spawn(expanduser("~/scripts/sc -cs")),      desc="Cpoy selected area to clipboard"),

    # run prompts and menu           return
    Key([mod],                      "space",                    lazy.spawn("dmenu_run"),                                                                              desc="Rofi run menu"),
    Key([mod, "control"],           "a",                        lazy.spawn("rofi -show window"),                                                                            desc="Rofi window menu"),
    Key([mod],                      "x",                        lazy.function(lambda qtile: qtile.cmd_spawn(expanduser("~/.config/xmenu/xmenu.sh"))),                       desc="Run xmenu"),
    Key([mod, "control"],           "p",                        lazy.run_extension( CommandSet( commands={ "suspend": "systemctl suspend", "shutdown": "systemctl poweroff", "reboot": "systemctl reboot", },)),desc="Power prompt"),

    # brightness
    Key([],                         "XF86MonBrightnessUp",      lazy.spawn("xbacklight -inc +5"),lazy.function(lambda qtile: qtile.widgets_map["backlight"].tick()),        desc="Increase backlight by 5%"),
    Key([mod],                      "XF86MonBrightnessUp",      lazy.spawn("xbacklight -inc +15"),lazy.function(lambda qtile: qtile.widgets_map["backlight"].tick()),       desc="Increase backlight by 15%"),
    Key([],                         "XF86MonBrightnessDown",    lazy.spawn("xbacklight -dec +5"),lazy.function(lambda qtile: qtile.widgets_map["backlight"].tick()),        desc="Decrease backlight by 5%"),
    Key([mod],                      "XF86MonBrightnessDown",    lazy.spawn("xbacklight -dec +15"),lazy.function(lambda qtile: qtile.widgets_map["backlight"].tick()),       desc="Decrease backlight by 15%"),

    # Volume
    Key([],                         "XF86AudioMute",            lazy.spawn("amixer sset Master toggle"),lazy.function(lambda qtile: qtile.widgets_map["volume"].tick()),    desc="Toggle mute"),
    Key([],                         "XF86AudioRaiseVolume",     lazy.spawn("amixer sset Master 5%+"),lazy.function(lambda qtile: qtile.widgets_map["volume"].tick()),       desc="Increase volume by 5%"),
    Key([mod],                      "XF86AudioRaiseVolume",     lazy.spawn("amixer sset Master 15%+"),lazy.function(lambda qtile: qtile.widgets_map["volume"].tick()),      desc="Increase volume by 15%"),
    Key([],                         "XF86AudioLowerVolume",     lazy.spawn("amixer sset Master 5%-"),lazy.function(lambda qtile: qtile.widgets_map["volume"].tick()),       desc="Decrease volume by 5%"),
    Key([mod],                      "XF86AudioLowerVolume",     lazy.spawn("amixer sset Master 15%-"),lazy.function(lambda qtile: qtile.widgets_map["volume"].tick()),      desc="Decrease volume by 15%"),

]

# Groups
groups = [Group(i) for i in "123456789"]
for i in groups:
    keys.extend(
        [
            # mod1 + number of group = switch to group
            Key( [mod], i.name, lazy.group[i.name].toscreen(), desc=f"Switch to group {i.name}"),
            # mod1 + shift + number of group = switch to & move focused window to group
            Key( [mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True), desc=f"Switch to & move focused window to group {i.name}"),
            # # mod1 + shift + number of group = move focused window to group
            Key( [mod, "shift"], i.name, lazy.window.togroup(i.name), desc=f"move focused window to group {i.name}"),
        ]
    )
# Drag floating layouts.
mouse = [
    Drag( [mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position(),),
    Drag( [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
    #Click([],    "Button3", lazy.function(run_xmenu)),
]
# bar color
bar_colors = {
    "black"           :   "#282a36",  # black
    "red"             :   "#ff5555",  # red
    "green"           :   "#5af78e",  # green
    "yellow"          :   "#f1fa8c",  # yellow
    "blue"            :   "#57c7ff",  # blue
    "magenta"         :   "#ff6ac1",  # magenta
    "cyan"            :   "#8be9fd",  # cyan
    "white"           :   "#f1f1f0",  # white
    "orange"          :   "#ffb86c",  # orange
    "purple"          :   "#bd9cf9",  # purple
}

# borders
border_focus = bar_colors["purple"]
border_width = 2
margin = 10
single_border_width = 0
single_margin = 10

# layouts
layouts = [
    MonadTall(
        border_focus=border_focus,
        border_width=border_width,
        margin=margin,
        single_border_width=single_border_width,
        single_margin=single_margin,
        name="Tall",
    ),
    Max(
        border_focus=border_focus,
        border_width=border_width,
        margin=single_margin,
        single_border_width=0,
        single_margin=0,
        name="Full",
    ),
    MonadWide(
        border_focus=border_focus,
        border_width=border_width,
        margin=margin,
        single_border_width=single_border_width,
        single_margin=single_margin,
        name="wide",
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
floating_layout = Floating(border_focus = bar_colors["green"],
    float_rules=[
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": "download"},
        {"wmclass": "error"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},  # gitk
        {"wmclass": "makebranch"},  # gitk
        {"wmclass": "maketag"},  # gitk
        {"wname": "branchdialog"},  # gitk
        {"wname": "pinentry"},  # GPG key password entry
        {"wmclass": "ssh-askpass"},  # ssh-askpass
        {"wmclass": "feh"},
        {"wmclass": "vlc"},
        {"wmclass": "Picture in picture"},
        {"wmclass": "FreeTube"},
        {"wmclass": "lutris"},
        {"wmclass": "gimp-2.10"},
        {"wmclass": "Gimp-2.10"},
        {"wmclass": "virt-manager"},
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
cursor_warp = False
bring_front_click = True

# auto shifting programs to specified groups
groups = [
    Group("1"),
    Group("2"),
    Group("3"),
    Group("4"),
    Group("5"),
    Group("6"),
    Group("7"),
    Group("8"),
    Group("9"),
]

wmname = "Qtile"
widget_defaults = dict(
    font="Hack Nerd Font Bold",
    fontsize=14,
    padding=5,
)

# calbacks

#screens = []
screens = [
    Screen(
        top=Bar(
            [
                TextBox(text="",
                    fontsize=18,
                    foreground=bar_colors["blue"],
                    background=bar_colors["black"],
                    mouse_callbacks = {"Button1":lambda qtile: qtile.cmd_spawn(expanduser("~/.config/xmenu/xmenu.sh"))},
                    ),
                Sep(
                    linewidth=10,
                    foreground=bar_colors["black"],
                    background=bar_colors["black"],
                    size_percent=100,
                ),
                GroupBox(
                    margin_y=5,
                    padding_y=5,
                    padding_x=3,
                    borderwidth=3,
                    highlight_method="line",
                    background=bar_colors["black"],
                    block_highlight_text_color=bar_colors["green"],
                    highlight_color=bar_colors["black"],
                    this_current_screen_border=bar_colors["purple"],
                    active=bar_colors["yellow"],
                    inactive=bar_colors["purple"],
                    markup=True,
                    center_aligned=True,
                    disable_drag=True,
                ),
                TextBox(text="|",
                    background=bar_colors["black"]
                    ),
                CurrentLayout(
                    foreground=bar_colors["magenta"], background=bar_colors["black"]
                ),
                TextBox(text="|",
                    background=bar_colors["black"]
                    ),
                WindowName(foreground=bar_colors["blue"],
                    background=bar_colors["black"]
                    ),
                TextBox(text="|",
                    background=bar_colors["black"]
                    ),
                GenPollText(
                    func = lambda: check_output(expanduser("~/.config/qtile/scripts/cpu")).decode("utf-8"),
                    update_interval=5,
                    foreground=bar_colors["magenta"],
                    background=bar_colors["black"],
                ),
                TextBox(text="|",
                    background=bar_colors["black"]
                    ),
                GenPollText(
                    func = lambda: check_output(expanduser("~/.config/qtile/scripts/memory")).decode("utf-8"),
                    update_interval=5,
                    foreground=bar_colors["yellow"],
                    background=bar_colors["black"],
                ),
                TextBox(text="|",
                    background=bar_colors["black"]
                    ),
                GenPollText(
                    func = lambda: check_output(expanduser("~/.config/qtile/scripts/internet")).decode("utf-8"),
                    update_interval=5,
                    foreground=bar_colors["blue"],
                    background=bar_colors["black"],
                    mouse_callbacks={"Button1":lambda qtile: qtile.cmd_spawn("st -e nmtui"),
                        "Button3":lambda qtile: qtile.cmd_spawn("st -e nmcli d wifi list --rescan yes"),
                        "Button2":lambda qtile: qtile.cmd_spawn("st -e nmtui")}
                ),
                TextBox(text="|",
                    background=bar_colors["black"]
                    ),
                GenPollText(
                    func = lambda: check_output(expanduser("~/.config/qtile/scripts/battery")).decode("utf-8"),
                    update_interval=5,

                    foreground=bar_colors["green"],
                    background=bar_colors["black"],
                    ),
                TextBox(text="|",
                    background=bar_colors["black"]
                    ),
                GenPollText(
                    name = "backlight",
                    func = lambda: check_output(expanduser("~/.config/qtile/scripts/backlight")).decode("utf-8"),
                    update_interval=None,
                    foreground=bar_colors["purple"],
                    background=bar_colors["black"],
                    mouse_callbacks={"Button1":lambda qtile: qtile.cmd_spawn("xbacklight -inc 5"),
                        "Button3":lambda qtile: qtile.cmd_spawn("xbacklight -dec 5"),
                        "Button2":lambda qtile: qtile.cmd_spawn("xbacklight -set 5")}
                ),
                GenPollText(
                    name = "volume",
                    func = lambda: check_output(expanduser("~/.config/qtile/scripts/volume")).decode("utf-8"),
                    update_interval=None,
                    foreground=bar_colors["purple"],
                    background=bar_colors["black"],
                    mouse_callbacks={"Button1":lambda qtile: qtile.cmd_spawn("amixer sset Master 5%+"),
                        "Button3":lambda qtile: qtile.cmd_spawn("amixer sset Master 5%-"),
                        "Button2":lambda qtile: qtile.cmd_spawn("amixer sset Master toggle")}
                ),
                TextBox(text="|",
                    background=bar_colors["black"]
                    ),
                GenPollText(
                    func = lambda: check_output(expanduser("~/.config/qtile/scripts/clock")).decode("utf-8"),
                    update_interval=None,
                    foreground=bar_colors["blue"],
                    background=bar_colors["black"],
                ),
            ],
            size=20,
            opacity=1.0,
            margin=[0,0,0,0]
        ),
    ),
]
