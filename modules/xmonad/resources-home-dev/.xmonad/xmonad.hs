{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, TypeSynonymInstances #-}

import qualified Codec.Binary.UTF8.String as UTF8
import Data.Monoid

import XMonad
import qualified Data.Map as M
import Data.List
import Data.Bits ((.|.))
import Data.Default
import Graphics.X11.ExtraTypes.XF86
import Graphics.X11.Xlib
import Graphics.X11.Xlib.Extras
import XMonad.Layout
import XMonad.Operations
import XMonad.ManageHook
import XMonad.Layout.Reflect
import XMonad.Layout.Spacing
import XMonad.Hooks.ManageHelpers
import qualified XMonad.Layout.Fullscreen as FS
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.DynamicLog
import System.IO
import System.Exit
import Control.Monad
import qualified XMonad.StackSet as W

import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Hooks.ManageDocks
import XMonad.Config.Desktop
import XMonad.Util.SpawnOnce

myTerminal          = "lxterminal"
-- myTerminal          = "/home/dev/.cargo/bin/alacritty"
myFocusFollowsMouse = False
myClickJustFocuses  = False

myModMask       = mod4Mask -- super
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList [
    ((modMask .|. mod1Mask, xK_q), io (exitWith ExitSuccess))
  ]

myLayout = spacingWithEdge 5 myLayout2
  where
    myLayout2 = (reflectHoriz tiled) ||| (Mirror tiled) ||| Full
      where
         -- default tiling algorithm partitions the screen into two panes
         tiled   = Tall nmaster delta ratio

         -- The default number of windows in the master pane
         nmaster = 1

         -- Default proportion of screen occupied by master pane
         ratio   = 75/100

         -- Percent of screen to increment by when resizing panes
         delta   = 5/100


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "Gimp"           --> doFloat
    , className =? "transmission-gtk" --> doFloat
    , className =? "mpv" --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , (stringProperty "_NET_WM_NAME" =? "Open Folder") --> doFloat
    , fmap (isInfixOf "display") appCommand --> doFloat
    , fmap (isInfixOf "feh") appCommand --> doFloat
    , (stringProperty "WM_WINDOW_ROLE" =? "GtkFileChooserDialog") --> doFullFloat
    , isFullscreen                  --> doFullFloat
    , FS.fullscreenManageHook
    ]
    where
    appCommand = stringProperty "WM_COMMAND"

-- myStartupHook = do
--   spawnOnce "$HOME/.config/polybar/launch.sh"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
main = do
    xmonad $ desktopConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = 1,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        keys               = myKeys <+> keys XMonad.def,
        layoutHook         = desktopLayoutModifiers $ myLayout,
        manageHook         = myManageHook <+> manageHook desktopConfig,
        handleEventHook    = fullscreenEventHook <+> handleEventHook desktopConfig
        -- startupHook        = myStartupHook <+> startupHook desktopConfig
    }
