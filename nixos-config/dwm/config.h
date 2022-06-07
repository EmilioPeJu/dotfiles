/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "OpenDyslexicMono:size=10" };
static const char dmenufont[]       = "OpenDyslexicMono:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	// { "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char scratchpadname[] = "scratchpad";
static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "125x33", "-e", "attach-or-new",  NULL };
static const char *shutdowncmd[]  = { "shutdown", "now", NULL };
static const char *volmute[]  = {"pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle", NULL};
static const char *volup[]    = {"pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%", NULL};
static const char *voldown[]  = {"pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%", NULL};

#include <X11/XF86keysym.h>
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ 0,                            XK_Print,  spawn,          SHCMD("maim -s $(date +%y%m%d-%H%M-%S).png") },
	{ShiftMask,                     XK_Print,  spawn,          SHCMD("maim -s | xclip -selection clipboard -t image/png") },
	{ MODKEY,                       XK_Return, spawn,          SHCMD("st") },
	{ MODKEY,                       XK_a,      spawn,          SHCMD("st -e pulsemixer") },
	{ MODKEY|ShiftMask,             XK_a,      spawn,          SHCMD("st -e ncmpc -h 127.0.0.1 -p 6600") },
	{ MODKEY,                       XK_c,      spawn,          SHCMD("clipmenu") },
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_d,      spawn,          SHCMD("st -e bashmount") },
	{ MODKEY,                       XK_g,      spawn,          SHCMD("select-greek-letter.sh") },
	{ MODKEY|ShiftMask,             XK_k,      spawn,          SHCMD("xkill") },
	{ MODKEY|ShiftMask,             XK_m,      spawn,          SHCMD("thunderbird") },
	{ MODKEY|ShiftMask,             XK_p,      spawn,          SHCMD("st -e python3") },
	{ MODKEY|ShiftMask,             XK_r,      spawn,          SHCMD("st -e htop") },
	{ MODKEY|ShiftMask,             XK_s,      spawn,          {.v = shutdowncmd } },
	{ MODKEY|ShiftMask,             XK_t,      spawn,          SHCMD("telegram-desktop") },
	{ MODKEY,                       XK_w,      spawn,          SHCMD("firefox") },
	{ MODKEY,                       XK_x,      spawn,          SHCMD("slock") },
	{ MODKEY,                       XK_z,      spawn,          SHCMD("zeal") },
	{ MODKEY,                       XK_grave,  togglescratch,  {.v = scratchpadcmd } },
	{ 0, XF86XK_AudioPrev,                     spawn,          SHCMD("mpc prev") },
	{ 0, XF86XK_AudioNext,                     spawn,          SHCMD("mpc next") },
	{ 0, XF86XK_AudioPause,                    spawn,          SHCMD("mpc toggle") },
	{ 0, XF86XK_AudioPlay,                     spawn,          SHCMD("mpc play") },
	{ 0, XF86XK_AudioStop,                     spawn,          SHCMD("mpc stop") },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ ControlMask|ShiftMask,        XK_Down,   spawn,          {.v = volmute } },
	{ ControlMask,                  XK_Down,   spawn,          {.v = voldown } },
	{ ControlMask,                  XK_Up,     spawn,          {.v = volup } },
	{ ControlMask,                  XK_1,     spawn,           SHCMD("st -e wyrd") },
	{ ControlMask|ShiftMask,        XK_1,     spawn,           SHCMD("setxkbmap us -variant altgr-intl -option ctrl:nocaps") },
	{ ControlMask,                  XK_2,     spawn,           SHCMD("st -e $EDITOR ~/notes.txt") },
	{ ControlMask,                  XK_3,     spawn,           SHCMD("st -e $EDITOR ~/remind/dry/$(date +%y-%m-%d).md") },
	{ ControlMask|ShiftMask,        XK_5,     spawn,           SHCMD("randomlist.sh") },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_c,      quit,           {0} },
	{ MODKEY|ShiftMask,             XK_x,      spawn,          SHCMD("systemctl suspend; slock") },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          SHCMD("st") },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

