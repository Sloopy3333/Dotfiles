/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 8;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int user_bh            = 22;        /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
static const int vertpad            = 0;       /* vertical padding of bar */
static const int sidepad            = 0;       /* horizontal padding of bar */

static const char *fonts[]          = { "Hack Bold:size=11:antialias=true:autohint=true",
					"JoyPixels:pixelsize=14:antialias=true:autohint=true"};
static const char dmenufont[]       = "Hack Bold:size=10";
static const char col_black[]       = "#282a36";
static const char col_white[]       = "#f1f1f0";
static const char col_magenta[]     = "#ff79c6";
static const char col_green[]       = "#5af78e";
static const char col_purple[]      = "#bd93f9";
static const char col_border[]      = "#5af78e";
static const char *colors[][3]      = {
	/*                 	fg         bg         border   */
	[SchemeNorm] 	 =  { col_white,	col_black,	col_black },
	[SchemeSel] 	 =  { col_black,	col_purple, 	col_border},
	[SchemeStatus]   =  { col_white,	col_black, 	col_black  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  =  { col_black,	col_purple,	col_black  }, // Tagbar left selected {text,background,not used but cannot be empty}
        [SchemeTagsNorm] =  { col_white,	col_black,	col_black  }, // Tagbar left unselected {text,background,not used but cannot be empty}
        [SchemeInfoSel]  =  { col_magenta,	col_black,	col_black  }, // infobar middle  selected {text,background,not used but cannot be empty}
        [SchemeInfoNorm] =  { col_magenta,	col_black,	col_black  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
//static const char *tags[] = { "", "", "", "", "", "", "", "", "" }; 

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class     instance  title           tags mask  isfloating  isterminal */
	{ "Gimp",    NULL,     NULL,           0,         1,          0,          },
	{ "Firefox", NULL,     NULL,           1 << 8,    0,          0,          },
	{ "St",      NULL,     NULL,           0,         0,          1,          },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

#include "horizgrid.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "Tall",      tile },    /* first entry is default */
	{ "Full",      monocle },
	{ NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
        { MOD, XK_j,     ACTION##stack, {.i = INC(+1) } }, \
        { MOD, XK_k,     ACTION##stack, {.i = INC(-1) } }, \

#define XF86XK_AudioLowerVolume	0x1008FF11   /* Volume control down        */
#define XF86XK_AudioMute	0x1008FF12   /* Mute sound from the system */
#define XF86XK_AudioRaiseVolume	0x1008FF13   /* Volume control up          */
#define XF86XK_MonBrightnessUp   0x1008FF02  /* Monitor/panel brightness */
#define XF86XK_MonBrightnessDown 0x1008FF03  /* Monitor/panel brightness */

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_black, "-nf", col_white, "-sb", col_purple, "-sf", col_black, NULL };
static const char *termcmd[]  = { "st", NULL };

static Key keys[] = {
	// launch and kill application
	{ MODKEY,             		XK_t,			   spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,			   spawn,          SHCMD("vimb") },
	{ MODKEY|ShiftMask,             XK_b,			   spawn,          SHCMD("firefox") },
	{ MODKEY,                       XK_f,			   spawn,          SHCMD("st -e vifm") },
	{ MODKEY,                       XK_m,			   spawn,          SHCMD("st -e cmus") },
	{ MODKEY,                       XK_space,		   spawn,          SHCMD("rofi -show drun") },
	{ MODKEY,                       XK_x,			   spawn,          SHCMD("~/.config/xmenu/xmenu.sh") },
	{ MODKEY,          	        XK_q,			   killclient,     {0} },
	// window movement
	STACKKEYS(MODKEY,                          		   focus)
        STACKKEYS(MODKEY|ShiftMask,                		   push)

	// window resize and arrangement
	{ MODKEY, 	                XK_h,			   setmfact,       {.f = -0.05} },
	{ MODKEY,          	        XK_l,			   setmfact,       {.f = +0.05} },
	{ MODKEY|ControlMask,           XK_f,			   togglefullscr,   {0} },
	{ MODKEY,                       XK_Return,		   zoom,           {0} },
	{ MODKEY,                       XK_Tab,			   view,           {0} },
	{ MODKEY|ControlMask,           XK_t,			   togglefloating, {0} },
	{ MODKEY,                       XK_0,			   view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,			   tag,            {.ui = ~0 } },
	//
       { MODKEY|ControlMask,           XK_n, 			   cyclelayout,    {.i = -1 } },
       { MODKEY|ControlMask,           XK_m, 			   cyclelayout,    {.i = +1 } },

	// gaps
	{ MODKEY,                       XK_minus,		   setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,		   setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,           	XK_minus,		   setgaps,        {.i = 0  } },
	{ MODKEY|ShiftMask,           	XK_equal,		   setgaps,        {.i = gappx  } },
	// brightness
	{ 0,                            XF86XK_MonBrightnessUp,    spawn,          SHCMD("xbacklight -inc +5 && kill -46 $(pidof dwmblocks)") },
	{ 0,                       	XF86XK_MonBrightnessDown,  spawn,          SHCMD("xbacklight -dec +5 && kill -46 $(pidof dwmblocks)") },
	// voulume
	{ 0,                            XF86XK_AudioMute, 	   spawn,     	   SHCMD("amixer sset Master toggle && kill -44 $(pidof dwmblocks)") },
	{ 0,                            XF86XK_AudioRaiseVolume,   spawn,      	   SHCMD("amixer sset Master 5%+ && kill -44 $(pidof dwmblocks)") },
	{ 0,                            XF86XK_AudioLowerVolume,   spawn,          SHCMD("amixer sset Master 5%- && kill -44 $(pidof dwmblocks)") },
	// screenshots
	{ MODKEY,                       XK_Print,    		   spawn,          SHCMD("~/scripts/sc") },
	{ MODKEY|ShiftMask,             XK_Print,    		   spawn,          SHCMD("~/scripts/sc -s") },
	{ MODKEY|ControlMask,           XK_Print,    		   spawn,          SHCMD("~/scripts/sc -cs") },
	//power
	{ MODKEY|ControlMask,           XK_p,    		   spawn,          SHCMD("~/scripts/dpower") },
	
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,	        XK_c,      quit,           {0} },
	{ MODKEY,		        XK_c,      quit,           {1} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

