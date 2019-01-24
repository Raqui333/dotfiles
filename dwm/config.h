/* See LICENSE file for copyright and license details. */

// font
static const char *fonts[] = {
	"fantasquesansmono:size=8"
};

// config
static const char normbordercolor[] = "#444444";
static const char normbgcolor[]     = "#202020";
static const char normfgcolor[]     = "#cdcdcd";
static const char selbordercolor[]  = "#cdcdcd";
static const char selbgcolor[]      = "#cdcdcd";
static const char selfgcolor[]      = "#000000";
static const unsigned int gappx     = 10;
static const unsigned int borderpx  = 4;
static const unsigned int snap      = 30;
static const int showbar            = 1;
static const int topbar             = 1;

// workspaces
static const char *tags[] = { "TERM", "MSg", "WWW", "CODE", "OTHERS", "6", "7", "8", "9" };

static const Rule rules[] = {
	// class      instance    title       tags mask     isfloating   monitor
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
};

// layout(s)
static const float mfact     = 0.55; // factor of master area size [0.05..0.95]
static const int nmaster     = 1;    // number of clients in master area
static const int resizehints = 1;    // 1 means respect size hints in tiled resizals

static const Layout layouts[] = {
	// layout
    // first entry is default
	{ "[T]", tile },
	{ "[M]", monocle },
    { "[F]", NULL },
};

// key definitions
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} },

// commands
static const char *urxvt[]     =  { "urxvt", NULL };
static const char *rofi[]      =  { "rofi", "-show", "run" };
static const char *print[]     =  { "printshotter", "-n" };
static const char *firefox[]   =  { "firefox", NULL };
static const char *telegram[]  =  { "telegram", NULL };

static Key keys[] = {
	// modifier                     key        function        argument
    { MODKEY,                       XK_d,      spawn,          {.v = rofi } },
    { MODKEY,                       XK_Return, spawn,          {.v = urxvt } },
    { MODKEY,                       XK_f,      spawn,          {.v = firefox } },
    { MODKEY,                       XK_t,      spawn,          {.v = telegram } },
    { 0,                            XK_Print,  spawn,          {.v = print } },
    { MODKEY,                       XK_b,      togglebar,      {0} },
    { MODKEY,                       XK_Up,     focusstack,     {.i = +1 } },
    { MODKEY,                       XK_Down,   focusstack,     {.i = -1 } },
    { MODKEY|ControlMask,           XK_Left,   setmfact,       {.f = -0.05} },
    { MODKEY|ControlMask,           XK_Right,  setmfact,       {.f = +0.05} },
    { MODKEY|ShiftMask,             XK_Left,   incnmaster,     {.i = +1} },
    { MODKEY|ShiftMask,             XK_Right,  incnmaster,     {.i = -1} },
    { MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
    { MODKEY,                       XK_F1,     togglefloating, {0} },
    { MODKEY,                       XK_F2,     setlayout,      {.v = &layouts[1]} },
    { MODKEY,                       XK_F3,     setlayout,      {.v = &layouts[2]} },
    { MODKEY|ShiftMask,             XK_c,      quit,           {0} },
	
    TAGKEYS( XK_1, 0)
    TAGKEYS( XK_2, 1)
    TAGKEYS( XK_3, 2)
    TAGKEYS( XK_4, 3)
    TAGKEYS( XK_5, 4)
    TAGKEYS( XK_6, 5)
    TAGKEYS( XK_7, 6)
    TAGKEYS( XK_8, 7)
    TAGKEYS( XK_9, 8)
};

// button definitions
// click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin
static Button buttons[] = {
	// click                event mask      button          function        argument
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
};
