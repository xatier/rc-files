-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- vicious widgets library
local vicious = require("vicious")


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.font = "Inconsolata 10"

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    -- awful.layout.suit.floating,
    awful.layout.suit.tile,               -- 1 (tile.right)
    awful.layout.suit.tile.left,          -- 2
    awful.layout.suit.tile.bottom,        -- 3
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,                -- 4
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal },
                                    { "ranger", "urxvtc -e ranger" },
                                    { "alsamixer", "urxvtc -e alsamixer" },
                                    { "www", "microsoft-edge-dev" },
                                  }
                        })

awful.menu.menu_keys = { up    = { "k", "Up" }, down  = { "j", "Down" },
                         enter = { "Right" }, back  = { "h", "Left" },
                         exec  = { "l", "Return", "Right" },
                         close = { "q", "Escape" },
                       }

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- awful.util.pread is deprecated in 4.0, use io.popen directly
local function mypread(command)
    local fd = io.popen(command)
    local lines = fd:read('*a')
    fd:close()
    return lines
end

-- set command output for tooltips below
local function async_set_text(command, tooltip)
   awful.spawn.easy_async_with_shell(command, function(stdout)
       tooltip:set_markup(command .. " :\n\n" .. stdout)
   end)
end

-- network usage
netwidget = wibox.widget.textbox()
vicious.register(netwidget, vicious.widgets.net,
                '<span color="#CC9090">⇩${enp6s0 down_mb}</span>' ..
                '<span color="#7F9F7F">⇧${enp6s0 up_mb}</span> MB/s', 1)


-- clock
clockwidget = wibox.widget.textclock("%a %b %d %H:%M:%S %p ", 1)
clockwidget_t = awful.tooltip({
    objects = { clockwidget },
    timeout = 30,
    timer_function = function ()
        async_set_text("cal -3", clockwidget_t)
        return 'loading'
    end
})

-- Taiwan time zone
clockTWwidget = wibox.widget.textbox()
clockTWwidget_t = awful.tooltip({
    objects = { clockTWwidget },
    timeout = 30,
    timer_function = function ()
        date_command = 'TZ=US/Pacific date "+%Z %m/%d %R %p"; ' ..
        'TZ=US/Central date "+%Z %m/%d %R %p"; ' ..
        'TZ=US/Eastern date "+%Z %m/%d %R %p"; ' ..
        'TZ=UTC date "+%Z %m/%d %R %p"'
        async_set_text(date_command, clockTWwidget_t)
        return 'loading'
    end
})

-- CPU usage
cpuwidget = wibox.widget.textbox()
cpuwidget_t = awful.tooltip({
    objects = { cpuwidget },
    timeout = 5,
    timer_function = function ()
        async_set_text("top -b -c -o %CPU -n 1 -w 150 | head -n 20", cpuwidget_t)
        return 'loading'
    end
})
vicious.register(cpuwidget, vicious.widgets.cpu,
                 '<span color="#CC0000">$1% </span>[$2:$3:$4:$5:$6:$7:$8:$9]', 2)

-- thermal widget
-- find /sys/devices/platform/coretemp.0 -name temp1_input
-- /sys/devices/platform/coretemp.0/hwmon/hwmon3/temp1_input
thermalwidget  = wibox.widget.textbox()
thermalwidget_t = awful.tooltip({
    objects = { thermalwidget },
    timeout = 5,
    timer_function = function ()
        async_set_text("sensors", thermalwidget_t)
        return 'loading'
    end
})
hwmon_command = "find /sys/devices/platform/coretemp.0 -name temp1_input | awk '{print substr($0, 23, 23)}'"
awful.spawn.easy_async_with_shell(hwmon_command, function(stdout)
    vicious.register(
        thermalwidget,
        vicious.widgets.thermal,
        " $1°C", 2,
        {
            stdout:gsub("%s+", ""),
            "core",
            "temp1_input"
        }
    )
end)

-- memory usage
memwidget = wibox.widget.textbox()
memwidget_t = awful.tooltip({
    objects = { memwidget },
    timeout = 5,
    timer_function = function ()
        async_set_text("free -h", memwidget_t)
        return 'loading'
    end
})
vicious.register(memwidget, vicious.widgets.mem,
                 '$2/$3 MB (<span color="#00EE00">$1%</span>)', 2)


-- battery status
batwidget = wibox.widget.textbox()
batwidget_t = awful.tooltip({
    objects = { batwidget },
    timeout = 5,
    timer_function = function ()
        async_set_text("acpi -V", batwidget_t)
        return 'loading'
    end
})
vicious.register(batwidget, vicious.widgets.bat, "$2% $3[$1]", 2, "BAT1")
batwidget:buttons(
    gears.table.join(
        awful.button({}, 1, function ()
            naughty.notify( {title="Ouch!!",
                             text="you click me!",
                             timeout=10})
        end)
    )
)

-- weather status
weatherwidget = wibox.widget.textbox()
weatherwidget_t = awful.tooltip({
    objects = { weatherwidget },
    timeout = 30,
    timer_function = function ()
        async_set_text("bash /home/xatier/bin/weather", weatherwidget_t)
        return 'loading'
    end
})

weatherwidget:buttons(
    awful.util.table.join(
        awful.button({}, 1, function ()
            naughty.notify( {title='Temperature 24 HR',
                             icon='/tmp/temp.png',
                             timeout=20})
        end)
    )
)

local update_TW = function()
    return "[" .. string.gsub(mypread('TZ=Asia/Taipei date "+%m/%d %R %p"'), "\n", "") .. "]"
end

weatherwidget.text = "☀ "
clockTWwidget.text = update_TW()

-- update every minutes
mytimer = timer({ timeout = 60 })
mytimer:connect_signal("timeout", function()
    clockTWwidget.text = update_TW()
end)
mytimer:start()


-- alsabox
alsaboxwidget = wibox.widget.textbox()
alsaboxwidget_t = awful.tooltip({
    objects = { alsaboxwidget },
    timeout = 30,
    timer_function = function ()
        async_set_text("amixer get Master", alsaboxwidget_t)
        return 'loading'
    end
})
vicious.register(alsaboxwidget, vicious.widgets.volume, "$2 [$1%]", 1, "Master")
alsaboxwidget:buttons(
    gears.table.join(
        awful.button({}, 1, function ()
            awful.spawn("amixer set Master toggle", false)
        end),
        awful.button({}, 4, function ()
            awful.spawn("amixer set Master 1+", false)
        end),
        awful.button({}, 5, function ()
            awful.spawn("amixer set Master 1-", false)
        end)
    )
)

-- widget separator
separator = wibox.widget.textbox()
separator.text = " | "


-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

beautiful.wallpaper = "/home/xatier/tmp/oono.jpg"
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({"⌨", "☠", "☢", "☣", "☮", "✈", "✍", "♺", "(．＿．?)"}, s, awful.layout.layouts[2])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            (screen.count() == 1 or s.index == 2) and netwidget,
            (screen.count() == 1 or s.index == 2) and separator,
            (screen.count() == 1 or s.index == 2) and cpuwidget,
            (screen.count() == 1 or s.index == 2) and thermalwidget,
            (screen.count() == 1 or s.index == 2) and separator,
            (screen.count() == 1 or s.index == 2) and memwidget,
            separator,
            -- batwidget,
            -- separator,
            alsaboxwidget,
            separator,
            clockwidget,
            clockTWwidget,
            separator,
            weatherwidget,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),

    -- lock
    awful.key({ modkey }, "F12", function () awful.spawn("xscreensaver-command -lock") end,
              {description = "screen lock", group = "screen"}),

    -- shutter as printscreen tools    http://shutter-project.org/
    awful.key({ }, "Print", function () awful.spawn("/usr/bin/shutter") end,
              {description = "Screenshot", group = "screen"})
)

clientkeys = gears.table.join(
    -- align windows vertically
    awful.key({ modkey,           }, "v",
        function (c)
            -- screen boundary
            -- clients to be rearranged
            -- divide the width evenly
            local screen_geom = c.screen.workarea
            local cls = c.screen.clients
            local width = screen_geom.width / #cls

            for i, c in pairs(cls) do
                -- make it float
                c.floating = true

                -- rearrange the geomery of this client
                local geom = c:geometry()
                geom.x = width * (i - 1)
                geom.y = screen_geom.y
                geom.height = screen_geom.height
                geom.width = width
                c:geometry(geom)
            end
        end,
              {description = "tile-vertically", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),

    -- toggle titlebar
    awful.key({ modkey, "Shift"   }, "t", awful.titlebar.toggle,
              {description = "toggle titlebar", group = "client"})

)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "exe",
          "Gpick",
          "Minecraft 1.11.2",
          "Mplayer",
          "mpv",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
          "Picture in picture",  -- video Picture in Picture mode
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Edge's Ctrl-Shift-A for tab searching
    { rule_any = {
        role = {
            "bubble",
        }
    }, properties = {
        floating = true, sticky = false, border_width = 0, skip_taskbar = true
    }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- remove the gaps for rxvt-unicode
    { rule = { class = "URxvt" },
      properties = { size_hints_honor = false } },

    -- Google Hangouts chrome extension
    { rule = { instance = "crx_knipolnnllmklapflnccelgolnpehhpl"},
      properties = { sticky = false, screen = 2} },

    -- Set Chromium always on screen 2
    { rule = { class = "Chromium" },
      properties = { screen = 2 } },

    -- Set PCManX always on screen 1
    { rule = { class = "PCManX" },
      properties = { screen = 1 } },

    -- Set Albert always on screen 1
    { rule = { class = "albert" },
      properties = { border_width = 0, skip_taskbar = true } },

    ---- Set Einstein to be floating
    --{ rule = { class = "einstein" },
    --  properties = { floating = true } },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }

    -- hide titlebar by default
    awful.titlebar.hide(c)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
