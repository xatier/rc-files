-- Variable config
hs.window.animationDuration = 0
hs.window.setShadows(false)

-- primary should be the retina display
local primaryScreen = hs.screen.primaryScreen()

-- auto reload config
local configFileWatcher = hs.pathwatcher.new(hs.configdir, hs.reload):start()

-- modifier keys
local keys = {
    mod4 = { 'alt' },
    mod4_ctrl = { 'alt', 'ctrl' },
    mod4_ctrl_shift = { 'alt', 'ctrl', 'shift' },
}

-- initialize global state for focused window per screen
local perScreenCur = {}
for _, screen in pairs(hs.screen.allScreens()) do
    perScreenCur[screen:id()] = 1
end


-- reload config
hs.hotkey.bind(keys.mod4_ctrl, 'r', function()
    hs.reload()
end)


-- mod4 + f: toggle full size
local frameSizeCache = {}
hs.hotkey.bind(keys.mod4, 'f', function()
    local win = hs.window.focusedWindow()
    if frameSizeCache[win:id()] then
        win:setFrame(frameSizeCache[win:id()])
        frameSizeCache[win:id()] = nil
    else
        frameSizeCache[win:id()] = win:frame()
        win:maximize()
    end
end)


-- mod4 ctrl + j/k: switch focus between screens
local function showFocusWindow()
    local win = hs.window.focusedWindow()
    hs.alert.show(win:application():name())
end

local function moveMouseAndClick(screen)
    local rect = screen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.setAbsolutePosition(center)
    hs.eventtap.leftClick(center)
end

hs.hotkey.bind(keys.mod4_ctrl, 'j', function()
    moveMouseAndClick(hs.mouse.getCurrentScreen():next())
    showFocusWindow()
end)
hs.hotkey.bind(keys.mod4_ctrl, 'k', function()
    moveMouseAndClick(hs.mouse.getCurrentScreen():previous())
    showFocusWindow()
end)


-- mod4 + o: move window to another screen
hs.hotkey.bind(keys.mod4, 'o', function()
    local nextScreen = hs.mouse.getCurrentScreen():next()
    local win = hs.window.focusedWindow()
    moveMouseAndClick(nextScreen)
    win:moveToScreen(nextScreen)
    win:focus()
    showFocusWindow()
end)


-- mod4 + j/k: switch focus between windows
hs.hotkey.bind(keys.mod4, 'j', function()
    local mouse_id = hs.mouse.getCurrentScreen():id()
    local wf_windows_on_current_screen = hs.window.filter.new(function(w)
        return w:screen():id() == mouse_id and w:isVisible() and w:isStandard()
    end)
    local windows = wf_windows_on_current_screen:getWindows(hs.window.filter.sortByCreatedLast)

    local cur = perScreenCur[mouse_id]
    cur = cur + 1
    if cur > #windows then
        cur = 1
    end
    perScreenCur[mouse_id] = cur

    local target = windows[cur]
    print('cur ' .. cur .. ' focus: ' .. target:application():name())
    target:focus()
    showFocusWindow()
end)
hs.hotkey.bind(keys.mod4, 'k', function()
    local mouse_id = hs.mouse.getCurrentScreen():id()
    local wf_windows_on_current_screen = hs.window.filter.new(function(w)
        return w:screen():id() == mouse_id and w:isVisible() and w:isStandard()
    end)
    local windows = wf_windows_on_current_screen:getWindows(hs.window.filter.sortByCreatedLast)

    local cur = perScreenCur[mouse_id]
    cur = cur - 1
    if cur == 0 then
        cur = #windows
    end
    perScreenCur[mouse_id] = cur

    local target = windows[cur]
    print('cur ' .. cur .. ' focus: ' .. target:application():name())
    target:focus()
    showFocusWindow()
end)


-- mod4 + ctrl + shift + hjkl: resize window
hs.hotkey.bind(keys.mod4_ctrl_shift, 'h', function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h

    win:setFrame(f)
    hs.alert.show('←')
end)
hs.hotkey.bind(keys.mod4_ctrl_shift, 'l', function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h

    win:setFrame(f)
    hs.alert.show('→')
end)
hs.hotkey.bind(keys.mod4_ctrl_shift, 'j', function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w
    f.h = max.h / 2

    win:setFrame(f)
    hs.alert.show('↓')
end)
hs.hotkey.bind(keys.mod4_ctrl_shift, 'k', function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()


    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h / 2

    win:setFrame(f)
    hs.alert.show('↑')
end)


-- everything is fine
hs.alert.show('Hammerspoon Config loaded')
