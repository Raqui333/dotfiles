/* See LICENSE file for copyright and license details. */

/*
 * appearance
 *
 * font: see http://freedesktop.org/software/fontconfig/fontconfig-user.html
 */
static char *font = "FantasqueSansMono:size=8:antialias=true:autohint=true";
static int borderpx = 40;

/*
 * What program is execed by st depends of these precedence rules:
 * 1: program passed with -e
 * 2: utmp option
 * 3: SHELL environment variable
 * 4: value of shell in /etc/passwd
 * 5: value of shell in config.h
 */
static char *shell = "/bin/zsh";
char *utmp = NULL;
char *stty_args = "stty raw pass8 nl -echo -iexten -cstopb 38400";

/* identification sequence returned in DA and DECID */
char *vtiden = "\033[?6c";

/* Kerning / character bounding-box multipliers */
static float cwscale = 1.0;
static float chscale = 1.0;

/*
 * word delimiter string
 *
 * More advanced example: " `'\"()[]{}"
 */
char *worddelimiters = " ";

/* selection timeouts (in milliseconds) */
static unsigned int doubleclicktimeout = 300;
static unsigned int tripleclicktimeout = 600;

/* alt screens */
int allowaltscreen = 1;

/* frames per second st should at maximum draw to the screen */
static unsigned int xfps = 120;
static unsigned int actionfps = 30;

/*
 * blinking timeout (set to 0 to disable blinking) for the terminal blinking
 * attribute.
 */
static unsigned int blinktimeout = 0;

/*
 * thickness of underline and bar cursors
 */
static unsigned int cursorthickness = 2;

/*
 * bell volume. It must be a value between -100 and 100. Use 0 for disabling
 * it
 */
static int bellvolume = 0;

/* default TERM value */
char *termname = "st-256color";

/*
 * spaces per tab
 *
 * When you are changing this value, don't forget to adapt the »it« value in
 * the st.info and appropriately install the st.info in the environment where
 * you use this st version.
 *
 *	it#$tabspaces,
 *
 * Secondly make sure your kernel is not expanding tabs. When running `stty
 * -a` »tab0« should appear. You can tell the terminal to not expand tabs by
 *  running following command:
 *
 *	stty tabs
 */
unsigned int tabspaces = 8;

/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {
	/* 8 normal colors */
	"#050505",
	"#962433",
	"#256341",
	"#8c8508",
	"#295877",
	"#6f2a72",
	"#286570",
	"#afafaf",

	/* 8 bright colors */
	"#202020",
	"#db344a",
	"#399562",
	"#b7ae0b",
	"#3d82af",
	"#a43fa8",
	"#3c94a3",
	"#cdcdcd",

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	"#252525",
};


/*
 * Default colors (colorname index)
 * foreground, background, cursor, reverse cursor
 */
unsigned int defaultfg = 7;
unsigned int defaultbg = 256;
static unsigned int defaultcs = 7;
static unsigned int defaultrcs = 0;

/*
 * Default shape of cursor
 * 2: Block ("█")
 * 4: Underline ("_")
 * 6: Bar ("|")
 * 7: Snowman ("☃")
 */
static unsigned int cursorshape = 2;

/*
 * Default columns and rows numbers
 */

static unsigned int cols = 80;
static unsigned int rows = 24;

/*
 * Default colour and shape of the mouse cursor
 */
static unsigned int mouseshape = XC_xterm;
static unsigned int mousefg = 0;
static unsigned int mousebg = 7;

/*
 * Color used to display font attributes when fontconfig selected a font which
 * doesn't match the ones requested.
 */
static unsigned int defaultattr = 11;

/*
 * Internal mouse shortcuts.
 * Beware that overloading Button1 will disable the selection.
 */
static MouseShortcut mshortcuts[] = {
	/* button               mask            string */
	{ Button4,              XK_ANY_MOD,     "\033[D" },
	{ Button5,              XK_ANY_MOD,     "\033[C" },
};

/* Internal keyboard shortcuts. */
//#define MODKEY Mod1Mask
//#define TERMMOD (ControlMask|ShiftMask)

static Shortcut shortcuts[] = {
	/* mask                 keysym          function        argument */
	{ ControlMask,          XK_Insert,      clipcopy ,      {.i =  0} },
	{ ShiftMask  ,          XK_Insert,      clippaste,      {.i =  0} },
};

/*
 * Special keys (change & recompile st.info accordingly)
 *
 * Mask value:
 * * Use XK_ANY_MOD to match the key no matter modifiers state
 * * Use XK_NO_MOD to match the key alone (no modifiers)
 * appkey value:
 * * 0: no value
 * * > 0: keypad application mode enabled
 * *   = 2: term.numlock = 1
 * * < 0: keypad application mode disabled
 * appcursor value:
 * * 0: no value
 * * > 0: cursor application mode enabled
 * * < 0: cursor application mode disabled
 * crlf value
 * * 0: no value
 * * > 0: crlf mode is enabled
 * * < 0: crlf mode is disabled
 *
 * Be careful with the order of the definitions because st searches in
 * this table sequentially, so any XK_ANY_MOD must be in the last
 * position for a key.
 */

/*
 * If you want keys other than the X11 function keys (0xFD00 - 0xFFFF)
 * to be mapped below, add them to this array.
 */
static KeySym mappedkeys[] = { -1 };

/*
 * State bits to ignore when matching key or button events.  By default,
 * numlock (Mod2Mask) and keyboard layout (XK_SWITCH_MOD) are ignored.
 */
static uint ignoremod = Mod2Mask|XK_SWITCH_MOD;

/*
 * Override mouse-select while mask is active (when MODE_MOUSE is set).
 * Note that if you want to use ShiftMask with selmasks, set this to an other
 * modifier, set to 0 to not use it.
 */
static uint forceselmod = ShiftMask;

/*
 * This is the huge key array which defines all compatibility to the Linux
 * world. Please decide about changes wisely.
 */
static Key key[] = {
	/* keysym           mask            string      appkey appcursor */
	{ XK_Up,            XK_NO_MOD,      "\033[A",        0,     -1},
	{ XK_Down,          XK_NO_MOD,      "\033[B",        0,     -1},
	{ XK_Left,          XK_NO_MOD,      "\033[D",        0,     -1},
	{ XK_Right,         XK_NO_MOD,      "\033[C",        0,     -1},
	{ XK_Home,          XK_NO_MOD,      "\033[H",        0,     -1},
	{ XK_Insert,        XK_NO_MOD,      "\033[4h",      -1,      0},
	{ XK_Delete,        XK_NO_MOD,      "\033[P",       -1,      0},
	
	{ XK_End,           XK_NO_MOD,      "\033[4~",       0,      0},
	{ XK_Prior,         XK_NO_MOD,      "\033[5~",       0,      0},
	{ XK_Next,          XK_NO_MOD,      "\033[6~",       0,      0},
	{ XK_BackSpace,     XK_NO_MOD,      "\177",          0,	     0},

	{ XK_Up,            XK_NO_MOD,      "\033OA",        0,     +1},
	{ XK_Down,          XK_NO_MOD,      "\033OB",        0,     +1},
	{ XK_Left,          XK_NO_MOD,      "\033OD",        0,     +1},
	{ XK_Right,         XK_NO_MOD,      "\033OC",        0,     +1},
	{ XK_Home,          XK_NO_MOD,      "\033[1~",       0,     +1},
	{ XK_Insert,        XK_NO_MOD,      "\033[2~",      +1,      0},
	{ XK_Delete,        XK_NO_MOD,      "\033[3~",      +1,      0},
};

/*
 * Selection types' masks.
 * Use the same masks as usual.
 * Button1Mask is always unset, to make masks match between ButtonPress.
 * ButtonRelease and MotionNotify.
 * If no match is found, regular selection is used.
 */
static uint selmasks[] = {
	[SEL_RECTANGULAR] = Mod1Mask,
};

/*
 * Printable characters in ASCII, used to estimate the advance width
 * of single wide characters.
 */
static char ascii_printable[] =
	" !\"#$%&'()*+,-./0123456789:;<=>?"
	"@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_"
	"`abcdefghijklmnopqrstuvwxyz{|}~";
