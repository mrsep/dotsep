import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Actions.CycleWS
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W

myManageHook = composeAll
    [-- isFullscreen --> doFullFloat
    isFullscreen --> doF W.focusDown <+> doFullFloat
    ]

modm = mod4Mask

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig

        { manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , terminal   = "gnome-terminal"
        , focusedBorderColor = "#5d0017"
        , normalBorderColor  = "#1e1c10"
        , workspaces = ["1:mail", "2:web", "3:java", "4:cari", "5:uni", "6", "7:fun", "8", "9:config"]
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook    = dynamicLogWithPP $ xmobarPP
                           { ppOutput = hPutStrLn xmproc
                           , ppTitle = xmobarColor "#cdcd57" "" . shorten 50
                           , ppCurrent = xmobarColor "#cdcd57" ""
                           , ppSep = " <fc=#3d3d07>|</fc> "
                           }
        , modMask = modm
        , startupHook = setWMName "LG3D"
        } `additionalKeys`
        [ 
            ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
          , ((0, xK_Print), spawn "scrot")
          -- Using Actions.CycleWS
          , ((modm,               xK_Right), nextWS)
          , ((modm,               xK_Left),  prevWS)
          , ((modm .|. shiftMask, xK_Right), shiftToNext)
          , ((modm .|. shiftMask, xK_Left),  shiftToPrev)
          , ((modm,               xK_Up),    nextScreen)
          , ((modm,               xK_Down),  prevScreen)
          , ((modm .|. shiftMask, xK_Up),    shiftNextScreen)
          , ((modm .|. shiftMask, xK_Down),  shiftPrevScreen)
          , ((modm,               xK_z),     toggleWS)
        ]
