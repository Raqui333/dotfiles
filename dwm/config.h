/* See LICENSE file for copyright and license details. */

// custom function
static void gap_tile(Monitor *);

/* appearance */
static const unsigned int borderpx  = 4;        /* border pixel of windows */
static const unsigned int snap      = 30;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */

static const unsigned int gappx     = 10;
static const unsigned int barheight = 25;
static const unsigned int lrpadding = 25;

static const char *fonts[] = {
	"siji:size=10",
	"fantasquesansmono:size=8",
};

static const char theme_color[]	= "#eb5354";
static const char bar_color[]   = "#202020";

static const char black[]       = "#000000";
static const char white[]       = "#cdcdcd";
static const char grey[]        = "#414141";

static const char *colors[][3] = {
	/*               fg            bg           border   */
	[SchemeNorm]  = { white      , bar_color  , grey  },
	[SchemeSel]   = { black      , theme_color, white },
	[SchemeTitle] = { theme_color, bar_color  , 0     },
};

/* tagging */
static const char *tags[] = { "TERM", "MSg", "WWW", "CODE", "OTHERS", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "" , gap_tile },
	{ "", tile      },
	{ "" , monocle  },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} },

/* commands */
static const char *urxvt[]     =  { "urxvt", NULL };
static const char *dmenu[]     =  { "dmenu_run", "-l", "5", "-sb", theme_color, "-nb", bar_color, "-fn", "fantasquesansmono:size=10", NULL };
static const char *print[]     =  { "printshotter", "-n", NULL };
static const char *firefox[]   =  { "apulse", "firefox", NULL };
static const char *telegram[]  =  { "telegram", NULL };

static const char *volume_up[] = { "amixer", "set", "Master", "5%+", NULL };
static const char *volume_dn[] = { "amixer", "set", "Master", "5%-", NULL };

static const char *sublime[]   = { "sublime", NULL };

static Key keys[] = {
	// modifier                     key        function        argument
    { 0,                            XK_Print,  spawn,          { .v = print } },
    { MODKEY,                       XK_d,      spawn,          { .v = dmenu } },
    { MODKEY,                       XK_Return, spawn,          { .v = urxvt } },
    { MODKEY,                       XK_f,      spawn,          { .v = firefox } },
    { MODKEY,                       XK_t,      spawn,          { .v = telegram } },
    { MODKEY,                       XK_period, spawn,          { .v = volume_up } },
    { MODKEY,                       XK_comma,  spawn,          { .v = volume_dn } },
    { MODKEY,                       XK_k,      spawn,          { .v = sublime } },
    { MODKEY,                       XK_b,      togglebar,      {0} },
    { MODKEY,                       XK_Up,     focusstack,     {.i = +1 } },
    { MODKEY,                       XK_Down,   focusstack,     {.i = -1 } },
    { MODKEY|ControlMask,           XK_Left,   setmfact,       {.f = -0.05} },
    { MODKEY|ControlMask,           XK_Right,  setmfact,       {.f = +0.05} },
    { MODKEY|ShiftMask,             XK_Left,   incnmaster,     {.i = +1} },
    { MODKEY|ShiftMask,             XK_Right,  incnmaster,     {.i = -1} },
    { MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
    { MODKEY,                       XK_F1,     togglefloating, {0} },
    { MODKEY,                       XK_F2,     setlayout,      {.v = &layouts[0]} },
    { MODKEY,                       XK_F3,     setlayout,      {.v = &layouts[1]} },
    { MODKEY,                       XK_F4,     setlayout,      {.v = &layouts[2]} },
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

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
};

// custom function
void gap_tile(Monitor *m) {
	unsigned int gap = gappx, i, n, h, mw, my, ty;
	Client *c;

	for (n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++);
	if (n == 0)
		return;

	if (n > m->nmaster)
		mw = m->nmaster ? m->ww * m->mfact : 0;
	else
		mw = m->ww;
	for (i = my = ty = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), i++)
		if (i < m->nmaster) {
			h = (m->wh - my - gap) / (MIN(n, m->nmaster) - i);
			resize(c, m->wx + gap, m->wy + my + gap, mw - (2*c->bw) - (2*gap), h - (2*c->bw) - gap, 0);
			my += HEIGHT(c) + gap;
		} else {
			h = (m->wh - ty - gap) / (n - i);
			resize(c, m->wx + mw + gap, m->wy + ty + gap, m->ww - mw - (2*c->bw) - (2*gap), h - (2*c->bw) - gap, 0);
			ty += HEIGHT(c) + gap;
		}
}
