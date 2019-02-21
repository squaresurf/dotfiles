-- Helper Functions
function sleep(n)
  os.execute("sleep " .. tonumber(n))
end

-- Reload config on write.
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.dotfiles/hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

-- Window Hotkeys
hs.hotkey.bind({"ctrl", "alt"}, "m", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

-- h for half
hs.hotkey.bind({"ctrl", "alt"}, "c", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h * 1/6)
  f.w = max.w
  f.h = max.h * 2/3
  win:setFrame(f)
end)

hs.hotkey.bind({"ctrl", "alt"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"ctrl", "alt"}, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"ctrl", "alt"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Left with notifications
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w - 360
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"ctrl", "alt"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- g right
hs.hotkey.bind({"ctrl", "alt"}, "g", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  local w = f.w / 2
  f.x = f.x + w
  f.w = w
  win:setFrame(f)
end)

-- d left
hs.hotkey.bind({"ctrl", "alt"}, "d", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w / 2
  win:setFrame(f)
end)

-- r up
hs.hotkey.bind({"ctrl", "alt"}, "r", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h / 2
  win:setFrame(f)
end)

-- f down
hs.hotkey.bind({"ctrl", "alt"}, "f", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  local h = f.h / 2
  f.y = f.y + h
  f.h = h
  win:setFrame(f)
end)

hs.hotkey.bind({"ctrl", "alt"}, "j", function()
  local win = hs.window.focusedWindow()
  win:moveToScreen(win:screen():next())
end)

hs.hotkey.bind({"ctrl", "alt"}, "k", function()
  local win = hs.window.focusedWindow()
  win:moveToScreen(win:screen():previous())
end)
