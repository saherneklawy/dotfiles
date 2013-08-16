-- Imports.
import XMonad
import XMonad.Config.Gnome
import Data.Monoid
import System.Exit
import XMonad.Hooks.DynamicLog

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
-- import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
-- import XMonad.Layout.Named
import XMonad.Util.Run(spawnPipe)

import qualified Data.Map        as M
import qualified XMonad.StackSet as W

-- Data.List provides isPrefixOf isSuffixOf and isInfixOf
import Data.List

import XMonad.Hooks.EwmhDesktops

import Control.Monad (liftM2)

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = gnomeConfig
    { terminal    = myTerminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    , workspaces  = myWorkspaces
    , keys        = myKeys
    , focusFollowsMouse  = myFocusFollowsMouse
    , layoutHook         = smartBorders $ myLayout
    , manageHook         = myManageHook
    , handleEventHook    = fullscreenEventHook
    }

-- yes, these are functions; just very simple ones
-- that accept no input and return static values
myTerminal    = "gnome-terminal"
myModMask     = mod4Mask -- Win key or Super_L
myBorderWidth = 1
myWorkspaces    = ["1:web","2:code","3:terms","4", "5", "6:srvs", "7", "8", "9"]

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "/usr/bin/bash -l -i -c 'dmenu_run'")
    , ((modm,               xK_s     ), spawn "/usr/bin/bash -l -i -c 'spell_check'")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    -- , ((modMask .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS # needs package xorg-xprop on arch
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.a
--
-- see http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Doc-Extending.html#g:15 for more
--

-- lifting the ~? function to use inside ManagedHooks
q ~? x = fmap (x `isInfixOf`) q

(=!) :: Eq a => Query a -> a -> Query Bool
q =! x = fmap (/= x) q

role = stringProperty "WM_WINDOW_ROLE"


myManageHook = composeAll
      [ resource ~? "/tmp/.org.chromium.Chromium"  --> (doShift "9" <+> doFullFloat)
      , className =? "Google-chrome" <&&> role =! "pop-up" --> doShift "1:web"
      , className =? "Rhythmbox"                   --> doShift "8"
      , className =? "Pidgin"                      --> doShift "8"
      , title =? "mongod - server"                 --> viewShift "6:srvs"
      , title =? "elasticsearch - server"          --> viewShift "6:srvs" ]
    where viewShift = doF . liftM2 (.) W.greedyView W.shift
    --, resource  =? "desktop_window" --> doIgnore
    --, className =? "Galculator"     --> doFloat
    --, className =? "Steam"          --> doFloat
    --, className =? "Gimp"           --> doFloat
    --, resource  =? "gpicview"       --> doFloat
    --, className =? "MPlayer"        --> doFloat
    --, className =? "VirtualBox"     --> doShift "4:vm"
    --, className =? "Xchat"          --> doShift "5:media"
    -- , isFullscreen --> (doF W.focusDown <+> doFullFloat)]

------------------------------------------------------------------------
-- Layouts
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts (
    Tall 1 (3/100) (1/2) |||
    Mirror (Tall 1 (3/100) (1/2)) |||
    Full |||
    tabbed shrinkText tabConfig |||
    spiral (6/7)) -- |||
    -- Named "FullScreen" (noBorders (fullscreenFull Full))

-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
tabConfig = defaultTheme {
    activeBorderColor = "#7C7C7C",
    activeTextColor = "#CEFFAC",
    activeColor = "#000000",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#EEEEEE",
    inactiveColor = "#000000"
}
