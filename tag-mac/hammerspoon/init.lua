hs.hotkey.bind({"cmd", "alt", "ctrl"}, "space", function()
  local win = hs.window.focusedWindow()

  win:moveToScreen(win:screen():next())
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "F", function()
  hs.window.focusedWindow():maximize()
end)
