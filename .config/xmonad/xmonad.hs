--imports
import XMonad
import System.Exit
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Actions.Submap
import qualified XMonad.StackSet as W
import qualified Data.Map        as M


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--colors

black   = "#282a36"  -- black
red     = "#ff5555"  -- red
green   = "#5af78e"  -- green
yellow  = "#f1fa8c"  -- yellow
blue    = "#57c7ff"  -- blue
magenta = "#ff6ac1"  -- magenta
cyan    = "#8be9fd"  -- cyan
white   = "#f1f1f0"  -- white
orange  = "#ffb86c"  -- orange
purple  = "#bd9cf9"  -- purple
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
myBrowser = "firefox"

myBrowserAlt :: String
myBrowserAlt = "qutebrowser"

myMail :: String
myMail = "st -e neomutt"

myMusicplayer :: String
myMusicplayer = "st -e cums"

myRssreader :: String
myRssreader = "st -e newsboat"

myIDE :: String
myIDE = "emacs"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth = 2

myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myFocusedBorderColor = magenta

--------------------------------------------------------------------------------------------------------------------
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
    , ((modm                  ,  xK_m                    ), spawn myMail)
    , ((modm .|. shiftMask    ,  xK_m                    ), spawn myMusicplayer)
    , ((modm                  ,  xK_r                    ), spawn myRssreader)
    , ((modm                  ,  xK_e                    ), spawn myIDE)
    , ((modm                  ,  xK_space                ), spawn("dmenu_run"))
    , ((modm                  ,  xK_x                    ), spawn("~/.config/xmenu/xmenu.sh"))

       -- kill compile exit lock
    , ((modm                  ,  xK_q                    ), kill)
    , ((modm                  ,  xK_c                    ), spawn "xmonad --recompile; xmonad --restart")
    , ((modm .|. shiftMask    ,  xK_c                    ), io (exitWith ExitSuccess))
    , ((modm .|. shiftMask    ,  xK_x                    ), spawn "~/scripts/lock")

      -- layout change focus
    , ((modm                  ,  xK_Tab                  ), windows W.focusDown)
    , ((modm                  ,  xK_j                    ), windows W.focusDown)
    , ((modm                  ,  xK_k                    ), windows W.focusUp)

      -- shift windows
    , ((modm .|. shiftMask    ,  xK_j                    ), windows W.swapDown)
    , ((modm .|. shiftMask    ,  xK_k                    ), windows W.swapUp)
    , ((modm                  ,  xK_Return               ), windows W.swapMaster)

      -- change layoout
    , ((modm                  ,  xK_n                    ), sendMessage NextLayout)
    , ((modm .|. shiftMask    ,  xK_n                    ), setLayout $ XMonad.layoutHook conf)

      -- resize windows
    , ((modm                  ,  xK_h                    ), sendMessage Shrink)  
    , ((modm                  ,  xK_l                    ), sendMessage Expand)
    , ((modm .|. controlMask  ,  xK_t                    ), withFocused $ windows . W.sink)

      -- gaps and struts
    , ((modm .|. controlMask  ,  xK_f                    ), sequence_ [sendMessage  ToggleStruts ,toggleScreenSpacingEnabled, toggleWindowSpacingEnabled])
    , ((modm                  ,  xK_equal                ), sequence_[incWindowSpacing 2, incScreenSpacing 2])
    , ((modm                  ,  xK_minus                ), sequence_[decWindowSpacing 2, decScreenSpacing 2])

      -- screenshots
    , ((modm                  ,  xK_Print                ), spawn "~/scripts/sc")
    , ((modm .|. shiftMask    ,  xK_Print                ), spawn "~/scripts/sc -s")
    , ((modm .|. controlMask  ,  xK_Print                ), spawn "~/scripts/sc -cs")

      -- volume
    , ((0                     ,  xF86XK_AudioMute        ), spawn "amixer sset Master toggle && kill -SIGUSR2 `pidof xmobar`")
    , ((0                     ,  xF86XK_AudioRaiseVolume ), spawn "amixer sset Master 5%+ && kill -SIGUSR `pidof xmobar`")
    , ((modm                  ,  xF86XK_AudioRaiseVolume ), spawn "amixer sset Master 10%+ && kill -SIGUSR `pidof xmobar`")
    , ((0                     ,  xF86XK_AudioLowerVolume ), spawn "amixer sset Master 5%- && kill -SIGUSR `pidof xmobar`")
    , ((modm                  ,  xF86XK_AudioLowerVolume ), spawn "amixer sset Master 10%- && kill -SIGUSR `pidof xmobar`")

      -- backlight 
    , ((0                     ,  xF86XK_MonBrightnessUp  ), spawn "xbacklight -inc +5 && kill -SIGUSR `pidof xmobar`")    
    , ((modm                  ,  xF86XK_MonBrightnessUp  ), spawn "xbacklight -inc +10 && kill -SIGUSR `pidof xmobar`")    
    , ((0                     ,  xF86XK_MonBrightnessDown), spawn "xbacklight -dec +5 && kill -SIGUSR `pidof xmobar`")   
    , ((modm                  ,  xF86XK_MonBrightnessDown), spawn "xbacklight -dec +10 && kill -SIGUSR `pidof xmobar`")   
    ]
    ++
      --change workspace
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
     --move windows to workspaces
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))                                                    
        | (key, sc) <- zip [xK_v, xK_o, xK_z] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]  
    ++
    -- prompt submap
     [((modm, xK_p),     submap . M.fromList $
       [ ((0, xK_s),     spawn "~/scripts/dpower")
       , ((0, xK_p),     spawn "~/scripts/passmenu")
       , ((0, xK_m),     spawn "~/scripts/dman")
       ])]
-------------------------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events

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
     ,title  =? "Picture in Picture" --> doFloat
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
    ppCurrent = xmobarColor green "" . wrap "[" "]"
    , ppVisible = xmobarColor purple "" . wrap "" ""
    , ppHidden = xmobarColor yellow "" . wrap "" ""
    , ppHiddenNoWindows = xmobarColor purple ""
    , ppSep = "<fc=white> | </fc>"
    , ppTitle = xmobarColor cyan "" . shorten 60
    , ppLayout = xmobarColor magenta ""
    , ppOutput = hPutStrLn h
    --, ppExtras  = [windowCount]
    , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]}
    

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Startup hook

myStartupHook = return ()

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- main

main :: IO ()
main = do 
  _topXmobar <- spawnPipe "xmobar -x 0 /home/sam/.config/xmobar/xmobar.config"
  xmonad $ docks def
     {
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

