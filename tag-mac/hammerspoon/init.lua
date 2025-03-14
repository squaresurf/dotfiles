hs.hotkey.bind({"cmd", "alt", "ctrl"}, "space", function()
  local win = hs.window.focusedWindow()

  win:moveToScreen(win:screen():next())
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "F", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  local screenFrame = screen:frame()

  -- Create a frame inset by 5 pixels on all sides
  local frame = {
    x = screenFrame.x + 8,
    y = screenFrame.y + 8,
    w = screenFrame.w - 16,
    h = screenFrame.h - 16
  }

  win:setFrame(frame)
end)
