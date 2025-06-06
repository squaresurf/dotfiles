--[[
  Refactored window management for Hammerspoon.
  Provides grid-based window positioning and an automatic layout manager.
--]]

-- Configuration
local MODIFIERS = {"cmd", "alt", "ctrl"}
local PADDING = 8
local GAP = 4

---
--- Calculates a frame for a cell within a grid on a given screen.
---
--- @param screenFrame table The frame of the screen to create the grid on.
--- @param rows number The total number of rows in the grid.
--- @param cols number The total number of columns in the grid.
--- @param row number The 1-indexed row of the cell.
--- @param col number The 1-indexed column of the cell.
--- @param padding number The padding around the entire grid.
--- @param gap number The gap between cells in the grid.
--- @return table A frame table {x, y, w, h} for the specified grid cell.
local function getGridFrame(screenFrame, rows, cols, row, col, padding, gap)
  local effectivePadding = padding or PADDING
  local effectiveGap = gap or GAP

  local paddedW = screenFrame.w - (2 * effectivePadding)
  local paddedH = screenFrame.h - (2 * effectivePadding)

  local cellW = (paddedW - (cols - 1) * effectiveGap) / cols
  local cellH = (paddedH - (rows - 1) * effectiveGap) / rows

  local x = screenFrame.x + effectivePadding + (col - 1) * (cellW + effectiveGap)
  local y = screenFrame.y + effectivePadding + (row - 1) * (cellH + effectiveGap)

  return {x = x, y = y, w = cellW, h = cellH}
end

---
--- Moves the currently focused window to a specified grid position.
---
--- @param rows number The total number of rows in the grid.
--- @param cols number The total number of columns in the grid.
--- @param row number The 1-indexed row to move the window to.
--- @param col number The 1-indexed column to move the window to.
local function moveFocusedWindow(rows, cols, row, col)
  local win = hs.window.focusedWindow()
  if not win then return end
  local screenFrame = win:screen():frame()
  local newFrame = getGridFrame(screenFrame, rows, cols, row, col)
  win:setFrame(newFrame)
end

-- Hotkey to move window to next screen and focus it
hs.hotkey.bind(MODIFIERS, "space", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local nextScreen = win:screen():next()
  win:moveToScreen(nextScreen)
  -- After moving, immediately focus the window on its new screen
  win:focus()
end)

-- Hotkey to focus the next screen
hs.hotkey.bind(MODIFIERS, "Z", function()
  local currentScreen = hs.window.focusedWindow():screen()
  if not currentScreen then return end

  local nextScreen = currentScreen:next()
  if not nextScreen then return end

  -- Get all windows on the next screen and focus the first one
  local windowsOnNextScreen = nextScreen:allWindows()
  if windowsOnNextScreen and #windowsOnNextScreen > 0 then
    windowsOnNextScreen[1]:focus()
  end
end)

-- Fullscreen with padding
hs.hotkey.bind(MODIFIERS, "F", function() moveFocusedWindow(1, 1, 1, 1) end)

-- Half-screen layouts
hs.hotkey.bind(MODIFIERS, "left", function() moveFocusedWindow(1, 2, 1, 1) end)
hs.hotkey.bind(MODIFIERS, "right", function() moveFocusedWindow(1, 2, 1, 2) end)

-- Quarter-screen layouts
hs.hotkey.bind(MODIFIERS, "Q", function() moveFocusedWindow(2, 2, 1, 1) end)
hs.hotkey.bind(MODIFIERS, "W", function() moveFocusedWindow(2, 2, 1, 2) end)
hs.hotkey.bind(MODIFIERS, "A", function() moveFocusedWindow(2, 2, 2, 1) end)
hs.hotkey.bind(MODIFIERS, "S", function() moveFocusedWindow(2, 2, 2, 2) end)

-- State to store the last known window order for each application
local windowOrderState = {}

---
--- Applies a master-stack layout with the master on the right.
--- The first window in the list is always treated as the master.
---
local function applyLayout(windows, screen)
  if not windows or #windows == 0 then return end

  local numWindows = #windows
  local screenFrame = screen:frame()

  if numWindows == 1 then
    -- Fullscreen a single window
    windows[1]:setFrame(getGridFrame(screenFrame, 1, 1, 1, 1))
  elseif numWindows == 2 then
    -- Master on right, stack on left
    windows[1]:setFrame(getGridFrame(screenFrame, 1, 2, 1, 2)) -- Master
    windows[2]:setFrame(getGridFrame(screenFrame, 1, 2, 1, 1)) -- Stack
  elseif numWindows == 4 then
    -- Special 2x2 grid layout, master (windows[1]) is top-right
    windows[1]:setFrame(getGridFrame(screenFrame, 2, 2, 1, 2))
    windows[2]:setFrame(getGridFrame(screenFrame, 2, 2, 1, 1))
    windows[3]:setFrame(getGridFrame(screenFrame, 2, 2, 2, 1))
    windows[4]:setFrame(getGridFrame(screenFrame, 2, 2, 2, 2))
  else -- 3 or 5+ windows
    -- Master on right, stack on left
    local masterFrame = getGridFrame(screenFrame, 1, 2, 1, 2)
    windows[1]:setFrame(masterFrame)

    local stackAreaFrame = getGridFrame(screenFrame, 1, 2, 1, 1)
    local stackWins = {}
    for i = 2, numWindows do
      table.insert(stackWins, windows[i])
    end

    for i, win in ipairs(stackWins) do
      local winFrame = getGridFrame(stackAreaFrame, #stackWins, 1, i, 1, 0, GAP)
      win:setFrame(winFrame)
    end
  end
end

---
--- Arrange windows based on a fresh geometric sort.
--- Establishes the initial order for cycling.
---
hs.hotkey.bind(MODIFIERS, "O", function()
  local focused_win = hs.window.focusedWindow()
  if not focused_win then return end

  local screen = focused_win:screen()
  local app = focused_win:application()
  if not (screen and app) then return end

  -- Get all visible windows for the app on the current screen
  local windowsOnScreen = {}
  for _, win in ipairs(app:visibleWindows()) do
    if win:screen() and win:screen():id() == screen:id() then
      table.insert(windowsOnScreen, win)
    end
  end

  if #windowsOnScreen == 0 then return end

  -- Sort windows geometrically to get a predictable initial order
  table.sort(windowsOnScreen, function(a, b)
    local frameA = a:frame()
    local frameB = b:frame()
    if frameA.y < frameB.y then return true end
    if frameA.y > frameB.y then return false end
    return frameA.x < frameB.x
  end)

  -- Store the new order as a list of window IDs
  local newOrderIDs = {}
  for _, win in ipairs(windowsOnScreen) do
    table.insert(newOrderIDs, win:id())
  end
  windowOrderState[app:name()] = newOrderIDs

  applyLayout(windowsOnScreen, screen)
end)

---
--- Cycle the master window based on the last known order.
---
hs.hotkey.bind(MODIFIERS, "C", function()
  local focused_win = hs.window.focusedWindow()
  if not focused_win then return end

  local screen = focused_win:screen()
  local app = focused_win:application()
  if not (screen and app) then return end
  local appName = app:name()

  -- Get the last known order of window IDs
  local storedIDs = windowOrderState[appName]
  if not storedIDs or #storedIDs < 2 then
    hs.hotkey.trigger(MODIFIERS, "O")
    return
  end

  -- Get currently visible windows and their IDs
  local currentWindows = {}
  local currentIDs = {}
  for _, win in ipairs(app:visibleWindows()) do
    if win:screen() and win:screen():id() == screen:id() then
      table.insert(currentWindows, win)
      currentIDs[win:id()] = true
    end
  end

  -- Validate the stored order: remove closed, add new
  local validatedIDs = {}
  for _, id in ipairs(storedIDs) do
    if currentIDs[id] then
      table.insert(validatedIDs, id)
    end
  end

  local newWindowIDs = {}
  for _, id in ipairs(validatedIDs) do newWindowIDs[id] = true end
  for _, win in ipairs(currentWindows) do
    if not newWindowIDs[win:id()] then
      table.insert(validatedIDs, win:id())
    end
  end

  if #validatedIDs < 2 then return end

  -- Rotate the validated list of IDs
  table.insert(validatedIDs, table.remove(validatedIDs, 1))
  windowOrderState[appName] = validatedIDs -- Save the new order

  -- Build the final list of window objects in the new order
  local windowMap = {}
  for _, win in ipairs(currentWindows) do windowMap[win:id()] = win end

  local finalWindows = {}
  for _, id in ipairs(validatedIDs) do
    table.insert(finalWindows, windowMap[id])
  end

  applyLayout(finalWindows, screen)
end)

---
--- Cycle the master window in reverse.
---
hs.hotkey.bind(MODIFIERS, "X", function()
  local focused_win = hs.window.focusedWindow()
  if not focused_win then return end

  local screen = focused_win:screen()
  local app = focused_win:application()
  if not (screen and app) then return end
  local appName = app:name()

  -- Get the last known order of window IDs
  local storedIDs = windowOrderState[appName]
  if not storedIDs or #storedIDs < 2 then
    hs.hotkey.trigger(MODIFIERS, "O")
    return
  end

  -- Get currently visible windows and their IDs
  local currentWindows = {}
  local currentIDs = {}
  for _, win in ipairs(app:visibleWindows()) do
    if win:screen() and win:screen():id() == screen:id() then
      table.insert(currentWindows, win)
      currentIDs[win:id()] = true
    end
  end

  -- Validate the stored order: remove closed, add new
  local validatedIDs = {}
  for _, id in ipairs(storedIDs) do
    if currentIDs[id] then
      table.insert(validatedIDs, id)
    end
  end

  local newWindowIDs = {}
  for _, id in ipairs(validatedIDs) do newWindowIDs[id] = true end
  for _, win in ipairs(currentWindows) do
    if not newWindowIDs[win:id()] then
      table.insert(validatedIDs, win:id())
    end
  end

  if #validatedIDs < 2 then return end

  -- Rotate the validated list of IDs in reverse
  table.insert(validatedIDs, 1, table.remove(validatedIDs))
  windowOrderState[appName] = validatedIDs -- Save the new order

  -- Build the final list of window objects in the new order
  local windowMap = {}
  for _, win in ipairs(currentWindows) do windowMap[win:id()] = win end

  local finalWindows = {}
  for _, id in ipairs(validatedIDs) do
    table.insert(finalWindows, windowMap[id])
  end

  applyLayout(finalWindows, screen)
end)
