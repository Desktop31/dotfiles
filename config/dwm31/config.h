/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappx     = 8;        /* gaps between windows */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int usealtbar          = 1;        /* 1 means use non-dwm status bar */
static const char *altbarclass      = "Polybar"; /* Alternate bar class name */
static const char *alttrayname      = "tray";    /* Polybar tray instance name */
static const char *altbarcmd        = "$HOME/.config/polybar/polybar_launch.sh"; /* Alternate bar launch command */
static const char *fonts[]          = { "NotoSans-Regular:size=12" };
static const char dmenufont[]       = "NotoSans-Regular:size=12";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#948510"; // 005577
// static const char col_yellow[]	    = "c7b42d";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
// static const char *tags[] = { "", "", "", "", "", "", "", "", "" };
// ①②③④⑤⑥⑦⑧⑨ - iosevka
static const char *tags[] = { "", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class        instance    title       tags mask     isfloating   monitor */
	{ "Spotify",       NULL,       NULL,       1 << 7,        0,           -1 }, // retard spotify not working
	{ "discord",       NULL,       NULL,       1 << 8,        0,           1 },
	{ "Brave-browser", NULL,       NULL,            1,        0,           -1 },
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
#define AltMask Mod1Mask  // Alt key
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]       = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]        = { "alacritty", NULL };
static const char *filemanagercmd[] = { "nautilus", NULL };
static const char *discord[]        = { "discord", NULL };
static const char *brave[]          = { "brave", NULL };
static const char *screenshot[]     = { "flameshot", "gui", NULL };
static const char *rofiFB[]         = { "rofi", "-show", "filebrowser", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       36,      spawn,          {.v = termcmd } }, // t
	{ MODKEY,                       56,      togglebar,      {0} }, // b
	{ MODKEY,                       44,      focusstack,     {.i = +1 } }, // j
	{ MODKEY,                       45,      focusstack,     {.i = -1 } }, // k
	{ MODKEY,                       31,      incnmaster,     {.i = +1 } }, // i
	{ MODKEY,                       40,      incnmaster,     {.i = -1 } }, // d
	{ MODKEY,                       43,      setmfact,       {.f = -0.05} }, // h
	{ MODKEY,                       46,      setmfact,       {.f = +0.05} }, // l
	{ MODKEY|ShiftMask,             36, 	 zoom,           {0} }, // return
	{ MODKEY,                       23,      view,           {0} }, // tab
	{ MODKEY,                       24,      killclient,     {0} }, // q
	{ MODKEY,                       28,      setlayout,      {.v = &layouts[0]} }, // t
	{ MODKEY,                       41,      setlayout,      {.v = &layouts[1]} }, // f
	{ MODKEY,                       58,      setlayout,      {.v = &layouts[2]} }, // m
	{ MODKEY,                       65,      setlayout,      {0} }, // space
	{ MODKEY|ShiftMask,             65,      togglefloating, {0} }, // space
	{ MODKEY,                       19,      view,           {.ui = ~0 } }, // 0 - view all tags
	{ MODKEY|ShiftMask,             19,      tag,            {.ui = ~0 } }, // 0 - tag current window to all tags
	{ MODKEY,                       59,      focusmon,       {.i = -1 } }, // ,
	{ MODKEY,                       60,      focusmon,       {.i = +1 } }, // .
	{ MODKEY|ShiftMask,             59,      tagmon,         {.i = -1 } }, // ,
	{ MODKEY|ShiftMask,             60,      tagmon,         {.i = +1 } }, // .
	{ MODKEY,             	  	    114,     view_adjacent,  { .i = +1 } }, // right
	{ MODKEY,                       113,     view_adjacent,  { .i = -1 } }, // left
	{ MODKEY,                       20,      setgaps,        {.i = -1 } }, // =
	{ MODKEY,                       21,  	 setgaps,        {.i = +1 } }, // ´ ... 1 right from =
	{ MODKEY|ShiftMask,             21,  	 setgaps,        {.i = 0  } }, // same as above
	/* custom launch keys */
	{ MODKEY,                       11,      spawn,          {.v = brave } }, // 2
	{ MODKEY,                       13,      spawn,          {.v = discord } }, // 4
	{ MODKEY|ShiftMask,             39,      spawn,          {.v = screenshot } }, // s
	{ MODKEY,			            26,      spawn,          {.v = filemanagercmd } }, // e
	{ MODKEY,                       27,      spawn,          SHCMD("$HOME/.config/rofi/launchers/misc/launcher.sh") }, // r - rofi app launcher
	{ MODKEY,                        9,      spawn,          SHCMD("$HOME/.config/rofi/powermenu/powermenu.sh") }, // ESC - rofi power menu
	{ MODKEY,                       41,      spawn,          {.v = rofiFB } }, // f
    /* volume keys */
	{ 0,                           122,      spawn,          SHCMD("pactl set-sink-volume $(pactl get-default-sink) -5%") }, // fn + F10 VOLUME DOWN
	{ 0,                           123,      spawn,          SHCMD("pactl set-sink-volume $(pactl get-default-sink) +5%") }, // fn + F11 VOLUME UP
	{ 0,                           121,      spawn,          SHCMD("pactl set-sink-mute $(pactl get-default-sink) toggle") }, // fn + F12 MUTE
	{ 0,                           233,      spawn,          SHCMD("brightnessctl s +10%") }, // raise brightness
	{ 0,                           232,      spawn,          SHCMD("brightnessctl s 10%-") }, // lower brightness
	TAGKEYS(                        67,                      0) // F1
	TAGKEYS(                        68,                      1) // F2
	TAGKEYS(                        69,                      2) // F3
	TAGKEYS(                        70,                      3) // F4
	TAGKEYS(                        71,                      4) // F5
	TAGKEYS(                        72,                      5) // F6
	TAGKEYS(                        73,                      6) // F7
	TAGKEYS(                        74,                      7) // F8
	TAGKEYS(                        75,                      8) // F9
	{ MODKEY|ShiftMask,             24,      quit,           {0} }, // q
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
	{ ClkTagBar,            0,              Button4,        view_adjacent,  { .i = -1 } },
	{ ClkTagBar,            0,              Button5,        view_adjacent,  { .i = +1 } },
};


static const char *ipcsockpath = "/tmp/dwm.sock";
static IPCCommand ipccommands[] = {
  IPCCOMMAND(  view,                1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  toggleview,          1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  tag,                 1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  toggletag,           1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  tagmon,              1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  focusmon,            1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  focusstack,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  zoom,                1,      {ARG_TYPE_NONE}   ),
  IPCCOMMAND(  incnmaster,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  killclient,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  togglefloating,      1,      {ARG_TYPE_NONE}   ),
  IPCCOMMAND(  setmfact,            1,      {ARG_TYPE_FLOAT}  ),
  IPCCOMMAND(  setlayoutsafe,       1,      {ARG_TYPE_PTR}    ),
  IPCCOMMAND(  quit,                1,      {ARG_TYPE_NONE}   )
};

static const char *const autostart[] = {
	"picom", "--experimental-backends", "-b", NULL,
	"nitrogen", "--restore", NULL,
	"emote", NULL,
	"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1", NULL,
	NULL
};
