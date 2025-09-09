# App Launcher & Focus Script for Hammerspoon

This is a Hammerspoon script that lets you assign specific keyboard shortcuts to any application on your Mac.

When you press the defined shortcut:
1. The system switches focus to that application.
2. If the application is not running, it will be launched.
3. If the application already has multiple windows open, pressing the shortcut repeatedly cycles through all of that app's windows.

## How to use it

1. Install the [Hammerspoon app](https://www.hammerspoon.org).
2. Copy the code from this script into your main Hammerspoon configuration file, located at `~/.hammerspoon/init.lua`. (If you already have an init.lua file, simply add this script's content to it.)
3. Edit `~/.hammerspoon/init.lua` to configure your preferred keyboard shortcuts and target applications.
4. Click the Hammerspoon icon in your menu bar and select **Reload Config** for the changes to take effect.

**Examples:**
```
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
```
## How to get a Bundle Identifier of an app

While editing the init.lua file, you must provide the application's unique **Bundle Identifier**. You cannot use the app's common name (like "Chrome"); it must be the identifier.

You can easily find the Bundle Identifier for any installed app using Terminal.
1. Open the Terminal app.
2. Type the following command, replacing `APP NAME` with the exact name of the application (e.g., "Mail", "ChatGPT", or "Google Chrome").

```
osascript -e 'id of app „APP NAME"'
```

**Examples:**
```
# This will return "com.apple.mail"
osascript -e 'id of app "Mail"'

# This will return "com.openai.chat"
osascript -e 'id of app "ChatGPT"'

# This will return "com.google.Chrome"
osascript -e 'id of app "Google Chrome"'

# This will return "com.sublimetext.4" (or similar)
osascript -e 'id of app "Sublime Text"'
```

## Common Bundle Identifiers

Here is a list of common identifiers to help you get started:

* **1password:** com.1password.1password
* **Apple Passwords:** com.apple.Passwords
* **Brave:** com.brave.Browser
* **Calendar:** com.apple.iCal
* **Calculator:** com.apple.calculator
* **ChatGPT:** com.openai.chat
* **Chrome:** com.google.Chrome
* **Discord:** com.hnc.Discord
* **Keynote:** com.apple.iWork.Keynote
* **Mail:** com.apple.mail
* **Messages:** com.apple.MobileSMS
* **Music:** com.apple.Music
* **Numbers:** com.apple.iWork.Numbers
* **Pages:** com.apple.iWork.Pages
* **Photos:** com.apple.Photos
* **Safari:** com.apple.Safari
* **Slack:** com.tinyspeck.slackmacgap
* **Terminal:** com.apple.Terminal
* **Visual Studio Code:** com.microsoft.VSCode

## Alternatives

Hammerspoon has an official "Spoon" (plugin) called [AppWindowSwitcher](https://www.hammerspoon.org/Spoons/AppWindowSwitcher.html). However, that tool is designed only to switch between already running applications; it cannot launch an application that is closed. This script handles both launching and focusing.