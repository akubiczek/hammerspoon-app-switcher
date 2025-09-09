
-- ---------------------------------------------------------
-- APP SWITCHER FUNCTIONS - DO NOT EDIT THIS!
-- SCROLL DOWN TO THE KEYBOARD SHORTCUTS SECTION
-- ---------------------------------------------------------

local function cycleApplicationWindows(appObject)
  local visibleWindows = appObject:visibleWindows()
  local trulyVisibleWindows = {}

  for _, win in ipairs(visibleWindows) do
    local meetsCriteria = true
    if not win:isVisible() then
      meetsCriteria = false
    end

    if win:subrole() ~= "AXStandardWindow" then
      meetsCriteria = false
    end

    if meetsCriteria then
      table.insert(trulyVisibleWindows, win)
    end
  end

  if #trulyVisibleWindows <= 1 then
    return
  end

  table.sort(trulyVisibleWindows, function(a, b)
    return a:id() < b:id()
  end)

  local currentWindow = appObject:focusedWindow()
  local found = false

  for i, win in ipairs(trulyVisibleWindows) do
    if win:id() > currentWindow:id() then
      win:focus()
      found = true
      break
    end
  end

  if not found then
    trulyVisibleWindows[1]:focus()
  end
end

local function activateOrLaunch(bundleID)
  local frontmostApp = hs.application.frontmostApplication()

  if frontmostApp and frontmostApp:bundleID() == bundleID then
    cycleApplicationWindows(frontmostApp)
  else
    hs.application.launchOrFocusByBundleID(bundleID)
  end
end


-- ---------------------------------------------------------
-- KEYBOARD SHORTCUTS SECTION
--
-- General schema:
-- 
-- hs.hotkey.bind({MODIFIERS}, KEYCODE, function ()
--   activateOrLaunch(BUNDLE IDENTIFIER)
-- end)
--
-- Available MODIFIERS:
-- - "ctrl" - Control key
-- - "alt" - Option key
-- - "cmd" - Command key
--
--
-- YOUR KEYBOARD SHORTCUTS GOES HERE
-- FEEL FREE TO MODIFY THIS:
-- ---------------------------------------------------------

-- Switch to Safari by pressing Control+Option+Shift+S
hs.hotkey.bind({"ctrl", "alt", "shift"}, "S", function ()
  activateOrLaunch("com.apple.Safari")
end)

-- Switch to Messages by pressing Option+Enter
hs.hotkey.bind({"alt"}, "RETURN", function ()
  activateOrLaunch("com.apple.MobileSMS")
end)

-- Switch to Apple Main by pressing Command+F2
hs.hotkey.bind({"cmd"}, "F2", function ()
  activateOrLaunch("com.apple.mail")
end)

-- Switch to Passwords by pressing F3 without any modifiers
hs.hotkey.bind({}, "F3", function ()
  activateOrLaunch("com.apple.Passwords")
end)