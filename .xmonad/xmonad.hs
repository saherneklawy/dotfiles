-- Imports.
import XMonad
import XMonad.Hooks.DynamicLog

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = defaultConfig
    { terminal    = myTerminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    , workspaces  = myWorkspaces
    }

-- yes, these are functions; just very simple ones
-- that accept no input and return static values
myTerminal    = "gnome-terminal"
myModMask     = mod4Mask -- Win key or Super_L
myBorderWidth = 1
myWorkspaces    = ["web","code","terms","4", "5", "srvs", "7", "8", "9"]