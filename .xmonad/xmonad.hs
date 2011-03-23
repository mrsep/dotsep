import System.IO
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.CycleWS
-- import XMonad.Actions.DynamicWorkspaces
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spiral
import XMonad.Layout.Circle
import XMonad.Layout.CenteredMaster
import XMonad.Layout.Mosaic
import XMonad.Layout.Grid
import XMonad.Layout.Named
import XMonad.Layout.StackTile
import XMonad.Layout.Roledex
import XMonad.Prompt
import XMonad.Prompt.Shell
-- import XMonad.Prompt.Man
-- import XMonad.Prompt.Ssh

import qualified XMonad.StackSet as W
import qualified Data.Map        as M



modm = mod4Mask

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig

        { manageHook  = myManageHook <+> manageDocks
        , terminal    = "gnome-terminal"
        , focusedBorderColor = "#5d0017"
        , normalBorderColor  = "#1e1c10"
        , workspaces  = myWorkspaces
        , layoutHook  = myLayoutHook
        , logHook     = myLogHook xmproc
        , modMask     = modm
        , startupHook = setWMName "LG3D"
        } `additionalKeys` myKeys


myLayoutHook = avoidStruts $ smartBorders (
        named "Tall" tiled 
    ||| named "Mirror Tall" (Mirror tiled)
    ||| Full
    ||| Grid 
    ||| Circle
    ||| named "Center" (centerMaster Grid)
    ||| StackTile 1 delta (1/2) 
    ||| Roledex 
    ||| mosaic 2 [3,2]
    ||| spiral (6/7) 
    )
  where
    tiled   = Tall 1 delta ratio
    ratio   = toRational (2/(1+sqrt(5)::Double))
    delta   = 0.01


myWorkspaces = ["1:mail", "2:web", "3:java", "4:docs", "5:uni", "6:gsc-gsp", "7:media", "8", "9:config"]

myManageHook = composeAll [ isFullscreen --> doF W.focusDown <+> doFullFloat
                          , className =? "Thunderbird"     --> doShift "1:mail"
                          , className =? "Firefox"         --> doShift "2:web"
                          , className =? "Chrome"          --> doShift "7:media"
                          , className =? "Video"           --> doShift "7:media"
                          , title     =? "rhythmbox"       --> doShift "7:media"
                          , className =? "Gimp"            --> doFloat
                          ]

myLogHook h = dynamicLogWithPP $ xmobarPP
                                 { ppOutput = hPutStrLn h
                                 , ppTitle = xmobarColor "#cdcd57" "" . shorten 150
                                 , ppCurrent = xmobarColor "#cdcd57" "" -- . wrap "[" "]"
                                 , ppSep = " <fc=#3d3d07>|</fc> "
                                 }

myKeys = [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
         , ((0, xK_Print), spawn "scrot")
         , ((modm,               xK_Right), nextWS)
         , ((modm,               xK_Left),  prevWS)
         , ((modm .|. shiftMask, xK_Right), shiftToNext)
         , ((modm .|. shiftMask, xK_Left),  shiftToPrev)
         , ((modm,               xK_Up),    nextScreen)
         , ((modm,               xK_Down),  prevScreen)
         , ((modm .|. shiftMask, xK_Up),    shiftNextScreen)
         , ((modm .|. shiftMask, xK_Down),  shiftPrevScreen)
         , ((modm,               xK_z),     toggleWS)
--          , ((modm,               xK_f),     "fullscreen") ???
         --, ((modm,               xK_F1),    manPrompt defaultXPConfig)
         , ((modm,               xK_F2),    shellPrompt defaultXPConfig)
         --, ((modm,               xK_F3),    sshPrompt defaultXPConfig)
         ]

