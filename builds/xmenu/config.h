static struct Config config = {
	/* font, separate different fonts with comma */
	.font = "Hack Bold:size=11,Hack Bold:size=12",

	/* colors */
	.background_color = "#070707",
	.foreground_color = "#FFFFFF",
	.selbackground_color = "#57c7ff",
	.selforeground_color = "#070707",
	.separator_color =  "#ff6ac1",
	.border_color = "#ff6ac1",

	/* sizes in pixels */
	.width_pixels = 130,        /* minimum width of a menu */
	.height_pixels = 25,        /* height of a single menu item */
	.border_pixels = 2,         /* menu border */
	.separator_pixels = 3,      /* space around separator */
	.gap_pixels = 4,            /* gap between menus */

	/*
	 * The variables below cannot be set by X resources.
	 * Their values must be less than .height_pixels.
	 */

	/* geometry of the right-pointing isoceles triangle for submenus */
	.triangle_width = 3,
	.triangle_height = 7,

	/* the icon size is equal to .height_pixels - .iconpadding * 2 */
	.iconpadding = 2,

	/* area around the icon, the triangle and the separator */
	.horzpadding = 8,
};

/*
 * KEYBINDINGS
 *
 * Look at your /usr/include/X11/keysymdef.h  (or the equivalent file
 * in your system) for a list of key symbol constants, and change the
 * macros below accordingly.  All key symbol constants begin with the
 * prefix XK_.
 *
 * For example, to use vim-like key bindings, set KEYSYMLEFT to XK_h,
 * KEYSYMDOWN to XK_j, KEYSYMUP to XK_k, etc.
 *
 * Note that the regular keys like ArrowUp, ArrowDown, Tab, Home, etc
 * will ALWAYS work, so you do not need to set them.
 *
 * If you do not want to set a key binding, keep it with the value of
 * XK_VoidSymbol
 */
#define KSYMFIRST   XK_g       /* select first item */
#define KSYMLAST    XK_G       /* select last item */
#define KSYMUP      XK_k       /* select previous item */
#define KSYMDOWN    XK_j       /* select next item */
#define KSYMLEFT    XK_h       /* close current menu */
#define KSYMRIGHT   XK_l       /* enter selected item */
