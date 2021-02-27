--imports

import XMonad
import System.Exit
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.WindowBringer
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "st"

myTerminalAlt :: String
myTerminalAlt = "alacritty"

myFilemanager :: String
myFilemanager = "st -e vifm"

myFilemanagerAlt :: String
myFilemanagerAlt = "pcmanfm"

myBrowser :: String
myBrowser = "tabbed -c vimb -e"

myBrowserAlt :: String
myBrowserAlt = "librewolf"

myMail :: String
myMail = "st -e neomutt"

myMusicplayer :: String
myMusicplayer = "st -e cums"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth   = 2

myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

--myNormalBorderColor  = "dddddd"

myFocusedBorderColor = "#ff6ac1"

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ 
      -- spawn applications
      ((modm                  ,  xK_t                    ), spawn myTerminal)
    , ((modm.|. shiftMask     ,  xK_t                    ), spawn myTerminalAlt)
    , ((modm                  ,  xK_f                    ), spawn myFilemanager)
    , ((modm.|. shiftMask     ,  xK_f                    ), spawn myFilemanagerAlt)
    , ((modm                  ,  xK_b                    ), spawn myBrowser)
    , ((modm .|. shiftMask    ,  xK_b                    ), spawn myBrowserAlt)
    , ((modm                  ,  xK_m                    ), spawn myMusicplayer)
    , ((modm                  ,  xK_e                    ), spawn myMail)

      -- prompts and menues
    , ((modm                  ,  xK_space                ), spawn("dmenu_run"))
    , ((modm .|. shiftMask    ,  xK_a                    ), bringMenu)
    , ((modm                  ,  xK_x                    ), spawn "~/.config/xmenu/xmenu.sh")
    , ((modm .|. controlMask  ,  xK_p                    ), spawn "~/scripts/dpower")
    , ((modm .|. shiftMask    ,  xK_p                    ), spawn "passmenu")

       -- kill compile and exit
    , ((modm                  ,  xK_q                    ), kill)
    , ((modm                  ,  xK_c                    ), spawn "xmonad --recompile; xmonad --restart")
    , ((modm .|. shiftMask    ,  xK_c                    ), io (exitWith ExitSuccess))

      -- layout change focus
    , ((modm                  ,  xK_Tab                  ), windows W.focusDown)
    , ((modm                  ,  xK_j                    ), windows W.focusDown)
    , ((modm                  ,  xK_k                    ), windows W.focusUp)
    , ((modm                  ,  xK_Return               ), windows W.swapMaster)

      -- shift windows
    , ((modm .|. shiftMask    ,  xK_j                    ), windows W.swapDown)
    , ((modm .|. shiftMask    ,  xK_k                    ), windows W.swapUp)

      -- change layoout
    , ((modm                  ,  xK_n                    ), sendMessage NextLayout)
    , ((modm .|. shiftMask    ,  xK_n                    ), setLayout $ XMonad.layoutHook conf)

      -- resize windows
    , ((modm                  ,  xK_h                    ), sendMessage Shrink)  
    , ((modm                  ,  xK_l                    ), sendMessage Expand)
    , ((modm .|. controlMask  ,  xK_t                    ), withFocused $ windows . W.sink)

      -- gaps and struts
   , ((modm .|. controlMask  ,  xK_f                    ), sequence_ [sendMessage  ToggleStruts ,toggleScreenSpacingEnabled, toggleWindowSpacingEnabled])
    , ((modm                  ,  xK_equal                ), incWindowSpacing 4)
    , ((modm                  ,  xK_minus                ), decWindowSpacing 4)
    , ((modm .|. shiftMask    ,  xK_equal                ), incScreenSpacing 4)
    , ((modm .|. shiftMask    ,  xK_minus                ), decScreenSpacing 4)

      -- screenshots
    , ((modm                  ,  xK_Print                ), spawn "~/scripts/sc")
    , ((modm .|. shiftMask    ,  xK_Print                ), spawn "~/scripts/sc -s")
    , ((modm .|. controlMask  ,  xK_Print                ), spawn "~/scripts/sc -cs")

      -- volume
    , ((0                     ,  xF86XK_AudioMute        ), spawn "amixer sset Master toggle")
    , ((0                     ,  xF86XK_AudioRaiseVolume ), spawn "amixer sset Master 5%+")
    , ((modm                  ,  xF86XK_AudioRaiseVolume ), spawn "amixer sset Master 10%+")
    , ((0                     ,  xF86XK_AudioLowerVolume ), spawn "amixer sset Master 5%-")
    , ((modm                  ,  xF86XK_AudioLowerVolume ), spawn "amixer sset Master 10%-")

      -- backlight 
    , ((0                     ,  xF86XK_MonBrightnessUp  ), spawn "xbacklight -inc +5")    
    , ((modm                  ,  xF86XK_MonBrightnessUp  ), spawn "xbacklight -inc +10")    
    , ((0                     ,  xF86XK_MonBrightnessDown), spawn "xbacklight -dec +5")   
    , ((modm                  ,  xF86XK_MonBrightnessDown), spawn "xbacklight -dec +10")   
    ]
    ++
      --change workspace
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
     --move windows to workspaces
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))                                                    
        | (key, sc) <- zip [xK_w, xK_e, xK_i
        ] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]  
-------------------------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))    -- mod-button1, Set the window to floating mode and move by dragging
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))                         -- mod-button2, Raise the window to the top of the stack
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))  -- mod-button3, Set the window to floating mode and resize by dragging
    ]

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Layouts:

myLayout = avoidStruts( Tall 1 (3/100) (1/2) ||| Full ||| simpleTabbed)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Window rules:

myManageHook = composeAll
    [ manageDocks
     ,className  =? "Steam"       --> doFloat
     ,className  =? "Pavucontrol" --> doFloat
     ,className  =? "vlc" --> doFloat
     ,className  =? "Picture in picture" --> doFloat
     ,className  =? "Freetube" --> doFloat
     ,className  =? "VirtualBox Manager" --> doFloat
     ,className =? "Steam"     --> doShift ( myWorkspaces !! 2 )
     ,className =? "csgo_linux64"     --> doShift ( myWorkspaces !! 3)]

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Event handling

myEventHook = mempty

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Status bars and logging for StdinReader 

--windowCount :: X (Maybe String)
--windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

_topXmobarPP h = xmobarPP {
    ppCurrent = xmobarColor "#50fa7b" "" . wrap "[" "]"
    , ppVisible = xmobarColor "#bd93f9" "" . wrap "" ""
    , ppHidden = xmobarColor "#f1fa8c" "" . wrap "" ""
    , ppHiddenNoWindows = xmobarColor "#c792ea" ""
    , ppSep = "<fc=#ffffff> | </fc>" 
    , ppTitle = xmobarColor "#8be9fd" "" . shorten 60
    , ppLayout = xmobarColor "#ff79c6" ""
    , ppOutput = hPutStrLn h
    --, ppExtras  = [windowCount]
    , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]}
    

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Startup hook

myStartupHook = return ()

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
main :: IO ()
main = do 
  _topXmobar <- spawnPipe "xmobar -x 0 /home/sam/.config/xmobar/xmobar.config"
  xmonad $ docks def
     {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys,
        layoutHook         = spacingRaw False (Border 0 6 0 6) True (Border 6 0 6 0) True $ smartBorders $ myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = dynamicLogWithPP $ _topXmobarPP _topXmobar,
        startupHook        = myStartupHook
    }
 
