//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"","~/scripts/bar/cpu",	5,		0},
	{"","~/scripts/bar/memory",	5,		0},
	{"","~/scripts/bar/internet",	5,		0},
	{"","~/scripts/bar/volume",	0,		10},
	{"","~/scripts/bar/backlight",	0,		12},
	{"","~/scripts/bar/battery",	5,		0},
	{"","~/scripts/bar/clock",	60,		0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "|";
static unsigned int delimLen = 5;
