config.load_autoconfig(False)
# Which cookies to accept. With QtWebEngine, this setting also controls
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set("content.cookies.accept", "never", "chrome-devtools://*")
config.set("content.cookies.accept", "never", "devtools://*")

# User agent to send.  The following placeholders are defined:  *
# JavaScript requires a restart.
# Type: FormatString
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}",
    "https://web.whatsapp.com/",
)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version} Edg/{upstream_browser_version}",
    "https://accounts.google.com/*",
)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36",
    "https://*.slack.com/*",
)

# Load images automatically in web pages.
# Type: Bool
config.set("content.images", True, "chrome-devtools://*")
config.set("content.images", True, "devtools://*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "chrome-devtools://*")
config.set("content.javascript.enabled", True, "devtools://*")
config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "qute://*/*")

# preferences
c.url.start_pages = "/home/sam/.config/startpage/index.html"
c.tabs.show = "multiple"
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "go": "https://www.google.com/search?q={}",
    "re": "https://www.reddit.com/r/{}",
    "ub": "https://www.urbandictionary.com/define.php?term={}",
    "yt": "https://www.youtube.com/results?search_query={}",
}

# colors
mycolors = {
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

# dark mode
config.set("colors.webpage.darkmode.enabled", True)
# completion
c.colors.completion.category.bg = mycolors["black"]
c.colors.completion.category.border.bottom = mycolors["black"]
c.colors.completion.category.border.top = mycolors["black"]
c.colors.completion.category.fg = mycolors["magenta"]
c.colors.completion.even.bg = mycolors["black"]
c.colors.completion.odd.bg = mycolors["black"]
c.colors.completion.fg = [mycolors["green"], mycolors["blue"], mycolors["red"]]
c.colors.completion.item.selected.bg = mycolors["purple"]
c.colors.completion.item.selected.fg = mycolors["black"]
c.colors.completion.item.selected.match.fg = mycolors["yellow"]
c.colors.completion.match.fg = mycolors["yellow"]

# statusbar
c.colors.statusbar.caret.bg = mycolors["black"]
c.colors.statusbar.caret.fg = mycolors["white"]
c.colors.statusbar.caret.selection.bg = mycolors["black"]
c.colors.statusbar.caret.selection.fg = mycolors["white"]
c.colors.statusbar.command.bg = mycolors["black"]
c.colors.statusbar.command.fg = mycolors["white"]
c.colors.statusbar.insert.bg = mycolors["black"]
c.colors.statusbar.insert.fg = mycolors["white"]
c.colors.statusbar.normal.bg = mycolors["black"]
c.colors.statusbar.normal.fg = mycolors["white"]

c.colors.downloads.bar.bg = mycolors["blue"]
c.colors.downloads.error.bg = mycolors["red"]
c.colors.downloads.error.fg = mycolors["black"]

c.colors.completion.scrollbar.fg = mycolors["black"]

c.colors.keyhint.bg = mycolors["purple"]
c.colors.keyhint.fg = mycolors["black"]

c.aliases['ZZ'] = 'quit --save'
# Bindings for normal mode
c.bindings.commands = {
    "normal": {
        "xb": "config-cycle statusbar.show always never",
        "xt": "config-cycle tabs.show always never",
        "xx": "config-cycle statusbar.show always never ;; config-cycle tabs.show always never",
    }
}
