/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int colorprompt = 0;                /* -p  option; if 1, prompt uses SchemeSel, otherwise SchemeNorm */
static int fuzzy = 1;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching     */
static int centered = 0;                    /* -c option; centers dmenu on screen */
static int min_width = 800;                    /* minimum width when centered */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Hack-Bold:size=12"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#f1f1f0", "#282a36" },
	[SchemeSel] = { "#282a36", "#bd93f9" },
	[SchemeSelHighlight] = { "#282a36", "#bd93f9" },
	[SchemeNormHighlight] = { "#5af78e", "#282a36" },
	[SchemeOut] = { "#f1f1f0", "#282a36" },
	[SchemeMid] = { "#f1f1f0", "#282a36" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 20;
/* -h option; minimum height of a menu line */
static unsigned int lineheight = 22;
static unsigned int min_lineheight = 20;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = "/?\"&[]";

/* Size of the window border */
static const unsigned int border_width = 2;
