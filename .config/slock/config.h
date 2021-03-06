/* user and group to drop privileges to */
static const char *user  = "sam";
static const char *group = "sam";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#282a36",     /* after initialization */
	[INPUT] =  "#282a36",     /* during input */
	[FAILED] = "#ff5555",     /* wrong password */
	[CAPS] =   "#f1fa8c",     /* CapsLock on */
};

/* time in seconds before the monitor shuts down */
static const int monitortime = 5;

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* default message */
static const char * message = "Locked at  $(date)";

/* text color */
static const char * text_color = "#ff6ac1";

/* text size (must be a valid size) */
static const char * font_name = "*courier-bold-r*200*";
